setEnvVariableIfNotSet SKYLINKJS_ROOT_DIR $PROJECT_DIR/SkylinkJS

alias cdsky='cd $SKYLINKJS_ROOT_DIR'

function startSkylink
{
  cdsky
  pm2 start server.js --name skylinkJS
}

# grep in signalling code excluding some directories
function skygrep 
{
    cdsky
    grep  --recursive --exclude-dir={publish,certificates,doc,doc-style,tests,node_modules,demo} "$1" .
}
