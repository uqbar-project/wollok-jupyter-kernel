globalThis.process = {
    env: {},

    nextTick(callback, ...args) {
        Promise.resolve().then(() => callback(...args))
    },

    version: 'v18.0.0',
    versions: {
        node: '18.0.0'
    },

    cwd() {
        return '/'
    },

    browser: false,
    platform: 'browser',
    argv: [],
    stdout: {
        write: (msg) => console.log(msg)
    },
    stderr: {
        write: (msg) => console.error(msg)
    }
}
  
const { Evaluation, fromJSON, interprete, Interpreter, link, parse, REPL, WOLLOK_FILE_EXTENSION, WRE, WRENatives } = require("wollok-ts")

// Función REPL
function repl(expression) {
    const replPackage = parse.File(REPL + '.' + WOLLOK_FILE_EXTENSION).tryParse("object pepita {}")
    const environment = link([replPackage], fromJSON(WRE))
    const interpreter = new Interpreter(Evaluation.build(environment, WRENatives))
    const { error, errored, result} = interprete(interpreter, expression)
    return errored ? error : result
}

module.exports = {
    repl
}
