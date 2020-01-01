exports.setCloseHandler = function(readline) {
  return function(callback) {
    return function() {
      readline.removeAllListeners("close");
      readline.on("close", callback);
    };
  };
};
