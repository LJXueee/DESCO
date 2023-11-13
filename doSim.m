function out = doSim(model,simu_mode)
%DOSIM 此处显示有关此函数的摘要
%   此处显示详细说明
%   model = sampleModel1077
%   simu_mode = normal/SIL
sprintf('Simulation model is %s and mode is %s\n',model,simu_mode)
%   close_system(model,0)
%     open_system(model)
    %% model confige and logging signals
    configParam(model)
    save_system(model);

    %%
    % Run a normal or SIL mode simulation.
    %sim(model,'TimeOut','300')
    set_param(model,'SimulationMode',simu_mode)
    % 对 Simulink 模型进行仿真
    sim_output = sim(model,'StopTime',cfg.MODEL_RUNTIME,'TimeOut',cfg.MODEL_TIMEOUT);
    % 比较仿真输出, isprop验证对象是否有'yout'属性
    if isprop(sim_output,'yout')
        out.yout = sim_output.yout;
        out.logsOut = sim_output.logsOut;
    else
        out.logsOut = sim_output.logsOut;
    end
    out.tout = sim_output.tout;
end

