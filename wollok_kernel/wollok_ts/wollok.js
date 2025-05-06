const wollok = require("wollok-ts")

// Función REPL
function repl(expression) {
    const interpreter = wollok.buildEnvironment("REPL")  // Usamos la función real buildEnvironment
    return wollok.interprete(interpreter, expression)
}

module.exports = {
    repl
}
