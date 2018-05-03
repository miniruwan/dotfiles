setEnvVariableIfNotSet SKYLINKJS_ROOT_DIR $PROJECT_DIR/SkylinkJS

function startSkylink
{
  cd $SKYLINKJS_ROOT_DIR
  pm2 start server.js --name skylinkJS
}
