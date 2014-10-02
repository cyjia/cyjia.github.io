module.exports = function(grunt) {
  grunt.initConfig({
    emberTemplates: {
      compile:{
        options: {
          concatenate: true,
          templateBasePath: /src\/templates\//
        },
        files: {
          "js/templates/templates.js": ["src/templates/**/*.hbs"]
        }
      }
    },
    coffee: {
      compile: {
        options: {
          join: true
        },
        files: {
          "js/app.js": ["src/**/*.coffee"]
        }
      }
    },
    stylus: {
      compile: {
        options: {
          paths: ['src/style.styl'],
        },
        files: {
          'style.css': 'src/style.styl'
        }
      }
    },
    watch: {
      emberTemplates: {
        files: "src/templates/**/*.hbs",
        tasks: ['emberTemplates']
      },
      coffee: {
        files: "src/**/*.coffee",
        tasks: ['coffee']
      },
      stylus: {
        files: "src/style.styl",
        tasks: ['stylus']
      }
    }
  });

  grunt.loadNpmTasks('grunt-ember-templates');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-stylus');

  grunt.registerTask('default', ['emberTemplates']);
};
