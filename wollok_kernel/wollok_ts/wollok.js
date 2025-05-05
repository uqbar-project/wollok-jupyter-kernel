/* Polyfill for crypto.getRandomValues */
// Simular 'require' en entornos sin Node.js
// Guardamos el require original, si existe
// const originalRequire = typeof require === 'function' ? require : null

// // Reescribimos require para interceptar solo 'crypto'
// function require(moduleName) {
//   if (moduleName === 'crypto') {
//     return {
//       randomBytes: function (size) {
//         const buffer = new Uint8Array(size)
//         for (let i = 0; i < size; i++) {
//           buffer[i] = Math.floor(Math.random() * 256)
//         }
//         return buffer
//       },
//       getRandomValues: function (typedArray) {
//         for (let i = 0; i < typedArray.length; i++) {
//           typedArray[i] = Math.floor(Math.random() * 256)
//         }
//         return typedArray
//       }
//     }
//   }

//   if (originalRequire) {
//     return originalRequire(moduleName) // Usamos el require real si está disponible
//   }

//   throw new Error(`Module "${moduleName}" not found, and no fallback 'require' exists.`)
// }
// Fin del polyfill  

function repl(expression) {
    // const wollok = require("wollok-ts")
    // const interpreter = buildInterpreter()
    // return wollok.interprete(interpreter, expression)
    return expression
}

module.exports = repl
