#Anaconda recipes for OpenSesame
This repository contains recipes for the [conda-build](http://conda.pydata.org/docs/building/build.html) tool which can be used to create anaconda packages of the libraries on which [OpenSesame](https://github.com/smathot/OpenSesame) depends. For now, these packages will be stored in the [Anaconda Cloud's CogSci channel](https://anaconda.org/CogSci). This repository and manual are mainly meant for the maintainers of these recipes/packages and do not really have a purpose for the public.

##Installing the packages built from these recipes
These packages should be readily available in Anaconda for installation from the CogSci channel. For instance, to install OpenSesame in an Anaconda environment, it should be sufficient to issue the command

    conda install -c cogsci python-opensesame

This will install OpenSesame plus the basic dependencies it requires to run. It does not include optional dependencies, or libraries required to make the experiment backends function. We plan to create an Anaconda environment in the near future that does contain everything.

##Building a recipe
First, make sure you are familiar with the basics of the conda-build tool by reading its documentation: http://conda.pydata.org/docs/building/build.html. The basic workflow for building these recipes is as follows.

1. Make sure you have conda-build installed in your Anaconda environment.

    `conda install conda-build`

2. Go to the folder in which these recipes are located and build a package by invoking

    `conda-build <package-name> -c cogsci`

    where the -c flag indicates that the cogsci channel should be searched for additional dependencies (e.g. packages from this recipes repository that already have been built)

3. The above command only builds the package for the currently active python version. If you want to create builds for other python versions, you will have to add the `--python <PY_VER>` flag, for example, to build for python 3.4 the command is.

    `conda-build <package-name> -c cogsci --python 3.4`

    A useful tool for automating this process of building for multiple python versions is [conda-build-all](https://github.com/SciTools/conda-build-all), but I have not found a way yet to indicate to this tool to use external channels, as can be done with the normal conda-build with `-c cogsci`.

    After the build has been completed it will be saved at

    `path/to/anaconda/conda-bld/<your-platform>`

    for instance, if anaconda is installed in you homedir, and you have just built the python-opensesame package for python 3.5, you will find your build at

    `~/anaconda/conda-bld/osx-64/python-opensesame-3.1.0-py35_0.tar.bz2`

    (where of course the version number 3.1.0 can differ depending on which version you are packaging)

4. If your packages only contain python code and assets (and do not depend on acompanying compiled c-libraries), you can convert these packages for other platforms by using the `conda convert` command. For instance, if you would like to convert all python-opensesame packages for all platforms, you can issue the command

    `conda convert python-opensesame-3.1.0-py* -p all -o ~/build/python-opensesame`

    The `-p` flag indicates the platform for which the current package should be converted (e.g. win-32, linux-64) which in this example is all platforms.  
    The `-o` flag specifies an output folder in which the converted packages should be placed. If the -o flag is ommitted, the output folder will be the current working directory.

    After the process is completed, you can navigate to the output folder with `cd ~/build/python-opensesame`, you will see the folders linux-32, linux-64, osx-64, win-32 and win-64. Each of these folders will contain packages for each python version.

6. You can now choose to upload these packages to Anaconda cloud. Make sure you are logged in by issuing `anaconda login`. You can then upload all these packages to the cogsci channel at once by issuing

    `anaconda upload */* -u cogsci`

    if you omit the `-u cogsci` flag the package will be uploaded to your own, single-user, account. Optionally, cou also add the --label flag to add a label to the upload. For instance, of you upload an alpha or beta version you could add

    `anaconda upload */* -u cogsci --label alpha`

7. Once this is done, your package should now be available for download and installation from the anaconda cloud, with the command 

    `conda install -c cogsci <package_name>`


