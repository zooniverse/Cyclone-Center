

(function(/*! Stitch !*/) {
  if (!this.specs) {
    var modules = {}, cache = {}, require = function(name, root) {
      var path = expand(root, name), module = cache[path], fn;
      if (module) {
        return module.exports;
      } else if (fn = modules[path] || modules[path = expand(path, './index')]) {
        module = {id: path, exports: {}};
        try {
          cache[path] = module;
          fn(module.exports, function(name) {
            return require(name, dirname(path));
          }, module);
          return module.exports;
        } catch (err) {
          delete cache[path];
          throw err;
        }
      } else {
        throw 'module \'' + name + '\' not found';
      }
    }, expand = function(root, name) {
      var results = [], parts, part;
      if (/^\.\.?(\/|$)/.test(name)) {
        parts = [root, name].join('/').split('/');
      } else {
        parts = name.split('/');
      }
      for (var i = 0, length = parts.length; i < length; i++) {
        part = parts[i];
        if (part == '..') {
          results.pop();
        } else if (part != '.' && part != '') {
          results.push(part);
        }
      }
      return results.join('/');
    }, dirname = function(path) {
      return path.split('/').slice(0, -1).join('/');
    };
    this.specs = function(name) {
      return require(name, '');
    }
    this.specs.define = function(bundle) {
      for (var key in bundle)
        modules[key] = bundle[key];
    };
    this.specs.modules = modules;
    this.specs.cache   = cache;
  }
  return this.specs.define;
}).call(this)({
  "controllers/classifier": function(exports, require, module) {(function() {
  var require;

  require = window.require;

  describe('Classifier', function() {
    var Classifier;
    Classifier = require('controllers/classifier');
    return it('can noop', function() {});
  });

}).call(this);
}, "controllers/profile": function(exports, require, module) {(function() {
  var require;

  require = window.require;

  describe('Profile', function() {
    var Profile;
    Profile = require('controllers/profile');
    return it('can noop', function() {});
  });

}).call(this);
}, "controllers/stats_dialog": function(exports, require, module) {(function() {
  var require;

  require = window.require;

  describe('StatsDialog', function() {
    var StatsDialog;
    StatsDialog = require('controllers/statsdialog');
    return it('can noop', function() {});
  });

}).call(this);
}
});

require('lib/setup'); for (var key in specs.modules) specs(key);