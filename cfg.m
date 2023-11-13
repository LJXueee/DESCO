classdef cfg
    %CFG 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties(Constant = true)
        % ISUSENOTHING = false;
        ISUSENOTHING = false;  
        ISUSINGRANDOM = false; 
        EMI_NUM = 3; % 生成变体模型数量
        Max_attempts = 10; % 最大尝试次数
        MaxPartsNum = 20; 
        MODEL_TIMEOUT = 300; 
        ISCHECK = false; 
        MODEL_RUNTIME = '10.0'; 
        % seedpath = 'F:\Simulink\C2C-Testing-main-ljx\corpus_seed' % 种子文件的路径
        INPUTFILE = 'input\'; 
        NO_OUTPUT = '.\result\noyout'; 
        DIFF_FILE = '.\result\different'; 
        IDENDICAL = '.\result\identical';
        FAILDIR = '.\result\genFail\';         
        SILFAILDIR = '.\result\SILFail\';      
        CacheFolder = 'F:\Simulink\a\a-shiyan\ljx-perfect\ljx\ljx_src\result\code';
        CodeGenFolder = 'F:\Simulink\a\a-shiyan\ljx-perfect\ljx\ljx_src\result\codeGen'; 
        % Normal 和SIL是模型的两种仿真模式
        Normal = 'normal';
        SIL = 'Software-in-the-Loop (SIL)';
    end
    
    methods(Static)
    end
end

