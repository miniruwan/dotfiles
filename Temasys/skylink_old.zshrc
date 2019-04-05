setEnvVariableIfNotSet OLD_SKYLINKJS_ROOT_DIR $PROJECT_DIR/SkylinkJS

alias cdoldsky='cd $OLD_SKYLINKJS_ROOT_DIR'

function startOldSkylink
{
  cd $OLD_SKYLINKJS_ROOT_DIR/
  pm2 start server.js --name oldSkylinkJS
}

# grep in signalling code excluding some directories
function oldskygrep 
{
    cdoldsky
    grep  --recursive --exclude-dir={publish,certificates,doc,doc-style,tests,node_modules,demo} "$1" .
}
