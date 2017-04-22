/**
 * Created by xet on 22/04/2017.
 */
module.exports = function (grunt) {

    var srcDir = './';
    var buildDir = srcDir + 'build/';
    var templatesDir = srcDir + 'templates/';
    var dataDir = srcDir + 'data/';

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        clean: [buildDir],
        browserSync: {
            dev: {
                bsFiles: {
                    src: [
                        buildDir + 'css/**/*.css',
                        buildDir + '**/*.html',
                        buildDir + 'js/**/*.js',
                        buildDir + 'img/'
                    ]
                },
                options: {
                    watchTask: true,
                    notify: false,
                    logLevel: "debug",
                    server: {
                        baseDir: buildDir
                    }
                }
            }
        },
        pug: {
            options: {
                pretty: true
            },
            homepage: {
                options: {
                    data: function (dest, src) {
                        return {
                            pageTitle: 'Emanuele Tessore\'s Resume',
                            resumee: require(dataDir + 'resume.json')
                        };
                    }
                },
                files: [
                    {
                        src: templatesDir + 'index.pug',
                        dest: buildDir + 'index.html'
                    }
                ]
            },
        },
        watch: {
            templates: {
                files: [
                    srcDir + 'templates/**/*.pug',
                    srcDir + 'templates/**/*.jade',
                    srcDir + 'mixins/**/*.jade',
                    srcDir + 'mixins/**/*.pug'
                ],
                tasks: ['pug']
            },
            data: {
                files: [dataDir + '**'],
                tasks: ['compile']
            },
            grunt: {
                files: ['Gruntfile.js'],
                tasks: ['compile']
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-pug');
    grunt.loadNpmTasks('grunt-browser-sync');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('compile', ['pug']);
    grunt.registerTask('listen', ['browserSync', 'watch']);
    grunt.registerTask('bs', ['browserSync']);
    grunt.registerTask('default', ['compile', 'listen']);
};