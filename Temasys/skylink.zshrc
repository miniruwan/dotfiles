setEnvVariableIfNotSet SKYLINKJS_ROOT_DIR $PROJECT_DIR/web-sdk-2.x

alias cdsky='cd $SKYLINKJS_ROOT_DIR'

function startSkylink
{
  cd $SKYLINKJS_ROOT_DIR/demos/reactjs
  pm2 start scripts/start.js --name skylinkJS
}

# grep in signalling code excluding some directories
function skygrep 
{
    cdsky
    grep  --recursive --exclude-dir={publish,certificates,doc,doc-style,tests,node_modules,demo} "$1" .
}
