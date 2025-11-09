Install=1


export R_LIBS_USER="$HOME/__checkout/proLFQuaPackageBuildScripts/r-site-library_prolfqua"
export R_LIBS_SITE="$HOME/__checkout/proLFQuaPackageBuildScripts/r-site-library_prolfqua"
mkdir $HOME/__checkout/proLFQuaPackageBuildScripts/test_build_prolfqua


if [[ $Install = 1 ]]
then
    mkdir $R_LIBS_USER
    rm -Rf $HOME/__checkout/proLFQuaPackageBuildScripts/r-site-library_prolfqua/*
    rm -Rf $HOME/__checkout/proLFQuaPackageBuildScripts/test_build_prolfqua/*
    

    R --vanilla -e "install.packages(c('remotes','BiocManager','kableExtra') , repos = 'https://cloud.r-project.org' )"
    R --vanilla -e "install.packages('pander', repos = 'https://cloud.r-project.org' )"
    # R --vanilla -e "remotes::install_gitlab('wolski/prolfquadata', host='gitlab.bfabric.org')"
    Rscript --vanilla InstallDependencies.R fgcz prolfqua reinst > InstallDependencies_prolfqua.log 2>&1
else
  echo "trash"
fi


rm -Rf $HOME/__checkout/proLFQuaPackageBuildScripts/test_build_prolfqua/*
Rscript --vanilla runBuild.R fgcz prolfqua Modelling2R6 > runBuild_prolfqua.log 2>&1

R --vanilla -e "install.packages('igraph', repos = 'https://cloud.r-project.org' )"


R --vanilla -e "BiocManager::install(c('MSstats','msdata', 'msqrob2', 'QFeature'))"
R --vanilla -e "devtools::install_gitlab('wolski/prolfquadata', host='https://gitlab.bfabric.org')"
R --vanilla -e "devtools::install_github('prolfqua/prolfquapp')"


mkdir $HOME/__checkout/proLFQuaPackageBuildScripts/test_build_prolfquabenchmark
rm -Rf $HOME/__checkout/proLFQuaPackageBuildScripts/test_build_prolfquabenchmark/*
Rscript runBuild.R prolfqua prolfquabenchmark main  > runBuild_prolfquabenchmark.log 2>&1


