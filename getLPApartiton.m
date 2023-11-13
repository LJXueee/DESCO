function partition = getLPApartiton(sys,varargin)
    
    % 打开Simulink模型
    open_system(sys);
    
    % 获取模型中顶层模块的所有连线
    all_lines = find_system(sys, 'FindAll', 'on','SearchDepth',1, 'type', 'line');

    load_system(sys);
    BlockPaths = getfullname(Simulink.findBlocks(sys,Simulink.FindOptions('SearchDepth',1)));

    % 为顶层模块设置标签
    for i = 1:length(BlockPaths)
        set_param(BlockPaths{i}, 'Tag',  num2str(i));
    end
    
    values = 1:numel(BlockPaths);

    valuemap = containers.Map(values,BlockPaths);
    
    % 显示创建的映射
    % disp(mymap);    
    
    % 创建一个有向图对象
    G = digraph();
    
    % 遍历所有连线，创建有向边
    for i = 1:length(all_lines)
        line = all_lines(i);

        % 获取模块名称
        src_block = get_param(line, 'SrcBlockHandle');
        dst_block = get_param(line, 'DstBlockHandle');

        srcTag = get_param(src_block, 'Tag');
        destTag = get_param(dst_block, 'Tag');

        % 获取源块和目标块的名称
        src_name = get_param(src_block, 'Name');
        dst_name = get_param(dst_block, 'Name');

        action_ports = find_system(src_block,'SearchDepth',1,  'BlockType', 'ActionPort');

        if isequal(get_param(src_block, 'BlockType'), 'If')           
            % 添加有向边到图中
            G = addedge(G, srcTag, destTag, 2);
            G = addedge(G, destTag, srcTag, 0);
        elseif ~isempty(action_ports) 
            % 添加有向边到图中
            G = addedge(G, srcTag, destTag, 2);
            G = addedge(G, destTag, srcTag, 0);
        else
            % 添加有向边到图中
            G = addedge(G, srcTag, destTag, 1);
            G = addedge(G, destTag, srcTag, 0);
        end
    end
    
    % 保存有向图数据到文本文件
    fileID = fopen('directed_graph.txt', 'w');
    % fprintf(fileID, 'Source\tTarget\tWeight\n');
    for i = 1:numedges(G)
        fprintf(fileID, '%s\t%s\t%d\n', G.Edges.EndNodes{i, 1}, G.Edges.EndNodes{i, 2}, G.Edges.Weight(i));
    end
    fclose(fileID);

    % 可视化有向图G
    % plot(G, 'LineWidth', 2);
    
    % 关闭Simulink模型
    % close_system(sys, 0);
    
    % 在MATLAB中调用Python主函数
    [status, output] = system('python LPA.py');
    
    data = regexp(output, '\[(.*?)\]', 'tokens');
    
    % 将数据保存到元胞数组中
    data_cell = cell(1, numel(data));
    for i = 1:numel(data)
        data_cell{i} = str2num(data{i}{1});
    end
    
    % 显示元胞数组
    disp(data_cell);

    m = 1;
    for i=1:numel(data_cell)
        if numel(data_cell{1,i}) > 2
            partition{m,:}= valuemap.values(num2cell(data_cell{1,i}));
            m = m + 1;
        end
    end

end


