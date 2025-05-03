const wollok = require("wollok-ts")

module.exports = function repl(expression) {
    const interpreter = buildInterpreter()
    return wollok.interprete(interpreter, expression)
}
