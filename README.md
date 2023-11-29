# DESCO
## [DESCO]Detecting Embedded Code Generation Bugs in Simulink via Partitioning Transformation and Differential Testing
**Matlab env dependencies:**
1. **Matlab 2023a**
2. **Simulink default**
3. **Matlab Coder**
4. **Simulink Coder**
5. **Embedded Coder**
6. **python 3.6.13**
***
### Datatest:
If you wish to use publicly available datasets, you can access *[third-party datasets](https://zenodo.org/records/8217495)*. If you wish to use a random model, 
you can visit *[Dr. Shafiul's homepage](https://github.com/verivital/slsf_randgen/wiki)*. Get the latest experimental model generation tools SLFORGE/CYFUZZ

##### [SLforge: Automatically Finding Bugs in a Commercial Cyber-Physical Systems Development Tool](https://github.com/verivital/slsf_randgen/wiki#getting-slforge)
**The format of the model is divided into mdl and slx according to the Simulink standard. If you use some third-party open source models, make sure that the dependencies 
between the models and the data are loaded into your memory. We do not recommend using third-party models in unfiltered conditions, which will cause your computer
to crash abnormally. Please be careful**
***
## Our Works
Simulink is MathWorks' Cyber-Physical Systems (CPS) development tool, widely used across various domains including automotive, aerospace, and healthcare. It enables non-software engineers to rapidly build models by adding modular block diagrams. When a Simulink model meets requirements, engineers can use automatic code generation tools, such as Embedded Coder, to convert it into embedded code (e.g., C source code), deployable in safety-critical applications. However, due to errors or incorrect implementations in code generation, unexpected behaviors in the target application may arise, posing safety risks. In this paper, we introduce DESCO, the first differential testing method based on the partitioning of CPS modules according to the model's wiring structure. DESCO considers the closeness of connections between CPS modules for partitioning, aiming to generate Simulink models that better conform to partitioning requirements and are more diverse and complex. It thoroughly validates the code generation process, uncovering errors in the code generation. The experiments demonstrate that DESCO outperforms existing methods significantly. Currently, 16 code generation bugs have been identified, with 12 of them confirmed.

DESCO consists of three components: preprocessing, equivalent embedded
code generation, and differential testing. 
### Preprocessing
During the preprocessing phase, DESCO converts the seed Simulink model into a directed graph structure.
For generated SLforge or realistic models, place them in the `courpus_seed` folder. At the command line, type: ```ModelProcessing```. The results will be displayed in the `directed_graph.txt` file.


### Equivalent embedded code generation
For the generated `directed_graph.txt` file, call the `LPA.py` file to partition the model, and use the `CombSubsystem.m` file to build the partitions into subsystems to generate equivalent variant models.


### Differential testing
In this component, we use the `Comparition.m` file to perform differential testing of equivalent models to detect embedded code generation bugs.

***

### Specifically, if you want to use our model quickly, some steps need to be done.


First, you need to put the seed models in the folder `courpus_seed`.

Second, you should configure the `cfg.m` file, in which you can modify the files and intermediate file paths you use to save the generated code, as well as the number of variant models to be generated.

Third, add the `courpus_seed` folder to the working path, which is set to ```addpath(Seed_Model_Path)```

In the end, when all of the above preparation is complete, you simply enter ```ModelProcessing``` on the Matlab command line to launch the program and begin the model partitioning and variant process.This will help you get started with DESCO tools.

#### Introduction to each code file
`ReadModel.m`: Reading all seed models in the `courpus_seed` folder

`getLPApartiton.m`: Constructing the seed model as a directed graph

`LPA.py`: Partitioning the model based on the directed graph

`sysloop.m`: Getting information about the partitions that make up the algebraic ring

`CombSubsystem.m`: Building partitions into subsystems to generate variant models

`configParam.m`: Setting model parameters

`Comparition.m`: Comparing simulation results of models through differential testing


note: When the program is interrupted due to some accident, you can continue the experiment by modifying the loop order 'i' in the file ```ModelProcessing.m``` according to the progress that has been completed before.
***

## Here are the details of these bugs.
These errors in the error file can be reproduced using Matlab R2023a.

You can find all bug files in path `CodeG-Bug`.

The 'CodeG-Bug' folder contains the compressed package of all bug-related information, including the model that triggers the bug, the model equivalent model, the comparison diagram of the execution results obtained by using the data inspector, and the detailed introduction of the bugs.

06416738 Data anomalies caused by the modules Gain and Product

06489487 Inconsistent SIL simulation results caused by the equivalent model's Sqrt block

06492098 Layered model SIL simulation crash

06525181 SIL simulation results incorrect due to the Sine Wave module

06530095 The Trigonometry module causes inconsistent simulation results

06571913 The MinMax module causes inconsistent simulation results in different modes

06572124 Erroneous SIL simulation data caused by the White Noise module

06578782 The DiscretePulseGenerator module leads to incorrect SIL simulation

06583023 Inconsistent SIL simulation data in models containing the Difference module

06583457 The Band-Limited White Noise module generates inconsistent output signals under different modes

06583533 The Transfer Fcn Real Zero module results in incorrect output signal data in SIL simulation

06596745 The DiscreteStateSpace module leads to incorrect SIL simulation output data
***
**Thanks to MathWorks consultants Esther Yi，Gu Bill and Zhongju Zhu for their support. We've had so much help from MathWorks staff in finding and confirming bugs that we can't list them all. I would like to express my gratitude here.**
