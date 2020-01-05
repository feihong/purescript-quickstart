exports.onClose = function(readline) {
  return function(callback) {
    return function() {
      readline.on("close", callback);
    };
  };
};
