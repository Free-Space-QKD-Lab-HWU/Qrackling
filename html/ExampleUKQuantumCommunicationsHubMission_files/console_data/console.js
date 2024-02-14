/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 259);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__extends", function() { return __extends; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__assign", function() { return __assign; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__rest", function() { return __rest; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__decorate", function() { return __decorate; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__param", function() { return __param; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__metadata", function() { return __metadata; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__awaiter", function() { return __awaiter; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__generator", function() { return __generator; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__createBinding", function() { return __createBinding; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__exportStar", function() { return __exportStar; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__values", function() { return __values; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__read", function() { return __read; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__spread", function() { return __spread; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__spreadArrays", function() { return __spreadArrays; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__await", function() { return __await; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__asyncGenerator", function() { return __asyncGenerator; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__asyncDelegator", function() { return __asyncDelegator; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__asyncValues", function() { return __asyncValues; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__makeTemplateObject", function() { return __makeTemplateObject; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__importStar", function() { return __importStar; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__importDefault", function() { return __importDefault; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__classPrivateFieldGet", function() { return __classPrivateFieldGet; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__classPrivateFieldSet", function() { return __classPrivateFieldSet; });
/*! *****************************************************************************
Copyright (c) Microsoft Corporation.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
***************************************************************************** */
/* global Reflect, Promise */

var extendStatics = function(d, b) {
    extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return extendStatics(d, b);
};

function __extends(d, b) {
    extendStatics(d, b);
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
}

var __assign = function() {
    __assign = Object.assign || function __assign(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p)) t[p] = s[p];
        }
        return t;
    }
    return __assign.apply(this, arguments);
}

function __rest(s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
}

function __decorate(decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
}

function __param(paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
}

function __metadata(metadataKey, metadataValue) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(metadataKey, metadataValue);
}

function __awaiter(thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
}

function __generator(thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
}

function __createBinding(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}

function __exportStar(m, exports) {
    for (var p in m) if (p !== "default" && !exports.hasOwnProperty(p)) exports[p] = m[p];
}

function __values(o) {
    var s = typeof Symbol === "function" && Symbol.iterator, m = s && o[s], i = 0;
    if (m) return m.call(o);
    if (o && typeof o.length === "number") return {
        next: function () {
            if (o && i >= o.length) o = void 0;
            return { value: o && o[i++], done: !o };
        }
    };
    throw new TypeError(s ? "Object is not iterable." : "Symbol.iterator is not defined.");
}

function __read(o, n) {
    var m = typeof Symbol === "function" && o[Symbol.iterator];
    if (!m) return o;
    var i = m.call(o), r, ar = [], e;
    try {
        while ((n === void 0 || n-- > 0) && !(r = i.next()).done) ar.push(r.value);
    }
    catch (error) { e = { error: error }; }
    finally {
        try {
            if (r && !r.done && (m = i["return"])) m.call(i);
        }
        finally { if (e) throw e.error; }
    }
    return ar;
}

function __spread() {
    for (var ar = [], i = 0; i < arguments.length; i++)
        ar = ar.concat(__read(arguments[i]));
    return ar;
}

function __spreadArrays() {
    for (var s = 0, i = 0, il = arguments.length; i < il; i++) s += arguments[i].length;
    for (var r = Array(s), k = 0, i = 0; i < il; i++)
        for (var a = arguments[i], j = 0, jl = a.length; j < jl; j++, k++)
            r[k] = a[j];
    return r;
};

function __await(v) {
    return this instanceof __await ? (this.v = v, this) : new __await(v);
}

function __asyncGenerator(thisArg, _arguments, generator) {
    if (!Symbol.asyncIterator) throw new TypeError("Symbol.asyncIterator is not defined.");
    var g = generator.apply(thisArg, _arguments || []), i, q = [];
    return i = {}, verb("next"), verb("throw"), verb("return"), i[Symbol.asyncIterator] = function () { return this; }, i;
    function verb(n) { if (g[n]) i[n] = function (v) { return new Promise(function (a, b) { q.push([n, v, a, b]) > 1 || resume(n, v); }); }; }
    function resume(n, v) { try { step(g[n](v)); } catch (e) { settle(q[0][3], e); } }
    function step(r) { r.value instanceof __await ? Promise.resolve(r.value.v).then(fulfill, reject) : settle(q[0][2], r); }
    function fulfill(value) { resume("next", value); }
    function reject(value) { resume("throw", value); }
    function settle(f, v) { if (f(v), q.shift(), q.length) resume(q[0][0], q[0][1]); }
}

function __asyncDelegator(o) {
    var i, p;
    return i = {}, verb("next"), verb("throw", function (e) { throw e; }), verb("return"), i[Symbol.iterator] = function () { return this; }, i;
    function verb(n, f) { i[n] = o[n] ? function (v) { return (p = !p) ? { value: __await(o[n](v)), done: n === "return" } : f ? f(v) : v; } : f; }
}

function __asyncValues(o) {
    if (!Symbol.asyncIterator) throw new TypeError("Symbol.asyncIterator is not defined.");
    var m = o[Symbol.asyncIterator], i;
    return m ? m.call(o) : (o = typeof __values === "function" ? __values(o) : o[Symbol.iterator](), i = {}, verb("next"), verb("throw"), verb("return"), i[Symbol.asyncIterator] = function () { return this; }, i);
    function verb(n) { i[n] = o[n] && function (v) { return new Promise(function (resolve, reject) { v = o[n](v), settle(resolve, reject, v.done, v.value); }); }; }
    function settle(resolve, reject, d, v) { Promise.resolve(v).then(function(v) { resolve({ value: v, done: d }); }, reject); }
}

function __makeTemplateObject(cooked, raw) {
    if (Object.defineProperty) { Object.defineProperty(cooked, "raw", { value: raw }); } else { cooked.raw = raw; }
    return cooked;
};

function __importStar(mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result.default = mod;
    return result;
}

function __importDefault(mod) {
    return (mod && mod.__esModule) ? mod : { default: mod };
}

function __classPrivateFieldGet(receiver, privateMap) {
    if (!privateMap.has(receiver)) {
        throw new TypeError("attempted to get private field on non-instance");
    }
    return privateMap.get(receiver);
}

function __classPrivateFieldSet(receiver, privateMap, value) {
    if (!privateMap.has(receiver)) {
        throw new TypeError("attempted to set private field on non-instance");
    }
    privateMap.set(receiver, value);
    return value;
}


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


if (true) {
  module.exports = __webpack_require__(36);
} else {}


/***/ }),
/* 2 */,
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.FIND_PREV = exports.FIND_NEXT = exports.FIND_START = exports.URLS_PASTE = exports.URLS_YANK = exports.ZOOM_NEUTRAL = exports.ZOOM_OUT = exports.ZOOM_IN = exports.TAB_TOGGLE_READER = exports.TAB_DUPLICATE = exports.TAB_TOGGLE_PINNED = exports.TAB_UNPIN = exports.TAB_PIN = exports.TAB_RELOAD = exports.TAB_PREV_SEL = exports.TAB_LAST = exports.TAB_FIRST = exports.TAB_NEXT = exports.TAB_PREV = exports.TAB_REOPEN = exports.TAB_CLOSE_RIGHT = exports.TAB_CLOSE_FORCE = exports.TAB_CLOSE = exports.PAGE_HOME = exports.PAGE_SOURCE = exports.FOCUS_INPUT = exports.NAVIGATE_ROOT = exports.NAVIGATE_PARENT = exports.NAVIGATE_LINK_NEXT = exports.NAVIGATE_LINK_PREV = exports.NAVIGATE_HISTORY_NEXT = exports.NAVIGATE_HISTORY_PREV = exports.FOLLOW_START = exports.SCROLL_END = exports.SCROLL_HOME = exports.SCROLL_BOTTOM = exports.SCROLL_TOP = exports.SCROLL_PAGES = exports.SCROLL_HORIZONALLY = exports.SCROLL_VERTICALLY = exports.COMMAND_SHOW_ADDBOOKMARK = exports.COMMAND_SHOW_BUFFER = exports.COMMAND_SHOW_WINOPEN = exports.COMMAND_SHOW_TABOPEN = exports.COMMAND_SHOW_OPEN = exports.COMMAND_SHOW = exports.ADDON_TOGGLE_ENABLED = exports.ADDON_DISABLE = exports.ADDON_ENABLE = exports.CANCEL = void 0;
exports.isNRepeatable = exports.valueOf = exports.INTERNAL_OPEN_URL = exports.REPEAT_LAST = exports.MARK_JUMP_PREFIX = exports.MARK_SET_PREFIX = void 0;
exports.CANCEL = "cancel";
exports.ADDON_ENABLE = "addon.enable";
exports.ADDON_DISABLE = "addon.disable";
exports.ADDON_TOGGLE_ENABLED = "addon.toggle.enabled";
exports.COMMAND_SHOW = "command.show";
exports.COMMAND_SHOW_OPEN = "command.show.open";
exports.COMMAND_SHOW_TABOPEN = "command.show.tabopen";
exports.COMMAND_SHOW_WINOPEN = "command.show.winopen";
exports.COMMAND_SHOW_BUFFER = "command.show.buffer";
exports.COMMAND_SHOW_ADDBOOKMARK = "command.show.addbookmark";
exports.SCROLL_VERTICALLY = "scroll.vertically";
exports.SCROLL_HORIZONALLY = "scroll.horizonally";
exports.SCROLL_PAGES = "scroll.pages";
exports.SCROLL_TOP = "scroll.top";
exports.SCROLL_BOTTOM = "scroll.bottom";
exports.SCROLL_HOME = "scroll.home";
exports.SCROLL_END = "scroll.end";
exports.FOLLOW_START = "follow.start";
exports.NAVIGATE_HISTORY_PREV = "navigate.history.prev";
exports.NAVIGATE_HISTORY_NEXT = "navigate.history.next";
exports.NAVIGATE_LINK_PREV = "navigate.link.prev";
exports.NAVIGATE_LINK_NEXT = "navigate.link.next";
exports.NAVIGATE_PARENT = "navigate.parent";
exports.NAVIGATE_ROOT = "navigate.root";
exports.FOCUS_INPUT = "focus.input";
exports.PAGE_SOURCE = "page.source";
exports.PAGE_HOME = "page.home";
exports.TAB_CLOSE = "tabs.close";
exports.TAB_CLOSE_FORCE = "tabs.close.force";
exports.TAB_CLOSE_RIGHT = "tabs.close.right";
exports.TAB_REOPEN = "tabs.reopen";
exports.TAB_PREV = "tabs.prev";
exports.TAB_NEXT = "tabs.next";
exports.TAB_FIRST = "tabs.first";
exports.TAB_LAST = "tabs.last";
exports.TAB_PREV_SEL = "tabs.prevsel";
exports.TAB_RELOAD = "tabs.reload";
exports.TAB_PIN = "tabs.pin";
exports.TAB_UNPIN = "tabs.unpin";
exports.TAB_TOGGLE_PINNED = "tabs.pin.toggle";
exports.TAB_DUPLICATE = "tabs.duplicate";
exports.TAB_TOGGLE_READER = "tabs.reader.toggle";
exports.ZOOM_IN = "zoom.in";
exports.ZOOM_OUT = "zoom.out";
exports.ZOOM_NEUTRAL = "zoom.neutral";
exports.URLS_YANK = "urls.yank";
exports.URLS_PASTE = "urls.paste";
exports.FIND_START = "find.start";
exports.FIND_NEXT = "find.next";
exports.FIND_PREV = "find.prev";
exports.MARK_SET_PREFIX = "mark.set.prefix";
exports.MARK_JUMP_PREFIX = "mark.jump.prefix";
exports.REPEAT_LAST = "repeat.last";
exports.INTERNAL_OPEN_URL = "internal.open.url";
const assertOptionalBoolean = (obj, name) => {
    if (Object.prototype.hasOwnProperty.call(obj, name) &&
        typeof obj[name] !== "boolean") {
        throw new TypeError(`Not a boolean parameter: '${name} (${typeof obj[name]})'`);
    }
};
const assertOptionalString = (obj, name, values) => {
    if (Object.prototype.hasOwnProperty.call(obj, name)) {
        const value = obj[name];
        if (typeof value !== "string") {
            throw new TypeError(`Not a string parameter: '${name}' (${typeof value})`);
        }
        if (values && values.length && values.indexOf(value) === -1) {
            throw new TypeError(`Invalid parameter for '${name}': '${value}'`);
        }
    }
};
const assertRequiredNumber = (obj, name) => {
    if (!Object.prototype.hasOwnProperty.call(obj, name) ||
        typeof obj[name] !== "number") {
        throw new TypeError(`Missing number parameter: '${name}`);
    }
};
const assertRequiredString = (obj, name) => {
    if (!Object.prototype.hasOwnProperty.call(obj, name) ||
        typeof obj[name] !== "string") {
        throw new TypeError(`Missing string parameter: '${name}`);
    }
};
const valueOf = (o) => {
    if (!Object.prototype.hasOwnProperty.call(o, "type")) {
        throw new TypeError(`Missing 'type' field`);
    }
    switch (o.type) {
        case exports.COMMAND_SHOW_OPEN:
        case exports.COMMAND_SHOW_TABOPEN:
        case exports.COMMAND_SHOW_WINOPEN:
        case exports.COMMAND_SHOW_ADDBOOKMARK:
            assertOptionalBoolean(o, "alter");
            return { type: o.type, alter: Boolean(o.alter) };
        case exports.SCROLL_VERTICALLY:
        case exports.SCROLL_HORIZONALLY:
        case exports.SCROLL_PAGES:
            assertRequiredNumber(o, "count");
            return { type: o.type, count: Number(o.count) };
        case exports.FOLLOW_START:
            assertOptionalBoolean(o, "newTab");
            assertOptionalBoolean(o, "background");
            return {
                type: exports.FOLLOW_START,
                newTab: Boolean(typeof o.newTab === "undefined" ? false : o.newTab),
                background: Boolean(typeof o.background === "undefined" ? true : o.background),
            };
        case exports.PAGE_HOME:
            assertOptionalBoolean(o, "newTab");
            return {
                type: exports.PAGE_HOME,
                newTab: Boolean(typeof o.newTab === "undefined" ? false : o.newTab),
            };
        case exports.TAB_CLOSE:
            assertOptionalString(o, "select", ["left", "right"]);
            return {
                type: exports.TAB_CLOSE,
                select: typeof o.select === "undefined" ? "right" : o.select,
            };
        case exports.TAB_RELOAD:
            assertOptionalBoolean(o, "cache");
            return {
                type: exports.TAB_RELOAD,
                cache: Boolean(typeof o.cache === "undefined" ? false : o.cache),
            };
        case exports.URLS_PASTE:
            assertOptionalBoolean(o, "newTab");
            return {
                type: exports.URLS_PASTE,
                newTab: Boolean(typeof o.newTab === "undefined" ? false : o.newTab),
            };
        case exports.INTERNAL_OPEN_URL:
            assertOptionalBoolean(o, "newTab");
            assertOptionalBoolean(o, "newWindow");
            assertOptionalBoolean(o, "background");
            assertRequiredString(o, "url");
            return {
                type: exports.INTERNAL_OPEN_URL,
                url: o.url,
                newTab: Boolean(typeof o.newTab === "undefined" ? false : o.newTab),
                newWindow: Boolean(typeof o.newWindow === "undefined" ? false : o.newWindow),
                background: Boolean(typeof o.background === "undefined" ? true : o.background),
            };
        case exports.CANCEL:
        case exports.ADDON_ENABLE:
        case exports.ADDON_DISABLE:
        case exports.ADDON_TOGGLE_ENABLED:
        case exports.COMMAND_SHOW:
        case exports.COMMAND_SHOW_BUFFER:
        case exports.SCROLL_TOP:
        case exports.SCROLL_BOTTOM:
        case exports.SCROLL_HOME:
        case exports.SCROLL_END:
        case exports.NAVIGATE_HISTORY_PREV:
        case exports.NAVIGATE_HISTORY_NEXT:
        case exports.NAVIGATE_LINK_PREV:
        case exports.NAVIGATE_LINK_NEXT:
        case exports.NAVIGATE_PARENT:
        case exports.NAVIGATE_ROOT:
        case exports.FOCUS_INPUT:
        case exports.PAGE_SOURCE:
        case exports.TAB_CLOSE_FORCE:
        case exports.TAB_CLOSE_RIGHT:
        case exports.TAB_REOPEN:
        case exports.TAB_PREV:
        case exports.TAB_NEXT:
        case exports.TAB_FIRST:
        case exports.TAB_LAST:
        case exports.TAB_PREV_SEL:
        case exports.TAB_PIN:
        case exports.TAB_UNPIN:
        case exports.TAB_TOGGLE_PINNED:
        case exports.TAB_DUPLICATE:
        case exports.TAB_TOGGLE_READER:
        case exports.ZOOM_IN:
        case exports.ZOOM_OUT:
        case exports.ZOOM_NEUTRAL:
        case exports.URLS_YANK:
        case exports.FIND_START:
        case exports.FIND_NEXT:
        case exports.FIND_PREV:
        case exports.MARK_SET_PREFIX:
        case exports.MARK_JUMP_PREFIX:
        case exports.REPEAT_LAST:
            return { type: o.type };
    }
    throw new TypeError("Unknown operation type: " + o.type);
};
exports.valueOf = valueOf;
const isNRepeatable = (type) => {
    switch (type) {
        case exports.SCROLL_VERTICALLY:
        case exports.SCROLL_HORIZONALLY:
        case exports.SCROLL_PAGES:
        case exports.NAVIGATE_HISTORY_PREV:
        case exports.NAVIGATE_HISTORY_NEXT:
        case exports.NAVIGATE_PARENT:
        case exports.TAB_CLOSE:
        case exports.TAB_CLOSE_FORCE:
        case exports.TAB_CLOSE_RIGHT:
        case exports.TAB_REOPEN:
        case exports.TAB_PREV:
        case exports.TAB_NEXT:
        case exports.TAB_DUPLICATE:
        case exports.ZOOM_IN:
        case exports.ZOOM_OUT:
        case exports.URLS_PASTE:
        case exports.FIND_NEXT:
        case exports.FIND_PREV:
        case exports.REPEAT_LAST:
            return true;
    }
    return false;
};
exports.isNRepeatable = isNRepeatable;


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.valueOf = exports.NAVIGATE_LINK_PREV = exports.NAVIGATE_LINK_NEXT = exports.NAVIGATE_HISTORY_PREV = exports.NAVIGATE_HISTORY_NEXT = exports.CONSOLE_FRAME_MESSAGE = exports.SETTINGS_QUERY = exports.SETTINGS_CHANGED = exports.OPEN_URL = exports.ADDON_TOGGLE_ENABLED = exports.ADDON_ENABLED_RESPONSE = exports.ADDON_ENABLED_QUERY = exports.FIND_CLEAR_SELECTION = exports.FIND_PREV = exports.FIND_NEXT = exports.TAB_SCROLL_TO = exports.MARK_JUMP_GLOBAL = exports.MARK_SET_GLOBAL = exports.FOLLOW_KEY_PRESS = exports.FOLLOW_ACTIVATE = exports.FOLLOW_REMOVE_HINTS = exports.FOLLOW_SHOW_HINTS = exports.FOLLOW_CREATE_HINTS = exports.FOLLOW_RESPONSE_COUNT_TARGETS = exports.FOLLOW_REQUEST_COUNT_TARGETS = exports.FOLLOW_START = exports.CONSOLE_RESIZE = exports.CONSOLE_GET_PROPERTIES = exports.CONSOLE_REQUEST_TABS = exports.CONSOLE_REQUEST_HISTORY = exports.CONSOLE_REQUEST_BOOKMARKS = exports.CONSOLE_REQUEST_SEARCH_ENGINES_MESSAGE = exports.CONSOLE_GET_COMPLETION_TYPES = exports.CONSOLE_HIDE = exports.CONSOLE_SHOW_FIND = exports.CONSOLE_SHOW_INFO = exports.CONSOLE_SHOW_ERROR = exports.CONSOLE_SHOW_COMMAND = exports.CONSOLE_ENTER_FIND = exports.CONSOLE_ENTER_COMMAND = exports.CONSOLE_UNFOCUS = exports.BACKGROUND_OPERATION = void 0;
exports.BACKGROUND_OPERATION = "background.operation";
exports.CONSOLE_UNFOCUS = "console.unfocus";
exports.CONSOLE_ENTER_COMMAND = "console.enter.command";
exports.CONSOLE_ENTER_FIND = "console.enter.find";
exports.CONSOLE_SHOW_COMMAND = "console.show.command";
exports.CONSOLE_SHOW_ERROR = "console.show.error";
exports.CONSOLE_SHOW_INFO = "console.show.info";
exports.CONSOLE_SHOW_FIND = "console.show.find";
exports.CONSOLE_HIDE = "console.hide";
exports.CONSOLE_GET_COMPLETION_TYPES = "console.get.completion.types";
exports.CONSOLE_REQUEST_SEARCH_ENGINES_MESSAGE = "console.qresut.searchEngines";
exports.CONSOLE_REQUEST_BOOKMARKS = "console.request.bookmarks";
exports.CONSOLE_REQUEST_HISTORY = "console.request.history";
exports.CONSOLE_REQUEST_TABS = "console.request.tabs";
exports.CONSOLE_GET_PROPERTIES = "console.get.properties";
exports.CONSOLE_RESIZE = "console.resize";
exports.FOLLOW_START = "follow.start";
exports.FOLLOW_REQUEST_COUNT_TARGETS = "follow.request.count.targets";
exports.FOLLOW_RESPONSE_COUNT_TARGETS = "follow.response.count.targets";
exports.FOLLOW_CREATE_HINTS = "follow.create.hints";
exports.FOLLOW_SHOW_HINTS = "follow.update.hints";
exports.FOLLOW_REMOVE_HINTS = "follow.remove.hints";
exports.FOLLOW_ACTIVATE = "follow.activate";
exports.FOLLOW_KEY_PRESS = "follow.key.press";
exports.MARK_SET_GLOBAL = "mark.set.global";
exports.MARK_JUMP_GLOBAL = "mark.jump.global";
exports.TAB_SCROLL_TO = "tab.scroll.to";
exports.FIND_NEXT = "find.next";
exports.FIND_PREV = "find.prev";
exports.FIND_CLEAR_SELECTION = "find.clear.selection";
exports.ADDON_ENABLED_QUERY = "addon.enabled.query";
exports.ADDON_ENABLED_RESPONSE = "addon.enabled.response";
exports.ADDON_TOGGLE_ENABLED = "addon.toggle.enabled";
exports.OPEN_URL = "open.url";
exports.SETTINGS_CHANGED = "settings.changed";
exports.SETTINGS_QUERY = "settings.query";
exports.CONSOLE_FRAME_MESSAGE = "console.frame.message";
exports.NAVIGATE_HISTORY_NEXT = "navigate.history.next";
exports.NAVIGATE_HISTORY_PREV = "navigate.history.prev";
exports.NAVIGATE_LINK_NEXT = "navigate.link.next";
exports.NAVIGATE_LINK_PREV = "navigate.link.prev";
const valueOf = (o) => {
    switch (o.type) {
        case exports.CONSOLE_UNFOCUS:
        case exports.CONSOLE_ENTER_COMMAND:
        case exports.CONSOLE_ENTER_FIND:
        case exports.CONSOLE_SHOW_COMMAND:
        case exports.CONSOLE_SHOW_ERROR:
        case exports.CONSOLE_SHOW_INFO:
        case exports.CONSOLE_SHOW_FIND:
        case exports.CONSOLE_HIDE:
        case exports.FOLLOW_START:
        case exports.FOLLOW_REQUEST_COUNT_TARGETS:
        case exports.FOLLOW_RESPONSE_COUNT_TARGETS:
        case exports.FOLLOW_CREATE_HINTS:
        case exports.FOLLOW_SHOW_HINTS:
        case exports.FOLLOW_REMOVE_HINTS:
        case exports.FOLLOW_ACTIVATE:
        case exports.FOLLOW_KEY_PRESS:
        case exports.MARK_SET_GLOBAL:
        case exports.MARK_JUMP_GLOBAL:
        case exports.TAB_SCROLL_TO:
        case exports.FIND_NEXT:
        case exports.FIND_PREV:
        case exports.FIND_CLEAR_SELECTION:
        case exports.ADDON_ENABLED_QUERY:
        case exports.ADDON_ENABLED_RESPONSE:
        case exports.ADDON_TOGGLE_ENABLED:
        case exports.OPEN_URL:
        case exports.SETTINGS_CHANGED:
        case exports.SETTINGS_QUERY:
        case exports.CONSOLE_FRAME_MESSAGE:
        case exports.CONSOLE_RESIZE:
        case exports.NAVIGATE_HISTORY_NEXT:
        case exports.NAVIGATE_HISTORY_PREV:
        case exports.NAVIGATE_LINK_NEXT:
        case exports.NAVIGATE_LINK_PREV:
            return o;
    }
    throw new Error("unknown message type: " + o.type);
};
exports.valueOf = valueOf;


/***/ }),
/* 5 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* WEBPACK VAR INJECTION */(function(process) {/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ServerStyleSheet", function() { return Ue; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "StyleSheetConsumer", function() { return le; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "StyleSheetContext", function() { return ue; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "StyleSheetManager", function() { return ye; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ThemeConsumer", function() { return Le; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ThemeContext", function() { return ze; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "ThemeProvider", function() { return Ge; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "__PRIVATE__", function() { return Ze; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "createGlobalStyle", function() { return $e; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "css", function() { return Ae; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "isStyledComponent", function() { return N; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "keyframes", function() { return We; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "useTheme", function() { return Xe; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "version", function() { return C; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "withTheme", function() { return Je; });
/* harmony import */ var react_is__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(8);
/* harmony import */ var react_is__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(react_is__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(1);
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var shallowequal__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(28);
/* harmony import */ var shallowequal__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(shallowequal__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var _emotion_stylis__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(29);
/* harmony import */ var _emotion_unitless__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(30);
/* harmony import */ var _emotion_is_prop_valid__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(21);
/* harmony import */ var hoist_non_react_statics__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(12);
/* harmony import */ var hoist_non_react_statics__WEBPACK_IMPORTED_MODULE_6___default = /*#__PURE__*/__webpack_require__.n(hoist_non_react_statics__WEBPACK_IMPORTED_MODULE_6__);
function v(){return(v=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e}).apply(this,arguments)}var g=function(e,t){for(var n=[e[0]],r=0,o=t.length;r<o;r+=1)n.push(t[r],e[r+1]);return n},S=function(t){return null!==t&&"object"==typeof t&&"[object Object]"===(t.toString?t.toString():Object.prototype.toString.call(t))&&!Object(react_is__WEBPACK_IMPORTED_MODULE_0__["typeOf"])(t)},w=Object.freeze([]),E=Object.freeze({});function b(e){return"function"==typeof e}function _(e){return false||e.displayName||e.name||"Component"}function N(e){return e&&"string"==typeof e.styledComponentId}var A="undefined"!=typeof process&&(process.env.REACT_APP_SC_ATTR||process.env.SC_ATTR)||"data-styled",C="5.3.0",I="undefined"!=typeof window&&"HTMLElement"in window,P=Boolean("boolean"==typeof SC_DISABLE_SPEEDY?SC_DISABLE_SPEEDY:"undefined"!=typeof process&&void 0!==process.env.REACT_APP_SC_DISABLE_SPEEDY&&""!==process.env.REACT_APP_SC_DISABLE_SPEEDY?"false"!==process.env.REACT_APP_SC_DISABLE_SPEEDY&&process.env.REACT_APP_SC_DISABLE_SPEEDY:"undefined"!=typeof process&&void 0!==process.env.SC_DISABLE_SPEEDY&&""!==process.env.SC_DISABLE_SPEEDY?"false"!==process.env.SC_DISABLE_SPEEDY&&process.env.SC_DISABLE_SPEEDY:"production"!=="production"),O={},R= false?undefined:{};function D(){for(var e=arguments.length<=0?void 0:arguments[0],t=[],n=1,r=arguments.length;n<r;n+=1)t.push(n<0||arguments.length<=n?void 0:arguments[n]);return t.forEach((function(t){e=e.replace(/%[a-z]/,t)})),e}function j(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];throw true?new Error("An error occurred. See https://git.io/JUIaE#"+e+" for more information."+(n.length>0?" Args: "+n.join(", "):"")):undefined}var T=function(){function e(e){this.groupSizes=new Uint32Array(512),this.length=512,this.tag=e}var t=e.prototype;return t.indexOfGroup=function(e){for(var t=0,n=0;n<e;n++)t+=this.groupSizes[n];return t},t.insertRules=function(e,t){if(e>=this.groupSizes.length){for(var n=this.groupSizes,r=n.length,o=r;e>=o;)(o<<=1)<0&&j(16,""+e);this.groupSizes=new Uint32Array(o),this.groupSizes.set(n),this.length=o;for(var i=r;i<o;i++)this.groupSizes[i]=0}for(var s=this.indexOfGroup(e+1),a=0,c=t.length;a<c;a++)this.tag.insertRule(s,t[a])&&(this.groupSizes[e]++,s++)},t.clearGroup=function(e){if(e<this.length){var t=this.groupSizes[e],n=this.indexOfGroup(e),r=n+t;this.groupSizes[e]=0;for(var o=n;o<r;o++)this.tag.deleteRule(n)}},t.getGroup=function(e){var t="";if(e>=this.length||0===this.groupSizes[e])return t;for(var n=this.groupSizes[e],r=this.indexOfGroup(e),o=r+n,i=r;i<o;i++)t+=this.tag.getRule(i)+"/*!sc*/\n";return t},e}(),k=new Map,x=new Map,V=1,B=function(e){if(k.has(e))return k.get(e);for(;x.has(V);)V++;var t=V++;return false&&false,k.set(e,t),x.set(t,e),t},M=function(e){return x.get(e)},z=function(e,t){k.set(e,t),x.set(t,e)},L="style["+A+'][data-styled-version="5.3.0"]',G=new RegExp("^"+A+'\\.g(\\d+)\\[id="([\\w\\d-]+)"\\].*?"([^"]*)'),F=function(e,t,n){for(var r,o=n.split(","),i=0,s=o.length;i<s;i++)(r=o[i])&&e.registerName(t,r)},Y=function(e,t){for(var n=t.innerHTML.split("/*!sc*/\n"),r=[],o=0,i=n.length;o<i;o++){var s=n[o].trim();if(s){var a=s.match(G);if(a){var c=0|parseInt(a[1],10),u=a[2];0!==c&&(z(u,c),F(e,u,a[3]),e.getTag().insertRules(c,r)),r.length=0}else r.push(s)}}},q=function(){return"undefined"!=typeof window&&void 0!==window.__webpack_nonce__?window.__webpack_nonce__:null},H=function(e){var t=document.head,n=e||t,r=document.createElement("style"),o=function(e){for(var t=e.childNodes,n=t.length;n>=0;n--){var r=t[n];if(r&&1===r.nodeType&&r.hasAttribute(A))return r}}(n),i=void 0!==o?o.nextSibling:null;r.setAttribute(A,"active"),r.setAttribute("data-styled-version","5.3.0");var s=q();return s&&r.setAttribute("nonce",s),n.insertBefore(r,i),r},$=function(){function e(e){var t=this.element=H(e);t.appendChild(document.createTextNode("")),this.sheet=function(e){if(e.sheet)return e.sheet;for(var t=document.styleSheets,n=0,r=t.length;n<r;n++){var o=t[n];if(o.ownerNode===e)return o}j(17)}(t),this.length=0}var t=e.prototype;return t.insertRule=function(e,t){try{return this.sheet.insertRule(t,e),this.length++,!0}catch(e){return!1}},t.deleteRule=function(e){this.sheet.deleteRule(e),this.length--},t.getRule=function(e){var t=this.sheet.cssRules[e];return void 0!==t&&"string"==typeof t.cssText?t.cssText:""},e}(),W=function(){function e(e){var t=this.element=H(e);this.nodes=t.childNodes,this.length=0}var t=e.prototype;return t.insertRule=function(e,t){if(e<=this.length&&e>=0){var n=document.createTextNode(t),r=this.nodes[e];return this.element.insertBefore(n,r||null),this.length++,!0}return!1},t.deleteRule=function(e){this.element.removeChild(this.nodes[e]),this.length--},t.getRule=function(e){return e<this.length?this.nodes[e].textContent:""},e}(),U=function(){function e(e){this.rules=[],this.length=0}var t=e.prototype;return t.insertRule=function(e,t){return e<=this.length&&(this.rules.splice(e,0,t),this.length++,!0)},t.deleteRule=function(e){this.rules.splice(e,1),this.length--},t.getRule=function(e){return e<this.length?this.rules[e]:""},e}(),J=I,X={isServer:!I,useCSSOMInjection:!P},Z=function(){function e(e,t,n){void 0===e&&(e=E),void 0===t&&(t={}),this.options=v({},X,{},e),this.gs=t,this.names=new Map(n),!this.options.isServer&&I&&J&&(J=!1,function(e){for(var t=document.querySelectorAll(L),n=0,r=t.length;n<r;n++){var o=t[n];o&&"active"!==o.getAttribute(A)&&(Y(e,o),o.parentNode&&o.parentNode.removeChild(o))}}(this))}e.registerId=function(e){return B(e)};var t=e.prototype;return t.reconstructWithOptions=function(t,n){return void 0===n&&(n=!0),new e(v({},this.options,{},t),this.gs,n&&this.names||void 0)},t.allocateGSInstance=function(e){return this.gs[e]=(this.gs[e]||0)+1},t.getTag=function(){return this.tag||(this.tag=(n=(t=this.options).isServer,r=t.useCSSOMInjection,o=t.target,e=n?new U(o):r?new $(o):new W(o),new T(e)));var e,t,n,r,o},t.hasNameForId=function(e,t){return this.names.has(e)&&this.names.get(e).has(t)},t.registerName=function(e,t){if(B(e),this.names.has(e))this.names.get(e).add(t);else{var n=new Set;n.add(t),this.names.set(e,n)}},t.insertRules=function(e,t,n){this.registerName(e,t),this.getTag().insertRules(B(e),n)},t.clearNames=function(e){this.names.has(e)&&this.names.get(e).clear()},t.clearRules=function(e){this.getTag().clearGroup(B(e)),this.clearNames(e)},t.clearTag=function(){this.tag=void 0},t.toString=function(){return function(e){for(var t=e.getTag(),n=t.length,r="",o=0;o<n;o++){var i=M(o);if(void 0!==i){var s=e.names.get(i),a=t.getGroup(o);if(void 0!==s&&0!==a.length){var c=A+".g"+o+'[id="'+i+'"]',u="";void 0!==s&&s.forEach((function(e){e.length>0&&(u+=e+",")})),r+=""+a+c+'{content:"'+u+'"}/*!sc*/\n'}}}return r}(this)},e}(),K=/(a)(d)/gi,Q=function(e){return String.fromCharCode(e+(e>25?39:97))};function ee(e){var t,n="";for(t=Math.abs(e);t>52;t=t/52|0)n=Q(t%52)+n;return(Q(t%52)+n).replace(K,"$1-$2")}var te=function(e,t){for(var n=t.length;n;)e=33*e^t.charCodeAt(--n);return e},ne=function(e){return te(5381,e)};function re(e){for(var t=0;t<e.length;t+=1){var n=e[t];if(b(n)&&!N(n))return!1}return!0}var oe=ne("5.3.0"),ie=function(){function e(e,t,n){this.rules=e,this.staticRulesId="",this.isStatic= true&&(void 0===n||n.isStatic)&&re(e),this.componentId=t,this.baseHash=te(oe,t),this.baseStyle=n,Z.registerId(t)}return e.prototype.generateAndInjectStyles=function(e,t,n){var r=this.componentId,o=[];if(this.baseStyle&&o.push(this.baseStyle.generateAndInjectStyles(e,t,n)),this.isStatic&&!n.hash)if(this.staticRulesId&&t.hasNameForId(r,this.staticRulesId))o.push(this.staticRulesId);else{var i=Ne(this.rules,e,t,n).join(""),s=ee(te(this.baseHash,i.length)>>>0);if(!t.hasNameForId(r,s)){var a=n(i,"."+s,void 0,r);t.insertRules(r,s,a)}o.push(s),this.staticRulesId=s}else{for(var c=this.rules.length,u=te(this.baseHash,n.hash),l="",d=0;d<c;d++){var h=this.rules[d];if("string"==typeof h)l+=h, false&&(false);else if(h){var p=Ne(h,e,t,n),f=Array.isArray(p)?p.join(""):p;u=te(u,f+d),l+=f}}if(l){var m=ee(u>>>0);if(!t.hasNameForId(r,m)){var y=n(l,"."+m,void 0,r);t.insertRules(r,m,y)}o.push(m)}}return o.join(" ")},e}(),se=/^\s*\/\/.*$/gm,ae=[":","[",".","#"];function ce(e){var t,n,r,o,i=void 0===e?E:e,s=i.options,a=void 0===s?E:s,c=i.plugins,u=void 0===c?w:c,l=new _emotion_stylis__WEBPACK_IMPORTED_MODULE_3__[/* default */ "a"](a),d=[],h=function(e){function t(t){if(t)try{e(t+"}")}catch(e){}}return function(n,r,o,i,s,a,c,u,l,d){switch(n){case 1:if(0===l&&64===r.charCodeAt(0))return e(r+";"),"";break;case 2:if(0===u)return r+"/*|*/";break;case 3:switch(u){case 102:case 112:return e(o[0]+r),"";default:return r+(0===d?"/*|*/":"")}case-2:r.split("/*|*/}").forEach(t)}}}((function(e){d.push(e)})),f=function(e,r,i){return 0===r&&-1!==ae.indexOf(i[n.length])||i.match(o)?e:"."+t};function m(e,i,s,a){void 0===a&&(a="&");var c=e.replace(se,""),u=i&&s?s+" "+i+" { "+c+" }":c;return t=a,n=i,r=new RegExp("\\"+n+"\\b","g"),o=new RegExp("(\\"+n+"\\b){2,}"),l(s||!i?"":i,u)}return l.use([].concat(u,[function(e,t,o){2===e&&o.length&&o[0].lastIndexOf(n)>0&&(o[0]=o[0].replace(r,f))},h,function(e){if(-2===e){var t=d;return d=[],t}}])),m.hash=u.length?u.reduce((function(e,t){return t.name||j(15),te(e,t.name)}),5381).toString():"",m}var ue=react__WEBPACK_IMPORTED_MODULE_1___default.a.createContext(),le=ue.Consumer,de=react__WEBPACK_IMPORTED_MODULE_1___default.a.createContext(),he=(de.Consumer,new Z),pe=ce();function fe(){return Object(react__WEBPACK_IMPORTED_MODULE_1__["useContext"])(ue)||he}function me(){return Object(react__WEBPACK_IMPORTED_MODULE_1__["useContext"])(de)||pe}function ye(e){var t=Object(react__WEBPACK_IMPORTED_MODULE_1__["useState"])(e.stylisPlugins),n=t[0],i=t[1],c=fe(),u=Object(react__WEBPACK_IMPORTED_MODULE_1__["useMemo"])((function(){var t=c;return e.sheet?t=e.sheet:e.target&&(t=t.reconstructWithOptions({target:e.target},!1)),e.disableCSSOMInjection&&(t=t.reconstructWithOptions({useCSSOMInjection:!1})),t}),[e.disableCSSOMInjection,e.sheet,e.target]),l=Object(react__WEBPACK_IMPORTED_MODULE_1__["useMemo"])((function(){return ce({options:{prefix:!e.disableVendorPrefixes},plugins:n})}),[e.disableVendorPrefixes,n]);return Object(react__WEBPACK_IMPORTED_MODULE_1__["useEffect"])((function(){shallowequal__WEBPACK_IMPORTED_MODULE_2___default()(n,e.stylisPlugins)||i(e.stylisPlugins)}),[e.stylisPlugins]),react__WEBPACK_IMPORTED_MODULE_1___default.a.createElement(ue.Provider,{value:u},react__WEBPACK_IMPORTED_MODULE_1___default.a.createElement(de.Provider,{value:l}, false?undefined:e.children))}var ve=function(){function e(e,t){var n=this;this.inject=function(e,t){void 0===t&&(t=pe);var r=n.name+t.hash;e.hasNameForId(n.id,r)||e.insertRules(n.id,r,t(n.rules,r,"@keyframes"))},this.toString=function(){return j(12,String(n.name))},this.name=e,this.id="sc-keyframes-"+e,this.rules=t}return e.prototype.getName=function(e){return void 0===e&&(e=pe),this.name+e.hash},e}(),ge=/([A-Z])/,Se=/([A-Z])/g,we=/^ms-/,Ee=function(e){return"-"+e.toLowerCase()};function be(e){return ge.test(e)?e.replace(Se,Ee).replace(we,"-ms-"):e}var _e=function(e){return null==e||!1===e||""===e};function Ne(e,n,r,o){if(Array.isArray(e)){for(var i,s=[],a=0,c=e.length;a<c;a+=1)""!==(i=Ne(e[a],n,r,o))&&(Array.isArray(i)?s.push.apply(s,i):s.push(i));return s}if(_e(e))return"";if(N(e))return"."+e.styledComponentId;if(b(e)){if("function"!=typeof(l=e)||l.prototype&&l.prototype.isReactComponent||!n)return e;var u=e(n);return false&&false,Ne(u,n,r,o)}var l;return e instanceof ve?r?(e.inject(r,o),e.getName(o)):e:S(e)?function e(t,n){var r,o,i=[];for(var s in t)t.hasOwnProperty(s)&&!_e(t[s])&&(S(t[s])?i.push.apply(i,e(t[s],s)):b(t[s])?i.push(be(s)+":",t[s],";"):i.push(be(s)+": "+(r=s,null==(o=t[s])||"boolean"==typeof o||""===o?"":"number"!=typeof o||0===o||r in _emotion_unitless__WEBPACK_IMPORTED_MODULE_4__[/* default */ "a"]?String(o).trim():o+"px")+";"));return n?[n+" {"].concat(i,["}"]):i}(e):e.toString()}function Ae(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];return b(e)||S(e)?Ne(g(w,[e].concat(n))):0===n.length&&1===e.length&&"string"==typeof e[0]?e:Ne(g(e,n))}var Ce=/invalid hook call/i,Ie=new Set,Pe=function(e,t){if(false){ var n; }},Oe=function(e,t,n){return void 0===n&&(n=E),e.theme!==n.theme&&e.theme||t||n.theme},Re=/[!"#$%&'()*+,./:;<=>?@[\\\]^`{|}~-]+/g,De=/(^-|-$)/g;function je(e){return e.replace(Re,"-").replace(De,"")}var Te=function(e){return ee(ne(e)>>>0)};function ke(e){return"string"==typeof e&&( true||false)}var xe=function(e){return"function"==typeof e||"object"==typeof e&&null!==e&&!Array.isArray(e)},Ve=function(e){return"__proto__"!==e&&"constructor"!==e&&"prototype"!==e};function Be(e,t,n){var r=e[n];xe(t)&&xe(r)?Me(r,t):e[n]=t}function Me(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];for(var o=0,i=n;o<i.length;o++){var s=i[o];if(xe(s))for(var a in s)Ve(a)&&Be(e,s[a],a)}return e}var ze=react__WEBPACK_IMPORTED_MODULE_1___default.a.createContext(),Le=ze.Consumer;function Ge(e){var t=Object(react__WEBPACK_IMPORTED_MODULE_1__["useContext"])(ze),n=Object(react__WEBPACK_IMPORTED_MODULE_1__["useMemo"])((function(){return function(e,t){if(!e)return j(14);if(b(e)){var n=e(t);return true?n:undefined}return Array.isArray(e)||"object"!=typeof e?j(8):t?v({},t,{},e):e}(e.theme,t)}),[e.theme,t]);return e.children?react__WEBPACK_IMPORTED_MODULE_1___default.a.createElement(ze.Provider,{value:n},e.children):null}var Fe={};function Ye(e,t,n){var o=N(e),s=!ke(e),a=t.attrs,c=void 0===a?w:a,d=t.componentId,h=void 0===d?function(e,t){var n="string"!=typeof e?"sc":je(e);Fe[n]=(Fe[n]||0)+1;var r=n+"-"+Te("5.3.0"+n+Fe[n]);return t?t+"-"+r:r}(t.displayName,t.parentComponentId):d,p=t.displayName,f=void 0===p?function(e){return ke(e)?"styled."+e:"Styled("+_(e)+")"}(e):p,g=t.displayName&&t.componentId?je(t.displayName)+"-"+t.componentId:t.componentId||h,S=o&&e.attrs?Array.prototype.concat(e.attrs,c).filter(Boolean):c,A=t.shouldForwardProp;o&&e.shouldForwardProp&&(A=t.shouldForwardProp?function(n,r,o){return e.shouldForwardProp(n,r,o)&&t.shouldForwardProp(n,r,o)}:e.shouldForwardProp);var C,I=new ie(n,g,o?e.componentStyle:void 0),P=I.isStatic&&0===c.length,O=function(e,t){return function(e,t,n,r){var o=e.attrs,s=e.componentStyle,a=e.defaultProps,c=e.foldedComponentIds,d=e.shouldForwardProp,h=e.styledComponentId,p=e.target; false&&false;var f=function(e,t,n){void 0===e&&(e=E);var r=v({},t,{theme:e}),o={};return n.forEach((function(e){var t,n,i,s=e;for(t in b(s)&&(s=s(r)),s)r[t]=o[t]="className"===t?(n=o[t],i=s[t],n&&i?n+" "+i:n||i):s[t]})),[r,o]}(Oe(t,Object(react__WEBPACK_IMPORTED_MODULE_1__["useContext"])(ze),a)||E,t,o),y=f[0],g=f[1],S=function(e,t,n,r){var o=fe(),i=me(),s=t?e.generateAndInjectStyles(E,o,i):e.generateAndInjectStyles(n,o,i);return false&&false, false&&false,s}(s,r,y, false?undefined:void 0),w=n,_=g.$as||t.$as||g.as||t.as||p,N=ke(_),A=g!==t?v({},t,{},g):t,C={};for(var I in A)"$"!==I[0]&&"as"!==I&&("forwardedAs"===I?C.as=A[I]:(d?d(I,_emotion_is_prop_valid__WEBPACK_IMPORTED_MODULE_5__[/* default */ "a"],_):!N||Object(_emotion_is_prop_valid__WEBPACK_IMPORTED_MODULE_5__[/* default */ "a"])(I))&&(C[I]=A[I]));return t.style&&g.style!==t.style&&(C.style=v({},t.style,{},g.style)),C.className=Array.prototype.concat(c,h,S!==h?S:null,t.className,g.className).filter(Boolean).join(" "),C.ref=w,Object(react__WEBPACK_IMPORTED_MODULE_1__["createElement"])(_,C)}(C,e,t,P)};return O.displayName=f,(C=react__WEBPACK_IMPORTED_MODULE_1___default.a.forwardRef(O)).attrs=S,C.componentStyle=I,C.displayName=f,C.shouldForwardProp=A,C.foldedComponentIds=o?Array.prototype.concat(e.foldedComponentIds,e.styledComponentId):w,C.styledComponentId=g,C.target=o?e.target:e,C.withComponent=function(e){var r=t.componentId,o=function(e,t){if(null==e)return{};var n,r,o={},i=Object.keys(e);for(r=0;r<i.length;r++)n=i[r],t.indexOf(n)>=0||(o[n]=e[n]);return o}(t,["componentId"]),i=r&&r+"-"+(ke(e)?e:je(_(e)));return Ye(e,v({},o,{attrs:S,componentId:i}),n)},Object.defineProperty(C,"defaultProps",{get:function(){return this._foldedDefaultProps},set:function(t){this._foldedDefaultProps=o?Me({},e.defaultProps,t):t}}), false&&(false),C.toString=function(){return"."+C.styledComponentId},s&&hoist_non_react_statics__WEBPACK_IMPORTED_MODULE_6___default()(C,e,{attrs:!0,componentStyle:!0,displayName:!0,foldedComponentIds:!0,shouldForwardProp:!0,styledComponentId:!0,target:!0,withComponent:!0}),C}var qe=function(e){return function e(t,r,o){if(void 0===o&&(o=E),!Object(react_is__WEBPACK_IMPORTED_MODULE_0__["isValidElementType"])(r))return j(1,String(r));var i=function(){return t(r,o,Ae.apply(void 0,arguments))};return i.withConfig=function(n){return e(t,r,v({},o,{},n))},i.attrs=function(n){return e(t,r,v({},o,{attrs:Array.prototype.concat(o.attrs,n).filter(Boolean)}))},i}(Ye,e)};["a","abbr","address","area","article","aside","audio","b","base","bdi","bdo","big","blockquote","body","br","button","canvas","caption","cite","code","col","colgroup","data","datalist","dd","del","details","dfn","dialog","div","dl","dt","em","embed","fieldset","figcaption","figure","footer","form","h1","h2","h3","h4","h5","h6","head","header","hgroup","hr","html","i","iframe","img","input","ins","kbd","keygen","label","legend","li","link","main","map","mark","marquee","menu","menuitem","meta","meter","nav","noscript","object","ol","optgroup","option","output","p","param","picture","pre","progress","q","rp","rt","ruby","s","samp","script","section","select","small","source","span","strong","style","sub","summary","sup","table","tbody","td","textarea","tfoot","th","thead","time","title","tr","track","u","ul","var","video","wbr","circle","clipPath","defs","ellipse","foreignObject","g","image","line","linearGradient","marker","mask","path","pattern","polygon","polyline","radialGradient","rect","stop","svg","text","textPath","tspan"].forEach((function(e){qe[e]=qe(e)}));var He=function(){function e(e,t){this.rules=e,this.componentId=t,this.isStatic=re(e),Z.registerId(this.componentId+1)}var t=e.prototype;return t.createStyles=function(e,t,n,r){var o=r(Ne(this.rules,t,n,r).join(""),""),i=this.componentId+e;n.insertRules(i,i,o)},t.removeStyles=function(e,t){t.clearRules(this.componentId+e)},t.renderStyles=function(e,t,n,r){e>2&&Z.registerId(this.componentId+e),this.removeStyles(e,n),this.createStyles(e,t,n,r)},e}();function $e(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),o=1;o<t;o++)n[o-1]=arguments[o];var s=Ae.apply(void 0,[e].concat(n)),a="sc-global-"+Te(JSON.stringify(s)),u=new He(s,a);function l(e){var t=fe(),n=me(),o=Object(react__WEBPACK_IMPORTED_MODULE_1__["useContext"])(ze),l=Object(react__WEBPACK_IMPORTED_MODULE_1__["useRef"])(t.allocateGSInstance(a)).current;return false&&false, false&&false,Object(react__WEBPACK_IMPORTED_MODULE_1__["useLayoutEffect"])((function(){return h(l,e,t,o,n),function(){return u.removeStyles(l,t)}}),[l,e,t,o,n]),null}function h(e,t,n,r,o){if(u.isStatic)u.renderStyles(e,O,n,o);else{var i=v({},t,{theme:Oe(t,r,l.defaultProps)});u.renderStyles(e,i,n,o)}}return false&&false,react__WEBPACK_IMPORTED_MODULE_1___default.a.memo(l)}function We(e){ false&&false;for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];var o=Ae.apply(void 0,[e].concat(n)).join(""),i=Te(o);return new ve(i,o)}var Ue=function(){function e(){var e=this;this._emitSheetCSS=function(){var t=e.instance.toString(),n=q();return"<style "+[n&&'nonce="'+n+'"',A+'="true"','data-styled-version="5.3.0"'].filter(Boolean).join(" ")+">"+t+"</style>"},this.getStyleTags=function(){return e.sealed?j(2):e._emitSheetCSS()},this.getStyleElement=function(){var t;if(e.sealed)return j(2);var n=((t={})[A]="",t["data-styled-version"]="5.3.0",t.dangerouslySetInnerHTML={__html:e.instance.toString()},t),o=q();return o&&(n.nonce=o),[react__WEBPACK_IMPORTED_MODULE_1___default.a.createElement("style",v({},n,{key:"sc-0-0"}))]},this.seal=function(){e.sealed=!0},this.instance=new Z({isServer:!0}),this.sealed=!1}var t=e.prototype;return t.collectStyles=function(e){return this.sealed?j(2):react__WEBPACK_IMPORTED_MODULE_1___default.a.createElement(ye,{sheet:this.instance},e)},t.interleaveWithNodeStream=function(e){return j(3)},e}(),Je=function(e){var t=react__WEBPACK_IMPORTED_MODULE_1___default.a.forwardRef((function(t,n){var o=Object(react__WEBPACK_IMPORTED_MODULE_1__["useContext"])(ze),s=e.defaultProps,a=Oe(t,o,s);return false&&false,react__WEBPACK_IMPORTED_MODULE_1___default.a.createElement(e,v({},t,{theme:a,ref:n}))}));return hoist_non_react_statics__WEBPACK_IMPORTED_MODULE_6___default()(t,e),t.displayName="WithTheme("+_(e)+")",t},Xe=function(){return Object(react__WEBPACK_IMPORTED_MODULE_1__["useContext"])(ze)},Ze={StyleSheet:Z,masterSheet:he}; false&&false, false&&(false);/* harmony default export */ __webpack_exports__["default"] = (qe);
//# sourceMappingURL=styled-components.browser.esm.js.map

/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(16)))

/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const ColorScheme_1 = tslib_1.__importDefault(__webpack_require__(11));
const defs = [
    {
        name: "hintchars",
        defaultValue: "abcdefghijklmnopqrstuvwxyz",
        type: "string",
    },
    {
        name: "smoothscroll",
        defaultValue: false,
        type: "boolean",
    },
    {
        name: "complete",
        defaultValue: "sbh",
        type: "string",
    },
    {
        name: "colorscheme",
        defaultValue: ColorScheme_1.default.System,
        type: "string",
    },
];
const defaultValues = {
    hintchars: "abcdefghijklmnopqrstuvwxyz",
    smoothscroll: false,
    complete: "sbh",
    colorscheme: ColorScheme_1.default.System,
};
class Properties {
    constructor({ hintchars, smoothscroll, complete, colorscheme, } = {}) {
        this.hintchars = hintchars || defaultValues.hintchars;
        this.smoothscroll = smoothscroll || defaultValues.smoothscroll;
        this.complete = complete || defaultValues.complete;
        this.colorscheme = colorscheme || defaultValues.colorscheme;
    }
    static fromJSON(json) {
        return new Properties(json);
    }
    static types() {
        return {
            hintchars: "string",
            smoothscroll: "boolean",
            complete: "string",
            colorscheme: "string",
        };
    }
    static def(name) {
        return defs.find((p) => p.name === name);
    }
    static defs() {
        return defs;
    }
    toJSON() {
        return {
            hintchars: this.hintchars,
            smoothscroll: this.smoothscroll,
            complete: this.complete,
            colorscheme: this.colorscheme,
        };
    }
}
exports.default = Properties;


/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.BlacklistItem = void 0;
const tslib_1 = __webpack_require__(0);
const Key_1 = tslib_1.__importDefault(__webpack_require__(13));
const regexFromWildcard = (pattern) => {
    const regexStr = "^" + pattern.replace(/\*/g, ".*") + "$";
    return new RegExp(regexStr);
};
class BlacklistItem {
    constructor(pattern, partial, keys) {
        this.pattern = pattern;
        this.regex = regexFromWildcard(pattern);
        this.partial = partial;
        this.keys = keys;
        this.keyEntities = this.keys.map(Key_1.default.fromMapKey);
    }
    static fromJSON(json) {
        return typeof json === "string"
            ? new BlacklistItem(json, false, [])
            : new BlacklistItem(json.url, true, json.keys);
    }
    toJSON() {
        if (!this.partial) {
            return this.pattern;
        }
        return { url: this.pattern, keys: this.keys };
    }
    matches(url) {
        return this.pattern.includes("/")
            ? this.regex.test(url.host + url.pathname)
            : this.regex.test(url.host);
    }
    includeKey(url, key) {
        if (!this.matches(url) || !this.partial) {
            return false;
        }
        return this.keyEntities.some((k) => k.equals(key));
    }
}
exports.BlacklistItem = BlacklistItem;
class Blacklist {
    constructor(items) {
        this.items = items;
    }
    static fromJSON(json) {
        const items = json.map((o) => BlacklistItem.fromJSON(o));
        return new Blacklist(items);
    }
    toJSON() {
        return this.items.map((item) => item.toJSON());
    }
    includesEntireBlacklist(url) {
        return this.items.some((item) => !item.partial && item.matches(url));
    }
    includeKey(url, key) {
        return this.items.some((item) => item.includeKey(url, key));
    }
}
exports.default = Blacklist;


/***/ }),
/* 8 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


if (true) {
  module.exports = __webpack_require__(40);
} else {}


/***/ }),
/* 9 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const operations = tslib_1.__importStar(__webpack_require__(3));
class Keymaps {
    constructor(data) {
        this.data = data;
    }
    static fromJSON(json) {
        const entries = {};
        for (const key of Object.keys(json)) {
            entries[key] = operations.valueOf(json[key]);
        }
        return new Keymaps(entries);
    }
    combine(other) {
        return new Keymaps(Object.assign(Object.assign({}, this.data), other.data));
    }
    toJSON() {
        return this.data;
    }
    entries() {
        return Object.entries(this.data);
    }
}
exports.default = Keymaps;


/***/ }),
/* 10 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.DefaultSetting = exports.DefaultSettingJSONText = void 0;
const tslib_1 = __webpack_require__(0);
const Keymaps_1 = tslib_1.__importDefault(__webpack_require__(9));
const Search_1 = tslib_1.__importDefault(__webpack_require__(14));
const Properties_1 = tslib_1.__importDefault(__webpack_require__(6));
const Blacklist_1 = tslib_1.__importDefault(__webpack_require__(7));
const validate_1 = tslib_1.__importDefault(__webpack_require__(17));
class Settings {
    constructor({ keymaps, search, properties, blacklist, }) {
        this.keymaps = keymaps;
        this.search = search;
        this.properties = properties;
        this.blacklist = blacklist;
    }
    static fromJSON(json) {
        const valid = validate_1.default(json);
        if (!valid) {
            const message = validate_1.default
                .errors.map((err) => {
                return `'${err.dataPath}' ${err.message}`;
            })
                .join("; ");
            throw new TypeError(message);
        }
        const obj = json;
        const settings = Object.assign({}, exports.DefaultSetting);
        if (obj.keymaps) {
            settings.keymaps = Keymaps_1.default.fromJSON(obj.keymaps);
        }
        if (obj.search) {
            settings.search = Search_1.default.fromJSON(obj.search);
        }
        if (obj.properties) {
            settings.properties = Properties_1.default.fromJSON(obj.properties);
        }
        if (obj.blacklist) {
            settings.blacklist = Blacklist_1.default.fromJSON(obj.blacklist);
        }
        return new Settings(settings);
    }
    toJSON() {
        return {
            keymaps: this.keymaps.toJSON(),
            search: this.search.toJSON(),
            properties: this.properties.toJSON(),
            blacklist: this.blacklist.toJSON(),
        };
    }
}
exports.default = Settings;
exports.DefaultSettingJSONText = `{
  "keymaps": {
    "0": { "type": "scroll.home" },
    ":": { "type": "command.show" },
    "o": { "type": "command.show.open", "alter": false },
    "O": { "type": "command.show.open", "alter": true },
    "t": { "type": "command.show.tabopen", "alter": false },
    "T": { "type": "command.show.tabopen", "alter": true },
    "w": { "type": "command.show.winopen", "alter": false },
    "W": { "type": "command.show.winopen", "alter": true },
    "b": { "type": "command.show.buffer" },
    "a": { "type": "command.show.addbookmark", "alter": true },
    "k": { "type": "scroll.vertically", "count": -1 },
    "j": { "type": "scroll.vertically", "count": 1 },
    "h": { "type": "scroll.horizonally", "count": -1 },
    "l": { "type": "scroll.horizonally", "count": 1 },
    "<C-U>": { "type": "scroll.pages", "count": -0.5 },
    "<C-D>": { "type": "scroll.pages", "count": 0.5 },
    "<C-B>": { "type": "scroll.pages", "count": -1 },
    "<C-F>": { "type": "scroll.pages", "count": 1 },
    "gg": { "type": "scroll.top" },
    "G": { "type": "scroll.bottom" },
    "$": { "type": "scroll.end" },
    "d": { "type": "tabs.close" },
    "D": { "type": "tabs.close", "select": "left" },
    "x$": { "type": "tabs.close.right" },
    "!d": { "type": "tabs.close.force" },
    "u": { "type": "tabs.reopen" },
    "K": { "type": "tabs.prev" },
    "J": { "type": "tabs.next" },
    "gT": { "type": "tabs.prev" },
    "gt": { "type": "tabs.next" },
    "g0": { "type": "tabs.first" },
    "g$": { "type": "tabs.last" },
    "<C-6>": { "type": "tabs.prevsel" },
    "r": { "type": "tabs.reload", "cache": false },
    "R": { "type": "tabs.reload", "cache": true },
    "zp": { "type": "tabs.pin.toggle" },
    "zd": { "type": "tabs.duplicate" },
    "zi": { "type": "zoom.in" },
    "zo": { "type": "zoom.out" },
    "zz": { "type": "zoom.neutral" },
    "f": { "type": "follow.start", "newTab": false },
    "F": { "type": "follow.start", "newTab": true, "background": false },
    "m": { "type": "mark.set.prefix" },
    "'": { "type": "mark.jump.prefix" },
    "H": { "type": "navigate.history.prev" },
    "L": { "type": "navigate.history.next" },
    "[[": { "type": "navigate.link.prev" },
    "]]": { "type": "navigate.link.next" },
    "gu": { "type": "navigate.parent" },
    "gU": { "type": "navigate.root" },
    "gi": { "type": "focus.input" },
    "gf": { "type": "page.source" },
    "gh": { "type": "page.home" },
    "gH": { "type": "page.home", "newTab": true },
    "gr": { "type": "tabs.reader.toggle" },
    "y": { "type": "urls.yank" },
    "p": { "type": "urls.paste", "newTab": false },
    "P": { "type": "urls.paste", "newTab": true },
    "/": { "type": "find.start" },
    "n": { "type": "find.next" },
    "N": { "type": "find.prev" },
    ".": { "type": "repeat.last" },
    "<S-Esc>": { "type": "addon.toggle.enabled" }
  },
  "search": {
    "default": "google",
    "engines": {
      "google": "https://google.com/search?q={}",
      "yahoo": "https://search.yahoo.com/search?p={}",
      "bing": "https://www.bing.com/search?q={}",
      "duckduckgo": "https://duckduckgo.com/?q={}",
      "twitter": "https://twitter.com/search?q={}",
      "wikipedia": "https://en.wikipedia.org/w/index.php?search={}"
    }
  },
  "properties": {
    "hintchars": "abcdefghijklmnopqrstuvwxyz",
    "smoothscroll": false,
    "complete": "sbh",
    "colorscheme": "system"
  },
  "blacklist": [
  ]
}`;
exports.DefaultSetting = Settings.fromJSON(JSON.parse(exports.DefaultSettingJSONText));


/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var ColorScheme;
(function (ColorScheme) {
    ColorScheme["System"] = "system";
    ColorScheme["Light"] = "light";
    ColorScheme["Dark"] = "dark";
})(ColorScheme || (ColorScheme = {}));
exports.default = ColorScheme;


/***/ }),
/* 12 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var reactIs = __webpack_require__(8);

/**
 * Copyright 2015, Yahoo! Inc.
 * Copyrights licensed under the New BSD License. See the accompanying LICENSE file for terms.
 */
var REACT_STATICS = {
  childContextTypes: true,
  contextType: true,
  contextTypes: true,
  defaultProps: true,
  displayName: true,
  getDefaultProps: true,
  getDerivedStateFromError: true,
  getDerivedStateFromProps: true,
  mixins: true,
  propTypes: true,
  type: true
};
var KNOWN_STATICS = {
  name: true,
  length: true,
  prototype: true,
  caller: true,
  callee: true,
  arguments: true,
  arity: true
};
var FORWARD_REF_STATICS = {
  '$$typeof': true,
  render: true,
  defaultProps: true,
  displayName: true,
  propTypes: true
};
var MEMO_STATICS = {
  '$$typeof': true,
  compare: true,
  defaultProps: true,
  displayName: true,
  propTypes: true,
  type: true
};
var TYPE_STATICS = {};
TYPE_STATICS[reactIs.ForwardRef] = FORWARD_REF_STATICS;
TYPE_STATICS[reactIs.Memo] = MEMO_STATICS;

function getStatics(component) {
  // React v16.11 and below
  if (reactIs.isMemo(component)) {
    return MEMO_STATICS;
  } // React v16.12 and above


  return TYPE_STATICS[component['$$typeof']] || REACT_STATICS;
}

var defineProperty = Object.defineProperty;
var getOwnPropertyNames = Object.getOwnPropertyNames;
var getOwnPropertySymbols = Object.getOwnPropertySymbols;
var getOwnPropertyDescriptor = Object.getOwnPropertyDescriptor;
var getPrototypeOf = Object.getPrototypeOf;
var objectPrototype = Object.prototype;
function hoistNonReactStatics(targetComponent, sourceComponent, blacklist) {
  if (typeof sourceComponent !== 'string') {
    // don't hoist over string (html) components
    if (objectPrototype) {
      var inheritedComponent = getPrototypeOf(sourceComponent);

      if (inheritedComponent && inheritedComponent !== objectPrototype) {
        hoistNonReactStatics(targetComponent, inheritedComponent, blacklist);
      }
    }

    var keys = getOwnPropertyNames(sourceComponent);

    if (getOwnPropertySymbols) {
      keys = keys.concat(getOwnPropertySymbols(sourceComponent));
    }

    var targetStatics = getStatics(targetComponent);
    var sourceStatics = getStatics(sourceComponent);

    for (var i = 0; i < keys.length; ++i) {
      var key = keys[i];

      if (!KNOWN_STATICS[key] && !(blacklist && blacklist[key]) && !(sourceStatics && sourceStatics[key]) && !(targetStatics && targetStatics[key])) {
        var descriptor = getOwnPropertyDescriptor(sourceComponent, key);

        try {
          // Avoid failures from read-only properties
          defineProperty(targetComponent, key, descriptor);
        } catch (e) {}
      }
    }
  }

  return targetComponent;
}

module.exports = hoistNonReactStatics;


/***/ }),
/* 13 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
class Key {
    constructor({ key, shift = false, ctrl = false, alt = false, meta = false, }) {
        this.key = key;
        this.shift = shift;
        this.ctrl = ctrl;
        this.alt = alt;
        this.meta = meta;
    }
    static fromMapKey(str) {
        if (str.startsWith("<") && str.endsWith(">")) {
            const inner = str.slice(1, -1);
            const shift = inner.includes("S-");
            let base = inner.slice(inner.lastIndexOf("-") + 1);
            if (shift && base.length === 1) {
                base = base.toUpperCase();
            }
            else if (!shift && base.length === 1) {
                base = base.toLowerCase();
            }
            return new Key({
                key: base,
                shift: shift,
                ctrl: inner.includes("C-"),
                alt: inner.includes("A-"),
                meta: inner.includes("M-"),
            });
        }
        return new Key({
            key: str,
            shift: str.toLowerCase() !== str,
            ctrl: false,
            alt: false,
            meta: false,
        });
    }
    isDigit() {
        return digits.includes(this.key) && !this.ctrl && !this.alt && !this.meta;
    }
    equals(key) {
        return (this.key === key.key &&
            this.ctrl === key.ctrl &&
            this.meta === key.meta &&
            this.alt === key.alt &&
            this.shift === key.shift);
    }
}
exports.default = Key;


/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
class Search {
    constructor(defaultEngine, engines) {
        this.defaultEngine = defaultEngine;
        this.engines = engines;
    }
    static fromJSON(json) {
        for (const [name, url] of Object.entries(json.engines)) {
            if (!/^[a-zA-Z0-9]+$/.test(name)) {
                throw new TypeError("Search engine's name must be [a-zA-Z0-9]+");
            }
            const matches = url.match(/{}/g);
            if (matches === null) {
                throw new TypeError(`No {}-placeholders in URL of "${name}"`);
            }
            else if (matches.length > 1) {
                throw new TypeError(`Multiple {}-placeholders in URL of "${name}"`);
            }
        }
        if (!Object.keys(json.engines).includes(json.default)) {
            throw new TypeError(`Default engine "${json.default}" not found`);
        }
        return new Search(json.default, json.engines);
    }
    toJSON() {
        return {
            default: this.defaultEngine,
            engines: this.engines,
        };
    }
}
exports.default = Search;


/***/ }),
/* 15 */,
/* 16 */
/***/ (function(module, exports) {

// shim for using process in browser
var process = module.exports = {};

// cached from whatever global is present so that test runners that stub it
// don't break things.  But we need to wrap it in a try catch in case it is
// wrapped in strict mode code which doesn't define any globals.  It's inside a
// function because try/catches deoptimize in certain engines.

var cachedSetTimeout;
var cachedClearTimeout;

function defaultSetTimout() {
    throw new Error('setTimeout has not been defined');
}
function defaultClearTimeout () {
    throw new Error('clearTimeout has not been defined');
}
(function () {
    try {
        if (typeof setTimeout === 'function') {
            cachedSetTimeout = setTimeout;
        } else {
            cachedSetTimeout = defaultSetTimout;
        }
    } catch (e) {
        cachedSetTimeout = defaultSetTimout;
    }
    try {
        if (typeof clearTimeout === 'function') {
            cachedClearTimeout = clearTimeout;
        } else {
            cachedClearTimeout = defaultClearTimeout;
        }
    } catch (e) {
        cachedClearTimeout = defaultClearTimeout;
    }
} ())
function runTimeout(fun) {
    if (cachedSetTimeout === setTimeout) {
        //normal enviroments in sane situations
        return setTimeout(fun, 0);
    }
    // if setTimeout wasn't available but was latter defined
    if ((cachedSetTimeout === defaultSetTimout || !cachedSetTimeout) && setTimeout) {
        cachedSetTimeout = setTimeout;
        return setTimeout(fun, 0);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedSetTimeout(fun, 0);
    } catch(e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't trust the global object when called normally
            return cachedSetTimeout.call(null, fun, 0);
        } catch(e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error
            return cachedSetTimeout.call(this, fun, 0);
        }
    }


}
function runClearTimeout(marker) {
    if (cachedClearTimeout === clearTimeout) {
        //normal enviroments in sane situations
        return clearTimeout(marker);
    }
    // if clearTimeout wasn't available but was latter defined
    if ((cachedClearTimeout === defaultClearTimeout || !cachedClearTimeout) && clearTimeout) {
        cachedClearTimeout = clearTimeout;
        return clearTimeout(marker);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedClearTimeout(marker);
    } catch (e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't  trust the global object when called normally
            return cachedClearTimeout.call(null, marker);
        } catch (e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error.
            // Some versions of I.E. have different rules for clearTimeout vs setTimeout
            return cachedClearTimeout.call(this, marker);
        }
    }



}
var queue = [];
var draining = false;
var currentQueue;
var queueIndex = -1;

function cleanUpNextTick() {
    if (!draining || !currentQueue) {
        return;
    }
    draining = false;
    if (currentQueue.length) {
        queue = currentQueue.concat(queue);
    } else {
        queueIndex = -1;
    }
    if (queue.length) {
        drainQueue();
    }
}

function drainQueue() {
    if (draining) {
        return;
    }
    var timeout = runTimeout(cleanUpNextTick);
    draining = true;

    var len = queue.length;
    while(len) {
        currentQueue = queue;
        queue = [];
        while (++queueIndex < len) {
            if (currentQueue) {
                currentQueue[queueIndex].run();
            }
        }
        queueIndex = -1;
        len = queue.length;
    }
    currentQueue = null;
    draining = false;
    runClearTimeout(timeout);
}

process.nextTick = function (fun) {
    var args = new Array(arguments.length - 1);
    if (arguments.length > 1) {
        for (var i = 1; i < arguments.length; i++) {
            args[i - 1] = arguments[i];
        }
    }
    queue.push(new Item(fun, args));
    if (queue.length === 1 && !draining) {
        runTimeout(drainQueue);
    }
};

// v8 likes predictible objects
function Item(fun, array) {
    this.fun = fun;
    this.array = array;
}
Item.prototype.run = function () {
    this.fun.apply(null, this.array);
};
process.title = 'browser';
process.browser = true;
process.env = {};
process.argv = [];
process.version = ''; // empty string to avoid regexp issues
process.versions = {};

function noop() {}

process.on = noop;
process.addListener = noop;
process.once = noop;
process.off = noop;
process.removeListener = noop;
process.removeAllListeners = noop;
process.emit = noop;
process.prependListener = noop;
process.prependOnceListener = noop;

process.listeners = function (name) { return [] }

process.binding = function (name) {
    throw new Error('process.binding is not supported');
};

process.cwd = function () { return '/' };
process.chdir = function (dir) {
    throw new Error('process.chdir is not supported');
};
process.umask = function() { return 0; };


/***/ }),
/* 17 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var equal = __webpack_require__(18);
var validate = (function() {
  var pattern0 = new RegExp('.*');
  var refVal = [];
  return function validate(data, dataPath, parentData, parentDataProperty, rootData) {
    'use strict';
    var vErrors = null;
    var errors = 0;
    if ((data && typeof data === "object" && !Array.isArray(data))) {
      var errs__0 = errors;
      var valid1 = true;
      for (var key0 in data) {
        var isAdditional0 = !( false || key0 == 'keymaps' || key0 == 'search' || key0 == 'properties' || key0 == 'blacklist');
        if (isAdditional0) {
          valid1 = false;
          validate.errors = [{
            keyword: 'additionalProperties',
            dataPath: (dataPath || '') + "",
            schemaPath: '#/additionalProperties',
            params: {
              additionalProperty: '' + key0 + ''
            },
            message: 'should NOT have additional properties'
          }];
          return false;
          break;
        }
      }
      if (valid1) {
        var data1 = data.keymaps;
        if (data1 === undefined) {
          valid1 = true;
        } else {
          var errs_1 = errors;
          if ((data1 && typeof data1 === "object" && !Array.isArray(data1))) {
            var errs__1 = errors;
            var valid2 = true;
            for (var key1 in data1) {
              if (pattern0.test(key1)) {
                var data2 = data1[key1];
                var errs_2 = errors;
                if ((data2 && typeof data2 === "object" && !Array.isArray(data2))) {
                  if (true) {
                    var errs__2 = errors;
                    var valid3 = true;
                    if (data2.type === undefined) {
                      valid3 = false;
                      validate.errors = [{
                        keyword: 'required',
                        dataPath: (dataPath || '') + '.keymaps[\'' + key1 + '\']',
                        schemaPath: '#/properties/keymaps/patternProperties/.*/required',
                        params: {
                          missingProperty: 'type'
                        },
                        message: 'should have required property \'type\''
                      }];
                      return false;
                    } else {
                      var errs_3 = errors;
                      if (typeof data2.type !== "string") {
                        validate.errors = [{
                          keyword: 'type',
                          dataPath: (dataPath || '') + '.keymaps[\'' + key1 + '\'].type',
                          schemaPath: '#/properties/keymaps/patternProperties/.*/properties/type/type',
                          params: {
                            type: 'string'
                          },
                          message: 'should be string'
                        }];
                        return false;
                      }
                      var valid3 = errors === errs_3;
                    }
                  }
                } else {
                  validate.errors = [{
                    keyword: 'type',
                    dataPath: (dataPath || '') + '.keymaps[\'' + key1 + '\']',
                    schemaPath: '#/properties/keymaps/patternProperties/.*/type',
                    params: {
                      type: 'object'
                    },
                    message: 'should be object'
                  }];
                  return false;
                }
                var valid2 = errors === errs_2;
                if (!valid2) break;
              } else valid2 = true;
            }
          } else {
            validate.errors = [{
              keyword: 'type',
              dataPath: (dataPath || '') + '.keymaps',
              schemaPath: '#/properties/keymaps/type',
              params: {
                type: 'object'
              },
              message: 'should be object'
            }];
            return false;
          }
          var valid1 = errors === errs_1;
        }
        if (valid1) {
          var data1 = data.search;
          if (data1 === undefined) {
            valid1 = true;
          } else {
            var errs_1 = errors;
            if ((data1 && typeof data1 === "object" && !Array.isArray(data1))) {
              if (true) {
                var errs__1 = errors;
                var valid2 = true;
                if (data1.default === undefined) {
                  valid2 = false;
                  validate.errors = [{
                    keyword: 'required',
                    dataPath: (dataPath || '') + '.search',
                    schemaPath: '#/properties/search/required',
                    params: {
                      missingProperty: 'default'
                    },
                    message: 'should have required property \'default\''
                  }];
                  return false;
                } else {
                  var errs_2 = errors;
                  if (typeof data1.default !== "string") {
                    validate.errors = [{
                      keyword: 'type',
                      dataPath: (dataPath || '') + '.search.default',
                      schemaPath: '#/properties/search/properties/default/type',
                      params: {
                        type: 'string'
                      },
                      message: 'should be string'
                    }];
                    return false;
                  }
                  var valid2 = errors === errs_2;
                }
                if (valid2) {
                  var data2 = data1.engines;
                  if (data2 === undefined) {
                    valid2 = false;
                    validate.errors = [{
                      keyword: 'required',
                      dataPath: (dataPath || '') + '.search',
                      schemaPath: '#/properties/search/required',
                      params: {
                        missingProperty: 'engines'
                      },
                      message: 'should have required property \'engines\''
                    }];
                    return false;
                  } else {
                    var errs_2 = errors;
                    if ((data2 && typeof data2 === "object" && !Array.isArray(data2))) {
                      var errs__2 = errors;
                      var valid3 = true;
                      for (var key2 in data2) {
                        if (pattern0.test(key2)) {
                          var errs_3 = errors;
                          if (typeof data2[key2] !== "string") {
                            validate.errors = [{
                              keyword: 'type',
                              dataPath: (dataPath || '') + '.search.engines[\'' + key2 + '\']',
                              schemaPath: '#/properties/search/properties/engines/patternProperties/.*/type',
                              params: {
                                type: 'string'
                              },
                              message: 'should be string'
                            }];
                            return false;
                          }
                          var valid3 = errors === errs_3;
                          if (!valid3) break;
                        } else valid3 = true;
                      }
                    } else {
                      validate.errors = [{
                        keyword: 'type',
                        dataPath: (dataPath || '') + '.search.engines',
                        schemaPath: '#/properties/search/properties/engines/type',
                        params: {
                          type: 'object'
                        },
                        message: 'should be object'
                      }];
                      return false;
                    }
                    var valid2 = errors === errs_2;
                  }
                }
              }
            } else {
              validate.errors = [{
                keyword: 'type',
                dataPath: (dataPath || '') + '.search',
                schemaPath: '#/properties/search/type',
                params: {
                  type: 'object'
                },
                message: 'should be object'
              }];
              return false;
            }
            var valid1 = errors === errs_1;
          }
          if (valid1) {
            var data1 = data.properties;
            if (data1 === undefined) {
              valid1 = true;
            } else {
              var errs_1 = errors;
              if ((data1 && typeof data1 === "object" && !Array.isArray(data1))) {
                var errs__1 = errors;
                var valid2 = true;
                if (data1.hintchars === undefined) {
                  valid2 = true;
                } else {
                  var errs_2 = errors;
                  if (typeof data1.hintchars !== "string") {
                    validate.errors = [{
                      keyword: 'type',
                      dataPath: (dataPath || '') + '.properties.hintchars',
                      schemaPath: '#/properties/properties/properties/hintchars/type',
                      params: {
                        type: 'string'
                      },
                      message: 'should be string'
                    }];
                    return false;
                  }
                  var valid2 = errors === errs_2;
                }
                if (valid2) {
                  if (data1.smoothscroll === undefined) {
                    valid2 = true;
                  } else {
                    var errs_2 = errors;
                    if (typeof data1.smoothscroll !== "boolean") {
                      validate.errors = [{
                        keyword: 'type',
                        dataPath: (dataPath || '') + '.properties.smoothscroll',
                        schemaPath: '#/properties/properties/properties/smoothscroll/type',
                        params: {
                          type: 'boolean'
                        },
                        message: 'should be boolean'
                      }];
                      return false;
                    }
                    var valid2 = errors === errs_2;
                  }
                  if (valid2) {
                    if (data1.complete === undefined) {
                      valid2 = true;
                    } else {
                      var errs_2 = errors;
                      if (typeof data1.complete !== "string") {
                        validate.errors = [{
                          keyword: 'type',
                          dataPath: (dataPath || '') + '.properties.complete',
                          schemaPath: '#/properties/properties/properties/complete/type',
                          params: {
                            type: 'string'
                          },
                          message: 'should be string'
                        }];
                        return false;
                      }
                      var valid2 = errors === errs_2;
                    }
                    if (valid2) {
                      var data2 = data1.colorscheme;
                      if (data2 === undefined) {
                        valid2 = true;
                      } else {
                        var errs_2 = errors;
                        if (typeof data2 !== "string") {
                          validate.errors = [{
                            keyword: 'type',
                            dataPath: (dataPath || '') + '.properties.colorscheme',
                            schemaPath: '#/properties/properties/properties/colorscheme/type',
                            params: {
                              type: 'string'
                            },
                            message: 'should be string'
                          }];
                          return false;
                        }
                        var schema2 = validate.schema.properties.properties.properties.colorscheme.enum;
                        var valid2;
                        valid2 = false;
                        for (var i2 = 0; i2 < schema2.length; i2++)
                          if (equal(data2, schema2[i2])) {
                            valid2 = true;
                            break;
                          } if (!valid2) {
                          validate.errors = [{
                            keyword: 'enum',
                            dataPath: (dataPath || '') + '.properties.colorscheme',
                            schemaPath: '#/properties/properties/properties/colorscheme/enum',
                            params: {
                              allowedValues: schema2
                            },
                            message: 'should be equal to one of the allowed values'
                          }];
                          return false;
                        }
                        var valid2 = errors === errs_2;
                      }
                    }
                  }
                }
              } else {
                validate.errors = [{
                  keyword: 'type',
                  dataPath: (dataPath || '') + '.properties',
                  schemaPath: '#/properties/properties/type',
                  params: {
                    type: 'object'
                  },
                  message: 'should be object'
                }];
                return false;
              }
              var valid1 = errors === errs_1;
            }
            if (valid1) {
              var data1 = data.blacklist;
              if (data1 === undefined) {
                valid1 = true;
              } else {
                var errs_1 = errors;
                if (Array.isArray(data1)) {
                  var errs__1 = errors;
                  var valid1;
                  for (var i1 = 0; i1 < data1.length; i1++) {
                    var data2 = data1[i1];
                    var errs_2 = errors;
                    var errs__2 = errors;
                    var valid2 = false;
                    var errs_3 = errors;
                    if (typeof data2 !== "string") {
                      var err = {
                        keyword: 'type',
                        dataPath: (dataPath || '') + '.blacklist[' + i1 + ']',
                        schemaPath: '#/properties/blacklist/items/anyOf/0/type',
                        params: {
                          type: 'string'
                        },
                        message: 'should be string'
                      };
                      if (vErrors === null) vErrors = [err];
                      else vErrors.push(err);
                      errors++;
                    }
                    var valid3 = errors === errs_3;
                    valid2 = valid2 || valid3;
                    if (!valid2) {
                      var errs_3 = errors;
                      if ((data2 && typeof data2 === "object" && !Array.isArray(data2))) {
                        if (true) {
                          var errs__3 = errors;
                          var valid4 = true;
                          if (data2.url === undefined) {
                            valid4 = false;
                            var err = {
                              keyword: 'required',
                              dataPath: (dataPath || '') + '.blacklist[' + i1 + ']',
                              schemaPath: '#/properties/blacklist/items/anyOf/1/required',
                              params: {
                                missingProperty: 'url'
                              },
                              message: 'should have required property \'url\''
                            };
                            if (vErrors === null) vErrors = [err];
                            else vErrors.push(err);
                            errors++;
                          } else {
                            var errs_4 = errors;
                            if (typeof data2.url !== "string") {
                              var err = {
                                keyword: 'type',
                                dataPath: (dataPath || '') + '.blacklist[' + i1 + '].url',
                                schemaPath: '#/properties/blacklist/items/anyOf/1/properties/url/type',
                                params: {
                                  type: 'string'
                                },
                                message: 'should be string'
                              };
                              if (vErrors === null) vErrors = [err];
                              else vErrors.push(err);
                              errors++;
                            }
                            var valid4 = errors === errs_4;
                          }
                          if (valid4) {
                            var data3 = data2.keys;
                            if (data3 === undefined) {
                              valid4 = false;
                              var err = {
                                keyword: 'required',
                                dataPath: (dataPath || '') + '.blacklist[' + i1 + ']',
                                schemaPath: '#/properties/blacklist/items/anyOf/1/required',
                                params: {
                                  missingProperty: 'keys'
                                },
                                message: 'should have required property \'keys\''
                              };
                              if (vErrors === null) vErrors = [err];
                              else vErrors.push(err);
                              errors++;
                            } else {
                              var errs_4 = errors;
                              if (Array.isArray(data3)) {
                                var errs__4 = errors;
                                var valid4;
                                for (var i4 = 0; i4 < data3.length; i4++) {
                                  var errs_5 = errors;
                                  if (typeof data3[i4] !== "string") {
                                    var err = {
                                      keyword: 'type',
                                      dataPath: (dataPath || '') + '.blacklist[' + i1 + '].keys[' + i4 + ']',
                                      schemaPath: '#/properties/blacklist/items/anyOf/1/properties/keys/items/type',
                                      params: {
                                        type: 'string'
                                      },
                                      message: 'should be string'
                                    };
                                    if (vErrors === null) vErrors = [err];
                                    else vErrors.push(err);
                                    errors++;
                                  }
                                  var valid5 = errors === errs_5;
                                  if (!valid5) break;
                                }
                              } else {
                                var err = {
                                  keyword: 'type',
                                  dataPath: (dataPath || '') + '.blacklist[' + i1 + '].keys',
                                  schemaPath: '#/properties/blacklist/items/anyOf/1/properties/keys/type',
                                  params: {
                                    type: 'array'
                                  },
                                  message: 'should be array'
                                };
                                if (vErrors === null) vErrors = [err];
                                else vErrors.push(err);
                                errors++;
                              }
                              var valid4 = errors === errs_4;
                            }
                          }
                        }
                      } else {
                        var err = {
                          keyword: 'type',
                          dataPath: (dataPath || '') + '.blacklist[' + i1 + ']',
                          schemaPath: '#/properties/blacklist/items/anyOf/1/type',
                          params: {
                            type: 'object'
                          },
                          message: 'should be object'
                        };
                        if (vErrors === null) vErrors = [err];
                        else vErrors.push(err);
                        errors++;
                      }
                      var valid3 = errors === errs_3;
                      valid2 = valid2 || valid3;
                    }
                    if (!valid2) {
                      var err = {
                        keyword: 'anyOf',
                        dataPath: (dataPath || '') + '.blacklist[' + i1 + ']',
                        schemaPath: '#/properties/blacklist/items/anyOf',
                        params: {},
                        message: 'should match some schema in anyOf'
                      };
                      if (vErrors === null) vErrors = [err];
                      else vErrors.push(err);
                      errors++;
                      validate.errors = vErrors;
                      return false;
                    } else {
                      errors = errs__2;
                      if (vErrors !== null) {
                        if (errs__2) vErrors.length = errs__2;
                        else vErrors = null;
                      }
                    }
                    var valid2 = errors === errs_2;
                    if (!valid2) break;
                  }
                } else {
                  validate.errors = [{
                    keyword: 'type',
                    dataPath: (dataPath || '') + '.blacklist',
                    schemaPath: '#/properties/blacklist/type',
                    params: {
                      type: 'array'
                    },
                    message: 'should be array'
                  }];
                  return false;
                }
                var valid1 = errors === errs_1;
              }
            }
          }
        }
      }
    } else {
      validate.errors = [{
        keyword: 'type',
        dataPath: (dataPath || '') + "",
        schemaPath: '#/type',
        params: {
          type: 'object'
        },
        message: 'should be object'
      }];
      return false;
    }
    validate.errors = vErrors;
    return errors === 0;
  };
})();
validate.schema = {
  "type": "object",
  "properties": {
    "keymaps": {
      "type": "object",
      "patternProperties": {
        ".*": {
          "type": "object",
          "properties": {
            "type": {
              "type": "string"
            }
          },
          "required": ["type"]
        }
      }
    },
    "search": {
      "type": "object",
      "properties": {
        "default": {
          "type": "string"
        },
        "engines": {
          "type": "object",
          "patternProperties": {
            ".*": {
              "type": "string"
            }
          }
        }
      },
      "required": ["default", "engines"]
    },
    "properties": {
      "type": "object",
      "properties": {
        "hintchars": {
          "type": "string"
        },
        "smoothscroll": {
          "type": "boolean"
        },
        "complete": {
          "type": "string"
        },
        "colorscheme": {
          "type": "string",
          "enum": ["system", "light", "dark"]
        }
      }
    },
    "blacklist": {
      "type": "array",
      "items": {
        "anyOf": [{
          "type": "string"
        }, {
          "type": "object",
          "properties": {
            "url": {
              "type": "string"
            },
            "keys": {
              "type": "array",
              "items": {
                "type": "string"
              }
            }
          },
          "required": ["url", "keys"]
        }]
      }
    }
  },
  "additionalProperties": false
};
validate.errors = null;
module.exports = validate;

/***/ }),
/* 18 */
/***/ (function(module, exports, __webpack_require__) {

// do NOT remove this file - it would break pre-compiled schemas
// https://github.com/ajv-validator/ajv/issues/889
module.exports = __webpack_require__(19)


/***/ }),
/* 19 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


// do not edit .js files directly - edit src/index.jst



module.exports = function equal(a, b) {
  if (a === b) return true;

  if (a && b && typeof a == 'object' && typeof b == 'object') {
    if (a.constructor !== b.constructor) return false;

    var length, i, keys;
    if (Array.isArray(a)) {
      length = a.length;
      if (length != b.length) return false;
      for (i = length; i-- !== 0;)
        if (!equal(a[i], b[i])) return false;
      return true;
    }



    if (a.constructor === RegExp) return a.source === b.source && a.flags === b.flags;
    if (a.valueOf !== Object.prototype.valueOf) return a.valueOf() === b.valueOf();
    if (a.toString !== Object.prototype.toString) return a.toString() === b.toString();

    keys = Object.keys(a);
    length = keys.length;
    if (length !== Object.keys(b).length) return false;

    for (i = length; i-- !== 0;)
      if (!Object.prototype.hasOwnProperty.call(b, keys[i])) return false;

    for (i = length; i-- !== 0;) {
      var key = keys[i];

      if (!equal(a[key], b[key])) return false;
    }

    return true;
  }

  // true if both NaN, false otherwise
  return a!==a && b!==b;
};


/***/ }),
/* 20 */,
/* 21 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";

// CONCATENATED MODULE: ./node_modules/@emotion/memoize/dist/memoize.browser.esm.js
function memoize(fn) {
  var cache = {};
  return function (arg) {
    if (cache[arg] === undefined) cache[arg] = fn(arg);
    return cache[arg];
  };
}

/* harmony default export */ var memoize_browser_esm = (memoize);

// CONCATENATED MODULE: ./node_modules/@emotion/is-prop-valid/dist/is-prop-valid.browser.esm.js


var reactPropsRegex = /^((children|dangerouslySetInnerHTML|key|ref|autoFocus|defaultValue|defaultChecked|innerHTML|suppressContentEditableWarning|suppressHydrationWarning|valueLink|accept|acceptCharset|accessKey|action|allow|allowUserMedia|allowPaymentRequest|allowFullScreen|allowTransparency|alt|async|autoComplete|autoPlay|capture|cellPadding|cellSpacing|challenge|charSet|checked|cite|classID|className|cols|colSpan|content|contentEditable|contextMenu|controls|controlsList|coords|crossOrigin|data|dateTime|decoding|default|defer|dir|disabled|disablePictureInPicture|download|draggable|encType|form|formAction|formEncType|formMethod|formNoValidate|formTarget|frameBorder|headers|height|hidden|high|href|hrefLang|htmlFor|httpEquiv|id|inputMode|integrity|is|keyParams|keyType|kind|label|lang|list|loading|loop|low|marginHeight|marginWidth|max|maxLength|media|mediaGroup|method|min|minLength|multiple|muted|name|nonce|noValidate|open|optimum|pattern|placeholder|playsInline|poster|preload|profile|radioGroup|readOnly|referrerPolicy|rel|required|reversed|role|rows|rowSpan|sandbox|scope|scoped|scrolling|seamless|selected|shape|size|sizes|slot|span|spellCheck|src|srcDoc|srcLang|srcSet|start|step|style|summary|tabIndex|target|title|type|useMap|value|width|wmode|wrap|about|datatype|inlist|prefix|property|resource|typeof|vocab|autoCapitalize|autoCorrect|autoSave|color|inert|itemProp|itemScope|itemType|itemID|itemRef|on|results|security|unselectable|accentHeight|accumulate|additive|alignmentBaseline|allowReorder|alphabetic|amplitude|arabicForm|ascent|attributeName|attributeType|autoReverse|azimuth|baseFrequency|baselineShift|baseProfile|bbox|begin|bias|by|calcMode|capHeight|clip|clipPathUnits|clipPath|clipRule|colorInterpolation|colorInterpolationFilters|colorProfile|colorRendering|contentScriptType|contentStyleType|cursor|cx|cy|d|decelerate|descent|diffuseConstant|direction|display|divisor|dominantBaseline|dur|dx|dy|edgeMode|elevation|enableBackground|end|exponent|externalResourcesRequired|fill|fillOpacity|fillRule|filter|filterRes|filterUnits|floodColor|floodOpacity|focusable|fontFamily|fontSize|fontSizeAdjust|fontStretch|fontStyle|fontVariant|fontWeight|format|from|fr|fx|fy|g1|g2|glyphName|glyphOrientationHorizontal|glyphOrientationVertical|glyphRef|gradientTransform|gradientUnits|hanging|horizAdvX|horizOriginX|ideographic|imageRendering|in|in2|intercept|k|k1|k2|k3|k4|kernelMatrix|kernelUnitLength|kerning|keyPoints|keySplines|keyTimes|lengthAdjust|letterSpacing|lightingColor|limitingConeAngle|local|markerEnd|markerMid|markerStart|markerHeight|markerUnits|markerWidth|mask|maskContentUnits|maskUnits|mathematical|mode|numOctaves|offset|opacity|operator|order|orient|orientation|origin|overflow|overlinePosition|overlineThickness|panose1|paintOrder|pathLength|patternContentUnits|patternTransform|patternUnits|pointerEvents|points|pointsAtX|pointsAtY|pointsAtZ|preserveAlpha|preserveAspectRatio|primitiveUnits|r|radius|refX|refY|renderingIntent|repeatCount|repeatDur|requiredExtensions|requiredFeatures|restart|result|rotate|rx|ry|scale|seed|shapeRendering|slope|spacing|specularConstant|specularExponent|speed|spreadMethod|startOffset|stdDeviation|stemh|stemv|stitchTiles|stopColor|stopOpacity|strikethroughPosition|strikethroughThickness|string|stroke|strokeDasharray|strokeDashoffset|strokeLinecap|strokeLinejoin|strokeMiterlimit|strokeOpacity|strokeWidth|surfaceScale|systemLanguage|tableValues|targetX|targetY|textAnchor|textDecoration|textRendering|textLength|to|transform|u1|u2|underlinePosition|underlineThickness|unicode|unicodeBidi|unicodeRange|unitsPerEm|vAlphabetic|vHanging|vIdeographic|vMathematical|values|vectorEffect|version|vertAdvY|vertOriginX|vertOriginY|viewBox|viewTarget|visibility|widths|wordSpacing|writingMode|x|xHeight|x1|x2|xChannelSelector|xlinkActuate|xlinkArcrole|xlinkHref|xlinkRole|xlinkShow|xlinkTitle|xlinkType|xmlBase|xmlns|xmlnsXlink|xmlLang|xmlSpace|y|y1|y2|yChannelSelector|z|zoomAndPan|for|class|autofocus)|(([Dd][Aa][Tt][Aa]|[Aa][Rr][Ii][Aa]|x)-.*))$/; // https://esbench.com/bench/5bfee68a4cd7e6009ef61d23

var index = memoize_browser_esm(function (prop) {
  return reactPropsRegex.test(prop) || prop.charCodeAt(0) === 111
  /* o */
  && prop.charCodeAt(1) === 110
  /* n */
  && prop.charCodeAt(2) < 91;
}
/* Z+1 */
);

/* harmony default export */ var is_prop_valid_browser_esm = __webpack_exports__["a"] = (index);


/***/ }),
/* 22 */,
/* 23 */,
/* 24 */,
/* 25 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/*
object-assign
(c) Sindre Sorhus
@license MIT
*/


/* eslint-disable no-unused-vars */
var getOwnPropertySymbols = Object.getOwnPropertySymbols;
var hasOwnProperty = Object.prototype.hasOwnProperty;
var propIsEnumerable = Object.prototype.propertyIsEnumerable;

function toObject(val) {
	if (val === null || val === undefined) {
		throw new TypeError('Object.assign cannot be called with null or undefined');
	}

	return Object(val);
}

function shouldUseNative() {
	try {
		if (!Object.assign) {
			return false;
		}

		// Detect buggy property enumeration order in older V8 versions.

		// https://bugs.chromium.org/p/v8/issues/detail?id=4118
		var test1 = new String('abc');  // eslint-disable-line no-new-wrappers
		test1[5] = 'de';
		if (Object.getOwnPropertyNames(test1)[0] === '5') {
			return false;
		}

		// https://bugs.chromium.org/p/v8/issues/detail?id=3056
		var test2 = {};
		for (var i = 0; i < 10; i++) {
			test2['_' + String.fromCharCode(i)] = i;
		}
		var order2 = Object.getOwnPropertyNames(test2).map(function (n) {
			return test2[n];
		});
		if (order2.join('') !== '0123456789') {
			return false;
		}

		// https://bugs.chromium.org/p/v8/issues/detail?id=3056
		var test3 = {};
		'abcdefghijklmnopqrst'.split('').forEach(function (letter) {
			test3[letter] = letter;
		});
		if (Object.keys(Object.assign({}, test3)).join('') !==
				'abcdefghijklmnopqrst') {
			return false;
		}

		return true;
	} catch (err) {
		// We don't expect any of the above to throw, but better to be safe.
		return false;
	}
}

module.exports = shouldUseNative() ? Object.assign : function (target, source) {
	var from;
	var to = toObject(target);
	var symbols;

	for (var s = 1; s < arguments.length; s++) {
		from = Object(arguments[s]);

		for (var key in from) {
			if (hasOwnProperty.call(from, key)) {
				to[key] = from[key];
			}
		}

		if (getOwnPropertySymbols) {
			symbols = getOwnPropertySymbols(from);
			for (var i = 0; i < symbols.length; i++) {
				if (propIsEnumerable.call(from, symbols[i])) {
					to[symbols[i]] = from[symbols[i]];
				}
			}
		}
	}

	return to;
};


/***/ }),
/* 26 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function checkDCE() {
  /* global __REACT_DEVTOOLS_GLOBAL_HOOK__ */
  if (
    typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ === 'undefined' ||
    typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE !== 'function'
  ) {
    return;
  }
  if (false) {}
  try {
    // Verify that the code above has been dead code eliminated (DCE'd).
    __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(checkDCE);
  } catch (err) {
    // DevTools shouldn't crash React, no matter what.
    // We should still report in case we break this code.
    console.error(err);
  }
}

if (true) {
  // DCE check should happen before ReactDOM bundle executes so that
  // DevTools can report bad minification during injection.
  checkDCE();
  module.exports = __webpack_require__(37);
} else {}


/***/ }),
/* 27 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const styled_components_1 = tslib_1.__importDefault(__webpack_require__(5));
const styled = styled_components_1.default;
exports.default = styled;


/***/ }),
/* 28 */
/***/ (function(module, exports) {

//

module.exports = function shallowEqual(objA, objB, compare, compareContext) {
  var ret = compare ? compare.call(compareContext, objA, objB) : void 0;

  if (ret !== void 0) {
    return !!ret;
  }

  if (objA === objB) {
    return true;
  }

  if (typeof objA !== "object" || !objA || typeof objB !== "object" || !objB) {
    return false;
  }

  var keysA = Object.keys(objA);
  var keysB = Object.keys(objB);

  if (keysA.length !== keysB.length) {
    return false;
  }

  var bHasOwnProperty = Object.prototype.hasOwnProperty.bind(objB);

  // Test for A's keys different from B.
  for (var idx = 0; idx < keysA.length; idx++) {
    var key = keysA[idx];

    if (!bHasOwnProperty(key)) {
      return false;
    }

    var valueA = objA[key];
    var valueB = objB[key];

    ret = compare ? compare.call(compareContext, valueA, valueB, key) : void 0;

    if (ret === false || (ret === void 0 && valueA !== valueB)) {
      return false;
    }
  }

  return true;
};


/***/ }),
/* 29 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
function stylis_min (W) {
  function M(d, c, e, h, a) {
    for (var m = 0, b = 0, v = 0, n = 0, q, g, x = 0, K = 0, k, u = k = q = 0, l = 0, r = 0, I = 0, t = 0, B = e.length, J = B - 1, y, f = '', p = '', F = '', G = '', C; l < B;) {
      g = e.charCodeAt(l);
      l === J && 0 !== b + n + v + m && (0 !== b && (g = 47 === b ? 10 : 47), n = v = m = 0, B++, J++);

      if (0 === b + n + v + m) {
        if (l === J && (0 < r && (f = f.replace(N, '')), 0 < f.trim().length)) {
          switch (g) {
            case 32:
            case 9:
            case 59:
            case 13:
            case 10:
              break;

            default:
              f += e.charAt(l);
          }

          g = 59;
        }

        switch (g) {
          case 123:
            f = f.trim();
            q = f.charCodeAt(0);
            k = 1;

            for (t = ++l; l < B;) {
              switch (g = e.charCodeAt(l)) {
                case 123:
                  k++;
                  break;

                case 125:
                  k--;
                  break;

                case 47:
                  switch (g = e.charCodeAt(l + 1)) {
                    case 42:
                    case 47:
                      a: {
                        for (u = l + 1; u < J; ++u) {
                          switch (e.charCodeAt(u)) {
                            case 47:
                              if (42 === g && 42 === e.charCodeAt(u - 1) && l + 2 !== u) {
                                l = u + 1;
                                break a;
                              }

                              break;

                            case 10:
                              if (47 === g) {
                                l = u + 1;
                                break a;
                              }

                          }
                        }

                        l = u;
                      }

                  }

                  break;

                case 91:
                  g++;

                case 40:
                  g++;

                case 34:
                case 39:
                  for (; l++ < J && e.charCodeAt(l) !== g;) {
                  }

              }

              if (0 === k) break;
              l++;
            }

            k = e.substring(t, l);
            0 === q && (q = (f = f.replace(ca, '').trim()).charCodeAt(0));

            switch (q) {
              case 64:
                0 < r && (f = f.replace(N, ''));
                g = f.charCodeAt(1);

                switch (g) {
                  case 100:
                  case 109:
                  case 115:
                  case 45:
                    r = c;
                    break;

                  default:
                    r = O;
                }

                k = M(c, r, k, g, a + 1);
                t = k.length;
                0 < A && (r = X(O, f, I), C = H(3, k, r, c, D, z, t, g, a, h), f = r.join(''), void 0 !== C && 0 === (t = (k = C.trim()).length) && (g = 0, k = ''));
                if (0 < t) switch (g) {
                  case 115:
                    f = f.replace(da, ea);

                  case 100:
                  case 109:
                  case 45:
                    k = f + '{' + k + '}';
                    break;

                  case 107:
                    f = f.replace(fa, '$1 $2');
                    k = f + '{' + k + '}';
                    k = 1 === w || 2 === w && L('@' + k, 3) ? '@-webkit-' + k + '@' + k : '@' + k;
                    break;

                  default:
                    k = f + k, 112 === h && (k = (p += k, ''));
                } else k = '';
                break;

              default:
                k = M(c, X(c, f, I), k, h, a + 1);
            }

            F += k;
            k = I = r = u = q = 0;
            f = '';
            g = e.charCodeAt(++l);
            break;

          case 125:
          case 59:
            f = (0 < r ? f.replace(N, '') : f).trim();
            if (1 < (t = f.length)) switch (0 === u && (q = f.charCodeAt(0), 45 === q || 96 < q && 123 > q) && (t = (f = f.replace(' ', ':')).length), 0 < A && void 0 !== (C = H(1, f, c, d, D, z, p.length, h, a, h)) && 0 === (t = (f = C.trim()).length) && (f = '\x00\x00'), q = f.charCodeAt(0), g = f.charCodeAt(1), q) {
              case 0:
                break;

              case 64:
                if (105 === g || 99 === g) {
                  G += f + e.charAt(l);
                  break;
                }

              default:
                58 !== f.charCodeAt(t - 1) && (p += P(f, q, g, f.charCodeAt(2)));
            }
            I = r = u = q = 0;
            f = '';
            g = e.charCodeAt(++l);
        }
      }

      switch (g) {
        case 13:
        case 10:
          47 === b ? b = 0 : 0 === 1 + q && 107 !== h && 0 < f.length && (r = 1, f += '\x00');
          0 < A * Y && H(0, f, c, d, D, z, p.length, h, a, h);
          z = 1;
          D++;
          break;

        case 59:
        case 125:
          if (0 === b + n + v + m) {
            z++;
            break;
          }

        default:
          z++;
          y = e.charAt(l);

          switch (g) {
            case 9:
            case 32:
              if (0 === n + m + b) switch (x) {
                case 44:
                case 58:
                case 9:
                case 32:
                  y = '';
                  break;

                default:
                  32 !== g && (y = ' ');
              }
              break;

            case 0:
              y = '\\0';
              break;

            case 12:
              y = '\\f';
              break;

            case 11:
              y = '\\v';
              break;

            case 38:
              0 === n + b + m && (r = I = 1, y = '\f' + y);
              break;

            case 108:
              if (0 === n + b + m + E && 0 < u) switch (l - u) {
                case 2:
                  112 === x && 58 === e.charCodeAt(l - 3) && (E = x);

                case 8:
                  111 === K && (E = K);
              }
              break;

            case 58:
              0 === n + b + m && (u = l);
              break;

            case 44:
              0 === b + v + n + m && (r = 1, y += '\r');
              break;

            case 34:
            case 39:
              0 === b && (n = n === g ? 0 : 0 === n ? g : n);
              break;

            case 91:
              0 === n + b + v && m++;
              break;

            case 93:
              0 === n + b + v && m--;
              break;

            case 41:
              0 === n + b + m && v--;
              break;

            case 40:
              if (0 === n + b + m) {
                if (0 === q) switch (2 * x + 3 * K) {
                  case 533:
                    break;

                  default:
                    q = 1;
                }
                v++;
              }

              break;

            case 64:
              0 === b + v + n + m + u + k && (k = 1);
              break;

            case 42:
            case 47:
              if (!(0 < n + m + v)) switch (b) {
                case 0:
                  switch (2 * g + 3 * e.charCodeAt(l + 1)) {
                    case 235:
                      b = 47;
                      break;

                    case 220:
                      t = l, b = 42;
                  }

                  break;

                case 42:
                  47 === g && 42 === x && t + 2 !== l && (33 === e.charCodeAt(t + 2) && (p += e.substring(t, l + 1)), y = '', b = 0);
              }
          }

          0 === b && (f += y);
      }

      K = x;
      x = g;
      l++;
    }

    t = p.length;

    if (0 < t) {
      r = c;
      if (0 < A && (C = H(2, p, r, d, D, z, t, h, a, h), void 0 !== C && 0 === (p = C).length)) return G + p + F;
      p = r.join(',') + '{' + p + '}';

      if (0 !== w * E) {
        2 !== w || L(p, 2) || (E = 0);

        switch (E) {
          case 111:
            p = p.replace(ha, ':-moz-$1') + p;
            break;

          case 112:
            p = p.replace(Q, '::-webkit-input-$1') + p.replace(Q, '::-moz-$1') + p.replace(Q, ':-ms-input-$1') + p;
        }

        E = 0;
      }
    }

    return G + p + F;
  }

  function X(d, c, e) {
    var h = c.trim().split(ia);
    c = h;
    var a = h.length,
        m = d.length;

    switch (m) {
      case 0:
      case 1:
        var b = 0;

        for (d = 0 === m ? '' : d[0] + ' '; b < a; ++b) {
          c[b] = Z(d, c[b], e).trim();
        }

        break;

      default:
        var v = b = 0;

        for (c = []; b < a; ++b) {
          for (var n = 0; n < m; ++n) {
            c[v++] = Z(d[n] + ' ', h[b], e).trim();
          }
        }

    }

    return c;
  }

  function Z(d, c, e) {
    var h = c.charCodeAt(0);
    33 > h && (h = (c = c.trim()).charCodeAt(0));

    switch (h) {
      case 38:
        return c.replace(F, '$1' + d.trim());

      case 58:
        return d.trim() + c.replace(F, '$1' + d.trim());

      default:
        if (0 < 1 * e && 0 < c.indexOf('\f')) return c.replace(F, (58 === d.charCodeAt(0) ? '' : '$1') + d.trim());
    }

    return d + c;
  }

  function P(d, c, e, h) {
    var a = d + ';',
        m = 2 * c + 3 * e + 4 * h;

    if (944 === m) {
      d = a.indexOf(':', 9) + 1;
      var b = a.substring(d, a.length - 1).trim();
      b = a.substring(0, d).trim() + b + ';';
      return 1 === w || 2 === w && L(b, 1) ? '-webkit-' + b + b : b;
    }

    if (0 === w || 2 === w && !L(a, 1)) return a;

    switch (m) {
      case 1015:
        return 97 === a.charCodeAt(10) ? '-webkit-' + a + a : a;

      case 951:
        return 116 === a.charCodeAt(3) ? '-webkit-' + a + a : a;

      case 963:
        return 110 === a.charCodeAt(5) ? '-webkit-' + a + a : a;

      case 1009:
        if (100 !== a.charCodeAt(4)) break;

      case 969:
      case 942:
        return '-webkit-' + a + a;

      case 978:
        return '-webkit-' + a + '-moz-' + a + a;

      case 1019:
      case 983:
        return '-webkit-' + a + '-moz-' + a + '-ms-' + a + a;

      case 883:
        if (45 === a.charCodeAt(8)) return '-webkit-' + a + a;
        if (0 < a.indexOf('image-set(', 11)) return a.replace(ja, '$1-webkit-$2') + a;
        break;

      case 932:
        if (45 === a.charCodeAt(4)) switch (a.charCodeAt(5)) {
          case 103:
            return '-webkit-box-' + a.replace('-grow', '') + '-webkit-' + a + '-ms-' + a.replace('grow', 'positive') + a;

          case 115:
            return '-webkit-' + a + '-ms-' + a.replace('shrink', 'negative') + a;

          case 98:
            return '-webkit-' + a + '-ms-' + a.replace('basis', 'preferred-size') + a;
        }
        return '-webkit-' + a + '-ms-' + a + a;

      case 964:
        return '-webkit-' + a + '-ms-flex-' + a + a;

      case 1023:
        if (99 !== a.charCodeAt(8)) break;
        b = a.substring(a.indexOf(':', 15)).replace('flex-', '').replace('space-between', 'justify');
        return '-webkit-box-pack' + b + '-webkit-' + a + '-ms-flex-pack' + b + a;

      case 1005:
        return ka.test(a) ? a.replace(aa, ':-webkit-') + a.replace(aa, ':-moz-') + a : a;

      case 1e3:
        b = a.substring(13).trim();
        c = b.indexOf('-') + 1;

        switch (b.charCodeAt(0) + b.charCodeAt(c)) {
          case 226:
            b = a.replace(G, 'tb');
            break;

          case 232:
            b = a.replace(G, 'tb-rl');
            break;

          case 220:
            b = a.replace(G, 'lr');
            break;

          default:
            return a;
        }

        return '-webkit-' + a + '-ms-' + b + a;

      case 1017:
        if (-1 === a.indexOf('sticky', 9)) break;

      case 975:
        c = (a = d).length - 10;
        b = (33 === a.charCodeAt(c) ? a.substring(0, c) : a).substring(d.indexOf(':', 7) + 1).trim();

        switch (m = b.charCodeAt(0) + (b.charCodeAt(7) | 0)) {
          case 203:
            if (111 > b.charCodeAt(8)) break;

          case 115:
            a = a.replace(b, '-webkit-' + b) + ';' + a;
            break;

          case 207:
          case 102:
            a = a.replace(b, '-webkit-' + (102 < m ? 'inline-' : '') + 'box') + ';' + a.replace(b, '-webkit-' + b) + ';' + a.replace(b, '-ms-' + b + 'box') + ';' + a;
        }

        return a + ';';

      case 938:
        if (45 === a.charCodeAt(5)) switch (a.charCodeAt(6)) {
          case 105:
            return b = a.replace('-items', ''), '-webkit-' + a + '-webkit-box-' + b + '-ms-flex-' + b + a;

          case 115:
            return '-webkit-' + a + '-ms-flex-item-' + a.replace(ba, '') + a;

          default:
            return '-webkit-' + a + '-ms-flex-line-pack' + a.replace('align-content', '').replace(ba, '') + a;
        }
        break;

      case 973:
      case 989:
        if (45 !== a.charCodeAt(3) || 122 === a.charCodeAt(4)) break;

      case 931:
      case 953:
        if (!0 === la.test(d)) return 115 === (b = d.substring(d.indexOf(':') + 1)).charCodeAt(0) ? P(d.replace('stretch', 'fill-available'), c, e, h).replace(':fill-available', ':stretch') : a.replace(b, '-webkit-' + b) + a.replace(b, '-moz-' + b.replace('fill-', '')) + a;
        break;

      case 962:
        if (a = '-webkit-' + a + (102 === a.charCodeAt(5) ? '-ms-' + a : '') + a, 211 === e + h && 105 === a.charCodeAt(13) && 0 < a.indexOf('transform', 10)) return a.substring(0, a.indexOf(';', 27) + 1).replace(ma, '$1-webkit-$2') + a;
    }

    return a;
  }

  function L(d, c) {
    var e = d.indexOf(1 === c ? ':' : '{'),
        h = d.substring(0, 3 !== c ? e : 10);
    e = d.substring(e + 1, d.length - 1);
    return R(2 !== c ? h : h.replace(na, '$1'), e, c);
  }

  function ea(d, c) {
    var e = P(c, c.charCodeAt(0), c.charCodeAt(1), c.charCodeAt(2));
    return e !== c + ';' ? e.replace(oa, ' or ($1)').substring(4) : '(' + c + ')';
  }

  function H(d, c, e, h, a, m, b, v, n, q) {
    for (var g = 0, x = c, w; g < A; ++g) {
      switch (w = S[g].call(B, d, x, e, h, a, m, b, v, n, q)) {
        case void 0:
        case !1:
        case !0:
        case null:
          break;

        default:
          x = w;
      }
    }

    if (x !== c) return x;
  }

  function T(d) {
    switch (d) {
      case void 0:
      case null:
        A = S.length = 0;
        break;

      default:
        if ('function' === typeof d) S[A++] = d;else if ('object' === typeof d) for (var c = 0, e = d.length; c < e; ++c) {
          T(d[c]);
        } else Y = !!d | 0;
    }

    return T;
  }

  function U(d) {
    d = d.prefix;
    void 0 !== d && (R = null, d ? 'function' !== typeof d ? w = 1 : (w = 2, R = d) : w = 0);
    return U;
  }

  function B(d, c) {
    var e = d;
    33 > e.charCodeAt(0) && (e = e.trim());
    V = e;
    e = [V];

    if (0 < A) {
      var h = H(-1, c, e, e, D, z, 0, 0, 0, 0);
      void 0 !== h && 'string' === typeof h && (c = h);
    }

    var a = M(O, e, c, 0, 0);
    0 < A && (h = H(-2, a, e, e, D, z, a.length, 0, 0, 0), void 0 !== h && (a = h));
    V = '';
    E = 0;
    z = D = 1;
    return a;
  }

  var ca = /^\0+/g,
      N = /[\0\r\f]/g,
      aa = /: */g,
      ka = /zoo|gra/,
      ma = /([,: ])(transform)/g,
      ia = /,\r+?/g,
      F = /([\t\r\n ])*\f?&/g,
      fa = /@(k\w+)\s*(\S*)\s*/,
      Q = /::(place)/g,
      ha = /:(read-only)/g,
      G = /[svh]\w+-[tblr]{2}/,
      da = /\(\s*(.*)\s*\)/g,
      oa = /([\s\S]*?);/g,
      ba = /-self|flex-/g,
      na = /[^]*?(:[rp][el]a[\w-]+)[^]*/,
      la = /stretch|:\s*\w+\-(?:conte|avail)/,
      ja = /([^-])(image-set\()/,
      z = 1,
      D = 1,
      E = 0,
      w = 1,
      O = [],
      S = [],
      A = 0,
      R = null,
      Y = 0,
      V = '';
  B.use = T;
  B.set = U;
  void 0 !== W && U(W);
  return B;
}

/* harmony default export */ __webpack_exports__["a"] = (stylis_min);


/***/ }),
/* 30 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var unitlessKeys = {
  animationIterationCount: 1,
  borderImageOutset: 1,
  borderImageSlice: 1,
  borderImageWidth: 1,
  boxFlex: 1,
  boxFlexGroup: 1,
  boxOrdinalGroup: 1,
  columnCount: 1,
  columns: 1,
  flex: 1,
  flexGrow: 1,
  flexPositive: 1,
  flexShrink: 1,
  flexNegative: 1,
  flexOrder: 1,
  gridRow: 1,
  gridRowEnd: 1,
  gridRowSpan: 1,
  gridRowStart: 1,
  gridColumn: 1,
  gridColumnEnd: 1,
  gridColumnSpan: 1,
  gridColumnStart: 1,
  msGridRow: 1,
  msGridRowSpan: 1,
  msGridColumn: 1,
  msGridColumnSpan: 1,
  fontWeight: 1,
  lineHeight: 1,
  opacity: 1,
  order: 1,
  orphans: 1,
  tabSize: 1,
  widows: 1,
  zIndex: 1,
  zoom: 1,
  WebkitLineClamp: 1,
  // SVG-related properties
  fillOpacity: 1,
  floodOpacity: 1,
  stopOpacity: 1,
  strokeDasharray: 1,
  strokeDashoffset: 1,
  strokeMiterlimit: 1,
  strokeOpacity: 1,
  strokeWidth: 1
};

/* harmony default export */ __webpack_exports__["a"] = (unitlessKeys);


/***/ }),
/* 31 */,
/* 32 */,
/* 33 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.useExecFind = exports.useExecCommand = exports.getInitialInputValue = exports.useErrorMessage = exports.useInfoMessage = exports.useFindMode = exports.useCommandMode = exports.useHide = void 0;
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const actions = tslib_1.__importStar(__webpack_require__(55));
const contexts_1 = __webpack_require__(56);
const messages = tslib_1.__importStar(__webpack_require__(4));
const useHide = () => {
    const dispatch = react_1.default.useContext(contexts_1.AppDispatchContext);
    const hide = react_1.default.useCallback(() => {
        window.top.postMessage(JSON.stringify({
            type: messages.CONSOLE_UNFOCUS,
        }), "*");
        dispatch(actions.hide());
    }, [dispatch]);
    return hide;
};
exports.useHide = useHide;
const useCommandMode = () => {
    const state = react_1.default.useContext(contexts_1.AppStateContext);
    const dispatch = react_1.default.useContext(contexts_1.AppDispatchContext);
    const show = react_1.default.useCallback((initialInputValue) => {
        dispatch(actions.showCommand(initialInputValue));
    }, [dispatch]);
    return {
        visible: state.mode === "command",
        initialInputValue: state.consoleText,
        show,
    };
};
exports.useCommandMode = useCommandMode;
const useFindMode = () => {
    const state = react_1.default.useContext(contexts_1.AppStateContext);
    const dispatch = react_1.default.useContext(contexts_1.AppDispatchContext);
    const show = react_1.default.useCallback(() => {
        dispatch(actions.showFind());
    }, [dispatch]);
    return {
        visible: state.mode === "find",
        show,
    };
};
exports.useFindMode = useFindMode;
const useInfoMessage = () => {
    const state = react_1.default.useContext(contexts_1.AppStateContext);
    const dispatch = react_1.default.useContext(contexts_1.AppDispatchContext);
    const show = react_1.default.useCallback((message) => {
        dispatch(actions.showInfo(message));
    }, [dispatch]);
    return {
        visible: state.mode === "info",
        message: state.mode === "info" ? state.messageText : "",
        show,
    };
};
exports.useInfoMessage = useInfoMessage;
const useErrorMessage = () => {
    const state = react_1.default.useContext(contexts_1.AppStateContext);
    const dispatch = react_1.default.useContext(contexts_1.AppDispatchContext);
    const show = react_1.default.useCallback((message) => {
        dispatch(actions.showError(message));
    }, [dispatch]);
    return {
        visible: state.mode === "error",
        message: state.mode === "error" ? state.messageText : "",
        show,
    };
};
exports.useErrorMessage = useErrorMessage;
const getInitialInputValue = () => {
    const state = react_1.default.useContext(contexts_1.AppStateContext);
    return state.consoleText;
};
exports.getInitialInputValue = getInitialInputValue;
const useExecCommand = () => {
    const execCommand = react_1.default.useCallback((text) => {
        browser.runtime.sendMessage({
            type: messages.CONSOLE_ENTER_COMMAND,
            text,
        });
    }, []);
    return execCommand;
};
exports.useExecCommand = useExecCommand;
const useExecFind = () => {
    const execFind = react_1.default.useCallback((text) => {
        browser.runtime.sendMessage({
            type: messages.CONSOLE_ENTER_FIND,
            keyword: text,
        });
    }, []);
    return execFind;
};
exports.useExecFind = useExecFind;


/***/ }),
/* 34 */,
/* 35 */,
/* 36 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/** @license React v17.0.2
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var l=__webpack_require__(25),n=60103,p=60106;exports.Fragment=60107;exports.StrictMode=60108;exports.Profiler=60114;var q=60109,r=60110,t=60112;exports.Suspense=60113;var u=60115,v=60116;
if("function"===typeof Symbol&&Symbol.for){var w=Symbol.for;n=w("react.element");p=w("react.portal");exports.Fragment=w("react.fragment");exports.StrictMode=w("react.strict_mode");exports.Profiler=w("react.profiler");q=w("react.provider");r=w("react.context");t=w("react.forward_ref");exports.Suspense=w("react.suspense");u=w("react.memo");v=w("react.lazy")}var x="function"===typeof Symbol&&Symbol.iterator;
function y(a){if(null===a||"object"!==typeof a)return null;a=x&&a[x]||a["@@iterator"];return"function"===typeof a?a:null}function z(a){for(var b="https://reactjs.org/docs/error-decoder.html?invariant="+a,c=1;c<arguments.length;c++)b+="&args[]="+encodeURIComponent(arguments[c]);return"Minified React error #"+a+"; visit "+b+" for the full message or use the non-minified dev environment for full errors and additional helpful warnings."}
var A={isMounted:function(){return!1},enqueueForceUpdate:function(){},enqueueReplaceState:function(){},enqueueSetState:function(){}},B={};function C(a,b,c){this.props=a;this.context=b;this.refs=B;this.updater=c||A}C.prototype.isReactComponent={};C.prototype.setState=function(a,b){if("object"!==typeof a&&"function"!==typeof a&&null!=a)throw Error(z(85));this.updater.enqueueSetState(this,a,b,"setState")};C.prototype.forceUpdate=function(a){this.updater.enqueueForceUpdate(this,a,"forceUpdate")};
function D(){}D.prototype=C.prototype;function E(a,b,c){this.props=a;this.context=b;this.refs=B;this.updater=c||A}var F=E.prototype=new D;F.constructor=E;l(F,C.prototype);F.isPureReactComponent=!0;var G={current:null},H=Object.prototype.hasOwnProperty,I={key:!0,ref:!0,__self:!0,__source:!0};
function J(a,b,c){var e,d={},k=null,h=null;if(null!=b)for(e in void 0!==b.ref&&(h=b.ref),void 0!==b.key&&(k=""+b.key),b)H.call(b,e)&&!I.hasOwnProperty(e)&&(d[e]=b[e]);var g=arguments.length-2;if(1===g)d.children=c;else if(1<g){for(var f=Array(g),m=0;m<g;m++)f[m]=arguments[m+2];d.children=f}if(a&&a.defaultProps)for(e in g=a.defaultProps,g)void 0===d[e]&&(d[e]=g[e]);return{$$typeof:n,type:a,key:k,ref:h,props:d,_owner:G.current}}
function K(a,b){return{$$typeof:n,type:a.type,key:b,ref:a.ref,props:a.props,_owner:a._owner}}function L(a){return"object"===typeof a&&null!==a&&a.$$typeof===n}function escape(a){var b={"=":"=0",":":"=2"};return"$"+a.replace(/[=:]/g,function(a){return b[a]})}var M=/\/+/g;function N(a,b){return"object"===typeof a&&null!==a&&null!=a.key?escape(""+a.key):b.toString(36)}
function O(a,b,c,e,d){var k=typeof a;if("undefined"===k||"boolean"===k)a=null;var h=!1;if(null===a)h=!0;else switch(k){case "string":case "number":h=!0;break;case "object":switch(a.$$typeof){case n:case p:h=!0}}if(h)return h=a,d=d(h),a=""===e?"."+N(h,0):e,Array.isArray(d)?(c="",null!=a&&(c=a.replace(M,"$&/")+"/"),O(d,b,c,"",function(a){return a})):null!=d&&(L(d)&&(d=K(d,c+(!d.key||h&&h.key===d.key?"":(""+d.key).replace(M,"$&/")+"/")+a)),b.push(d)),1;h=0;e=""===e?".":e+":";if(Array.isArray(a))for(var g=
0;g<a.length;g++){k=a[g];var f=e+N(k,g);h+=O(k,b,c,f,d)}else if(f=y(a),"function"===typeof f)for(a=f.call(a),g=0;!(k=a.next()).done;)k=k.value,f=e+N(k,g++),h+=O(k,b,c,f,d);else if("object"===k)throw b=""+a,Error(z(31,"[object Object]"===b?"object with keys {"+Object.keys(a).join(", ")+"}":b));return h}function P(a,b,c){if(null==a)return a;var e=[],d=0;O(a,e,"","",function(a){return b.call(c,a,d++)});return e}
function Q(a){if(-1===a._status){var b=a._result;b=b();a._status=0;a._result=b;b.then(function(b){0===a._status&&(b=b.default,a._status=1,a._result=b)},function(b){0===a._status&&(a._status=2,a._result=b)})}if(1===a._status)return a._result;throw a._result;}var R={current:null};function S(){var a=R.current;if(null===a)throw Error(z(321));return a}var T={ReactCurrentDispatcher:R,ReactCurrentBatchConfig:{transition:0},ReactCurrentOwner:G,IsSomeRendererActing:{current:!1},assign:l};
exports.Children={map:P,forEach:function(a,b,c){P(a,function(){b.apply(this,arguments)},c)},count:function(a){var b=0;P(a,function(){b++});return b},toArray:function(a){return P(a,function(a){return a})||[]},only:function(a){if(!L(a))throw Error(z(143));return a}};exports.Component=C;exports.PureComponent=E;exports.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED=T;
exports.cloneElement=function(a,b,c){if(null===a||void 0===a)throw Error(z(267,a));var e=l({},a.props),d=a.key,k=a.ref,h=a._owner;if(null!=b){void 0!==b.ref&&(k=b.ref,h=G.current);void 0!==b.key&&(d=""+b.key);if(a.type&&a.type.defaultProps)var g=a.type.defaultProps;for(f in b)H.call(b,f)&&!I.hasOwnProperty(f)&&(e[f]=void 0===b[f]&&void 0!==g?g[f]:b[f])}var f=arguments.length-2;if(1===f)e.children=c;else if(1<f){g=Array(f);for(var m=0;m<f;m++)g[m]=arguments[m+2];e.children=g}return{$$typeof:n,type:a.type,
key:d,ref:k,props:e,_owner:h}};exports.createContext=function(a,b){void 0===b&&(b=null);a={$$typeof:r,_calculateChangedBits:b,_currentValue:a,_currentValue2:a,_threadCount:0,Provider:null,Consumer:null};a.Provider={$$typeof:q,_context:a};return a.Consumer=a};exports.createElement=J;exports.createFactory=function(a){var b=J.bind(null,a);b.type=a;return b};exports.createRef=function(){return{current:null}};exports.forwardRef=function(a){return{$$typeof:t,render:a}};exports.isValidElement=L;
exports.lazy=function(a){return{$$typeof:v,_payload:{_status:-1,_result:a},_init:Q}};exports.memo=function(a,b){return{$$typeof:u,type:a,compare:void 0===b?null:b}};exports.useCallback=function(a,b){return S().useCallback(a,b)};exports.useContext=function(a,b){return S().useContext(a,b)};exports.useDebugValue=function(){};exports.useEffect=function(a,b){return S().useEffect(a,b)};exports.useImperativeHandle=function(a,b,c){return S().useImperativeHandle(a,b,c)};
exports.useLayoutEffect=function(a,b){return S().useLayoutEffect(a,b)};exports.useMemo=function(a,b){return S().useMemo(a,b)};exports.useReducer=function(a,b,c){return S().useReducer(a,b,c)};exports.useRef=function(a){return S().useRef(a)};exports.useState=function(a){return S().useState(a)};exports.version="17.0.2";


/***/ }),
/* 37 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/** @license React v17.0.2
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
/*
 Modernizr 3.0.0pre (Custom Build) | MIT
*/
var aa=__webpack_require__(1),m=__webpack_require__(25),r=__webpack_require__(38);function y(a){for(var b="https://reactjs.org/docs/error-decoder.html?invariant="+a,c=1;c<arguments.length;c++)b+="&args[]="+encodeURIComponent(arguments[c]);return"Minified React error #"+a+"; visit "+b+" for the full message or use the non-minified dev environment for full errors and additional helpful warnings."}if(!aa)throw Error(y(227));var ba=new Set,ca={};function da(a,b){ea(a,b);ea(a+"Capture",b)}
function ea(a,b){ca[a]=b;for(a=0;a<b.length;a++)ba.add(b[a])}
var fa=!("undefined"===typeof window||"undefined"===typeof window.document||"undefined"===typeof window.document.createElement),ha=/^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/,ia=Object.prototype.hasOwnProperty,
ja={},ka={};function la(a){if(ia.call(ka,a))return!0;if(ia.call(ja,a))return!1;if(ha.test(a))return ka[a]=!0;ja[a]=!0;return!1}function ma(a,b,c,d){if(null!==c&&0===c.type)return!1;switch(typeof b){case "function":case "symbol":return!0;case "boolean":if(d)return!1;if(null!==c)return!c.acceptsBooleans;a=a.toLowerCase().slice(0,5);return"data-"!==a&&"aria-"!==a;default:return!1}}
function na(a,b,c,d){if(null===b||"undefined"===typeof b||ma(a,b,c,d))return!0;if(d)return!1;if(null!==c)switch(c.type){case 3:return!b;case 4:return!1===b;case 5:return isNaN(b);case 6:return isNaN(b)||1>b}return!1}function B(a,b,c,d,e,f,g){this.acceptsBooleans=2===b||3===b||4===b;this.attributeName=d;this.attributeNamespace=e;this.mustUseProperty=c;this.propertyName=a;this.type=b;this.sanitizeURL=f;this.removeEmptyString=g}var D={};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function(a){D[a]=new B(a,0,!1,a,null,!1,!1)});[["acceptCharset","accept-charset"],["className","class"],["htmlFor","for"],["httpEquiv","http-equiv"]].forEach(function(a){var b=a[0];D[b]=new B(b,1,!1,a[1],null,!1,!1)});["contentEditable","draggable","spellCheck","value"].forEach(function(a){D[a]=new B(a,2,!1,a.toLowerCase(),null,!1,!1)});
["autoReverse","externalResourcesRequired","focusable","preserveAlpha"].forEach(function(a){D[a]=new B(a,2,!1,a,null,!1,!1)});"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function(a){D[a]=new B(a,3,!1,a.toLowerCase(),null,!1,!1)});
["checked","multiple","muted","selected"].forEach(function(a){D[a]=new B(a,3,!0,a,null,!1,!1)});["capture","download"].forEach(function(a){D[a]=new B(a,4,!1,a,null,!1,!1)});["cols","rows","size","span"].forEach(function(a){D[a]=new B(a,6,!1,a,null,!1,!1)});["rowSpan","start"].forEach(function(a){D[a]=new B(a,5,!1,a.toLowerCase(),null,!1,!1)});var oa=/[\-:]([a-z])/g;function pa(a){return a[1].toUpperCase()}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function(a){var b=a.replace(oa,
pa);D[b]=new B(b,1,!1,a,null,!1,!1)});"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function(a){var b=a.replace(oa,pa);D[b]=new B(b,1,!1,a,"http://www.w3.org/1999/xlink",!1,!1)});["xml:base","xml:lang","xml:space"].forEach(function(a){var b=a.replace(oa,pa);D[b]=new B(b,1,!1,a,"http://www.w3.org/XML/1998/namespace",!1,!1)});["tabIndex","crossOrigin"].forEach(function(a){D[a]=new B(a,1,!1,a.toLowerCase(),null,!1,!1)});
D.xlinkHref=new B("xlinkHref",1,!1,"xlink:href","http://www.w3.org/1999/xlink",!0,!1);["src","href","action","formAction"].forEach(function(a){D[a]=new B(a,1,!1,a.toLowerCase(),null,!0,!0)});
function qa(a,b,c,d){var e=D.hasOwnProperty(b)?D[b]:null;var f=null!==e?0===e.type:d?!1:!(2<b.length)||"o"!==b[0]&&"O"!==b[0]||"n"!==b[1]&&"N"!==b[1]?!1:!0;f||(na(b,c,e,d)&&(c=null),d||null===e?la(b)&&(null===c?a.removeAttribute(b):a.setAttribute(b,""+c)):e.mustUseProperty?a[e.propertyName]=null===c?3===e.type?!1:"":c:(b=e.attributeName,d=e.attributeNamespace,null===c?a.removeAttribute(b):(e=e.type,c=3===e||4===e&&!0===c?"":""+c,d?a.setAttributeNS(d,b,c):a.setAttribute(b,c))))}
var ra=aa.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED,sa=60103,ta=60106,ua=60107,wa=60108,xa=60114,ya=60109,za=60110,Aa=60112,Ba=60113,Ca=60120,Da=60115,Ea=60116,Fa=60121,Ga=60128,Ha=60129,Ia=60130,Ja=60131;
if("function"===typeof Symbol&&Symbol.for){var E=Symbol.for;sa=E("react.element");ta=E("react.portal");ua=E("react.fragment");wa=E("react.strict_mode");xa=E("react.profiler");ya=E("react.provider");za=E("react.context");Aa=E("react.forward_ref");Ba=E("react.suspense");Ca=E("react.suspense_list");Da=E("react.memo");Ea=E("react.lazy");Fa=E("react.block");E("react.scope");Ga=E("react.opaque.id");Ha=E("react.debug_trace_mode");Ia=E("react.offscreen");Ja=E("react.legacy_hidden")}
var Ka="function"===typeof Symbol&&Symbol.iterator;function La(a){if(null===a||"object"!==typeof a)return null;a=Ka&&a[Ka]||a["@@iterator"];return"function"===typeof a?a:null}var Ma;function Na(a){if(void 0===Ma)try{throw Error();}catch(c){var b=c.stack.trim().match(/\n( *(at )?)/);Ma=b&&b[1]||""}return"\n"+Ma+a}var Oa=!1;
function Pa(a,b){if(!a||Oa)return"";Oa=!0;var c=Error.prepareStackTrace;Error.prepareStackTrace=void 0;try{if(b)if(b=function(){throw Error();},Object.defineProperty(b.prototype,"props",{set:function(){throw Error();}}),"object"===typeof Reflect&&Reflect.construct){try{Reflect.construct(b,[])}catch(k){var d=k}Reflect.construct(a,[],b)}else{try{b.call()}catch(k){d=k}a.call(b.prototype)}else{try{throw Error();}catch(k){d=k}a()}}catch(k){if(k&&d&&"string"===typeof k.stack){for(var e=k.stack.split("\n"),
f=d.stack.split("\n"),g=e.length-1,h=f.length-1;1<=g&&0<=h&&e[g]!==f[h];)h--;for(;1<=g&&0<=h;g--,h--)if(e[g]!==f[h]){if(1!==g||1!==h){do if(g--,h--,0>h||e[g]!==f[h])return"\n"+e[g].replace(" at new "," at ");while(1<=g&&0<=h)}break}}}finally{Oa=!1,Error.prepareStackTrace=c}return(a=a?a.displayName||a.name:"")?Na(a):""}
function Qa(a){switch(a.tag){case 5:return Na(a.type);case 16:return Na("Lazy");case 13:return Na("Suspense");case 19:return Na("SuspenseList");case 0:case 2:case 15:return a=Pa(a.type,!1),a;case 11:return a=Pa(a.type.render,!1),a;case 22:return a=Pa(a.type._render,!1),a;case 1:return a=Pa(a.type,!0),a;default:return""}}
function Ra(a){if(null==a)return null;if("function"===typeof a)return a.displayName||a.name||null;if("string"===typeof a)return a;switch(a){case ua:return"Fragment";case ta:return"Portal";case xa:return"Profiler";case wa:return"StrictMode";case Ba:return"Suspense";case Ca:return"SuspenseList"}if("object"===typeof a)switch(a.$$typeof){case za:return(a.displayName||"Context")+".Consumer";case ya:return(a._context.displayName||"Context")+".Provider";case Aa:var b=a.render;b=b.displayName||b.name||"";
return a.displayName||(""!==b?"ForwardRef("+b+")":"ForwardRef");case Da:return Ra(a.type);case Fa:return Ra(a._render);case Ea:b=a._payload;a=a._init;try{return Ra(a(b))}catch(c){}}return null}function Sa(a){switch(typeof a){case "boolean":case "number":case "object":case "string":case "undefined":return a;default:return""}}function Ta(a){var b=a.type;return(a=a.nodeName)&&"input"===a.toLowerCase()&&("checkbox"===b||"radio"===b)}
function Ua(a){var b=Ta(a)?"checked":"value",c=Object.getOwnPropertyDescriptor(a.constructor.prototype,b),d=""+a[b];if(!a.hasOwnProperty(b)&&"undefined"!==typeof c&&"function"===typeof c.get&&"function"===typeof c.set){var e=c.get,f=c.set;Object.defineProperty(a,b,{configurable:!0,get:function(){return e.call(this)},set:function(a){d=""+a;f.call(this,a)}});Object.defineProperty(a,b,{enumerable:c.enumerable});return{getValue:function(){return d},setValue:function(a){d=""+a},stopTracking:function(){a._valueTracker=
null;delete a[b]}}}}function Va(a){a._valueTracker||(a._valueTracker=Ua(a))}function Wa(a){if(!a)return!1;var b=a._valueTracker;if(!b)return!0;var c=b.getValue();var d="";a&&(d=Ta(a)?a.checked?"true":"false":a.value);a=d;return a!==c?(b.setValue(a),!0):!1}function Xa(a){a=a||("undefined"!==typeof document?document:void 0);if("undefined"===typeof a)return null;try{return a.activeElement||a.body}catch(b){return a.body}}
function Ya(a,b){var c=b.checked;return m({},b,{defaultChecked:void 0,defaultValue:void 0,value:void 0,checked:null!=c?c:a._wrapperState.initialChecked})}function Za(a,b){var c=null==b.defaultValue?"":b.defaultValue,d=null!=b.checked?b.checked:b.defaultChecked;c=Sa(null!=b.value?b.value:c);a._wrapperState={initialChecked:d,initialValue:c,controlled:"checkbox"===b.type||"radio"===b.type?null!=b.checked:null!=b.value}}function $a(a,b){b=b.checked;null!=b&&qa(a,"checked",b,!1)}
function ab(a,b){$a(a,b);var c=Sa(b.value),d=b.type;if(null!=c)if("number"===d){if(0===c&&""===a.value||a.value!=c)a.value=""+c}else a.value!==""+c&&(a.value=""+c);else if("submit"===d||"reset"===d){a.removeAttribute("value");return}b.hasOwnProperty("value")?bb(a,b.type,c):b.hasOwnProperty("defaultValue")&&bb(a,b.type,Sa(b.defaultValue));null==b.checked&&null!=b.defaultChecked&&(a.defaultChecked=!!b.defaultChecked)}
function cb(a,b,c){if(b.hasOwnProperty("value")||b.hasOwnProperty("defaultValue")){var d=b.type;if(!("submit"!==d&&"reset"!==d||void 0!==b.value&&null!==b.value))return;b=""+a._wrapperState.initialValue;c||b===a.value||(a.value=b);a.defaultValue=b}c=a.name;""!==c&&(a.name="");a.defaultChecked=!!a._wrapperState.initialChecked;""!==c&&(a.name=c)}
function bb(a,b,c){if("number"!==b||Xa(a.ownerDocument)!==a)null==c?a.defaultValue=""+a._wrapperState.initialValue:a.defaultValue!==""+c&&(a.defaultValue=""+c)}function db(a){var b="";aa.Children.forEach(a,function(a){null!=a&&(b+=a)});return b}function eb(a,b){a=m({children:void 0},b);if(b=db(b.children))a.children=b;return a}
function fb(a,b,c,d){a=a.options;if(b){b={};for(var e=0;e<c.length;e++)b["$"+c[e]]=!0;for(c=0;c<a.length;c++)e=b.hasOwnProperty("$"+a[c].value),a[c].selected!==e&&(a[c].selected=e),e&&d&&(a[c].defaultSelected=!0)}else{c=""+Sa(c);b=null;for(e=0;e<a.length;e++){if(a[e].value===c){a[e].selected=!0;d&&(a[e].defaultSelected=!0);return}null!==b||a[e].disabled||(b=a[e])}null!==b&&(b.selected=!0)}}
function gb(a,b){if(null!=b.dangerouslySetInnerHTML)throw Error(y(91));return m({},b,{value:void 0,defaultValue:void 0,children:""+a._wrapperState.initialValue})}function hb(a,b){var c=b.value;if(null==c){c=b.children;b=b.defaultValue;if(null!=c){if(null!=b)throw Error(y(92));if(Array.isArray(c)){if(!(1>=c.length))throw Error(y(93));c=c[0]}b=c}null==b&&(b="");c=b}a._wrapperState={initialValue:Sa(c)}}
function ib(a,b){var c=Sa(b.value),d=Sa(b.defaultValue);null!=c&&(c=""+c,c!==a.value&&(a.value=c),null==b.defaultValue&&a.defaultValue!==c&&(a.defaultValue=c));null!=d&&(a.defaultValue=""+d)}function jb(a){var b=a.textContent;b===a._wrapperState.initialValue&&""!==b&&null!==b&&(a.value=b)}var kb={html:"http://www.w3.org/1999/xhtml",mathml:"http://www.w3.org/1998/Math/MathML",svg:"http://www.w3.org/2000/svg"};
function lb(a){switch(a){case "svg":return"http://www.w3.org/2000/svg";case "math":return"http://www.w3.org/1998/Math/MathML";default:return"http://www.w3.org/1999/xhtml"}}function mb(a,b){return null==a||"http://www.w3.org/1999/xhtml"===a?lb(b):"http://www.w3.org/2000/svg"===a&&"foreignObject"===b?"http://www.w3.org/1999/xhtml":a}
var nb,ob=function(a){return"undefined"!==typeof MSApp&&MSApp.execUnsafeLocalFunction?function(b,c,d,e){MSApp.execUnsafeLocalFunction(function(){return a(b,c,d,e)})}:a}(function(a,b){if(a.namespaceURI!==kb.svg||"innerHTML"in a)a.innerHTML=b;else{nb=nb||document.createElement("div");nb.innerHTML="<svg>"+b.valueOf().toString()+"</svg>";for(b=nb.firstChild;a.firstChild;)a.removeChild(a.firstChild);for(;b.firstChild;)a.appendChild(b.firstChild)}});
function pb(a,b){if(b){var c=a.firstChild;if(c&&c===a.lastChild&&3===c.nodeType){c.nodeValue=b;return}}a.textContent=b}
var qb={animationIterationCount:!0,borderImageOutset:!0,borderImageSlice:!0,borderImageWidth:!0,boxFlex:!0,boxFlexGroup:!0,boxOrdinalGroup:!0,columnCount:!0,columns:!0,flex:!0,flexGrow:!0,flexPositive:!0,flexShrink:!0,flexNegative:!0,flexOrder:!0,gridArea:!0,gridRow:!0,gridRowEnd:!0,gridRowSpan:!0,gridRowStart:!0,gridColumn:!0,gridColumnEnd:!0,gridColumnSpan:!0,gridColumnStart:!0,fontWeight:!0,lineClamp:!0,lineHeight:!0,opacity:!0,order:!0,orphans:!0,tabSize:!0,widows:!0,zIndex:!0,zoom:!0,fillOpacity:!0,
floodOpacity:!0,stopOpacity:!0,strokeDasharray:!0,strokeDashoffset:!0,strokeMiterlimit:!0,strokeOpacity:!0,strokeWidth:!0},rb=["Webkit","ms","Moz","O"];Object.keys(qb).forEach(function(a){rb.forEach(function(b){b=b+a.charAt(0).toUpperCase()+a.substring(1);qb[b]=qb[a]})});function sb(a,b,c){return null==b||"boolean"===typeof b||""===b?"":c||"number"!==typeof b||0===b||qb.hasOwnProperty(a)&&qb[a]?(""+b).trim():b+"px"}
function tb(a,b){a=a.style;for(var c in b)if(b.hasOwnProperty(c)){var d=0===c.indexOf("--"),e=sb(c,b[c],d);"float"===c&&(c="cssFloat");d?a.setProperty(c,e):a[c]=e}}var ub=m({menuitem:!0},{area:!0,base:!0,br:!0,col:!0,embed:!0,hr:!0,img:!0,input:!0,keygen:!0,link:!0,meta:!0,param:!0,source:!0,track:!0,wbr:!0});
function vb(a,b){if(b){if(ub[a]&&(null!=b.children||null!=b.dangerouslySetInnerHTML))throw Error(y(137,a));if(null!=b.dangerouslySetInnerHTML){if(null!=b.children)throw Error(y(60));if(!("object"===typeof b.dangerouslySetInnerHTML&&"__html"in b.dangerouslySetInnerHTML))throw Error(y(61));}if(null!=b.style&&"object"!==typeof b.style)throw Error(y(62));}}
function wb(a,b){if(-1===a.indexOf("-"))return"string"===typeof b.is;switch(a){case "annotation-xml":case "color-profile":case "font-face":case "font-face-src":case "font-face-uri":case "font-face-format":case "font-face-name":case "missing-glyph":return!1;default:return!0}}function xb(a){a=a.target||a.srcElement||window;a.correspondingUseElement&&(a=a.correspondingUseElement);return 3===a.nodeType?a.parentNode:a}var yb=null,zb=null,Ab=null;
function Bb(a){if(a=Cb(a)){if("function"!==typeof yb)throw Error(y(280));var b=a.stateNode;b&&(b=Db(b),yb(a.stateNode,a.type,b))}}function Eb(a){zb?Ab?Ab.push(a):Ab=[a]:zb=a}function Fb(){if(zb){var a=zb,b=Ab;Ab=zb=null;Bb(a);if(b)for(a=0;a<b.length;a++)Bb(b[a])}}function Gb(a,b){return a(b)}function Hb(a,b,c,d,e){return a(b,c,d,e)}function Ib(){}var Jb=Gb,Kb=!1,Lb=!1;function Mb(){if(null!==zb||null!==Ab)Ib(),Fb()}
function Nb(a,b,c){if(Lb)return a(b,c);Lb=!0;try{return Jb(a,b,c)}finally{Lb=!1,Mb()}}
function Ob(a,b){var c=a.stateNode;if(null===c)return null;var d=Db(c);if(null===d)return null;c=d[b];a:switch(b){case "onClick":case "onClickCapture":case "onDoubleClick":case "onDoubleClickCapture":case "onMouseDown":case "onMouseDownCapture":case "onMouseMove":case "onMouseMoveCapture":case "onMouseUp":case "onMouseUpCapture":case "onMouseEnter":(d=!d.disabled)||(a=a.type,d=!("button"===a||"input"===a||"select"===a||"textarea"===a));a=!d;break a;default:a=!1}if(a)return null;if(c&&"function"!==
typeof c)throw Error(y(231,b,typeof c));return c}var Pb=!1;if(fa)try{var Qb={};Object.defineProperty(Qb,"passive",{get:function(){Pb=!0}});window.addEventListener("test",Qb,Qb);window.removeEventListener("test",Qb,Qb)}catch(a){Pb=!1}function Rb(a,b,c,d,e,f,g,h,k){var l=Array.prototype.slice.call(arguments,3);try{b.apply(c,l)}catch(n){this.onError(n)}}var Sb=!1,Tb=null,Ub=!1,Vb=null,Wb={onError:function(a){Sb=!0;Tb=a}};function Xb(a,b,c,d,e,f,g,h,k){Sb=!1;Tb=null;Rb.apply(Wb,arguments)}
function Yb(a,b,c,d,e,f,g,h,k){Xb.apply(this,arguments);if(Sb){if(Sb){var l=Tb;Sb=!1;Tb=null}else throw Error(y(198));Ub||(Ub=!0,Vb=l)}}function Zb(a){var b=a,c=a;if(a.alternate)for(;b.return;)b=b.return;else{a=b;do b=a,0!==(b.flags&1026)&&(c=b.return),a=b.return;while(a)}return 3===b.tag?c:null}function $b(a){if(13===a.tag){var b=a.memoizedState;null===b&&(a=a.alternate,null!==a&&(b=a.memoizedState));if(null!==b)return b.dehydrated}return null}function ac(a){if(Zb(a)!==a)throw Error(y(188));}
function bc(a){var b=a.alternate;if(!b){b=Zb(a);if(null===b)throw Error(y(188));return b!==a?null:a}for(var c=a,d=b;;){var e=c.return;if(null===e)break;var f=e.alternate;if(null===f){d=e.return;if(null!==d){c=d;continue}break}if(e.child===f.child){for(f=e.child;f;){if(f===c)return ac(e),a;if(f===d)return ac(e),b;f=f.sibling}throw Error(y(188));}if(c.return!==d.return)c=e,d=f;else{for(var g=!1,h=e.child;h;){if(h===c){g=!0;c=e;d=f;break}if(h===d){g=!0;d=e;c=f;break}h=h.sibling}if(!g){for(h=f.child;h;){if(h===
c){g=!0;c=f;d=e;break}if(h===d){g=!0;d=f;c=e;break}h=h.sibling}if(!g)throw Error(y(189));}}if(c.alternate!==d)throw Error(y(190));}if(3!==c.tag)throw Error(y(188));return c.stateNode.current===c?a:b}function cc(a){a=bc(a);if(!a)return null;for(var b=a;;){if(5===b.tag||6===b.tag)return b;if(b.child)b.child.return=b,b=b.child;else{if(b===a)break;for(;!b.sibling;){if(!b.return||b.return===a)return null;b=b.return}b.sibling.return=b.return;b=b.sibling}}return null}
function dc(a,b){for(var c=a.alternate;null!==b;){if(b===a||b===c)return!0;b=b.return}return!1}var ec,fc,gc,hc,ic=!1,jc=[],kc=null,lc=null,mc=null,nc=new Map,oc=new Map,pc=[],qc="mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");
function rc(a,b,c,d,e){return{blockedOn:a,domEventName:b,eventSystemFlags:c|16,nativeEvent:e,targetContainers:[d]}}function sc(a,b){switch(a){case "focusin":case "focusout":kc=null;break;case "dragenter":case "dragleave":lc=null;break;case "mouseover":case "mouseout":mc=null;break;case "pointerover":case "pointerout":nc.delete(b.pointerId);break;case "gotpointercapture":case "lostpointercapture":oc.delete(b.pointerId)}}
function tc(a,b,c,d,e,f){if(null===a||a.nativeEvent!==f)return a=rc(b,c,d,e,f),null!==b&&(b=Cb(b),null!==b&&fc(b)),a;a.eventSystemFlags|=d;b=a.targetContainers;null!==e&&-1===b.indexOf(e)&&b.push(e);return a}
function uc(a,b,c,d,e){switch(b){case "focusin":return kc=tc(kc,a,b,c,d,e),!0;case "dragenter":return lc=tc(lc,a,b,c,d,e),!0;case "mouseover":return mc=tc(mc,a,b,c,d,e),!0;case "pointerover":var f=e.pointerId;nc.set(f,tc(nc.get(f)||null,a,b,c,d,e));return!0;case "gotpointercapture":return f=e.pointerId,oc.set(f,tc(oc.get(f)||null,a,b,c,d,e)),!0}return!1}
function vc(a){var b=wc(a.target);if(null!==b){var c=Zb(b);if(null!==c)if(b=c.tag,13===b){if(b=$b(c),null!==b){a.blockedOn=b;hc(a.lanePriority,function(){r.unstable_runWithPriority(a.priority,function(){gc(c)})});return}}else if(3===b&&c.stateNode.hydrate){a.blockedOn=3===c.tag?c.stateNode.containerInfo:null;return}}a.blockedOn=null}
function xc(a){if(null!==a.blockedOn)return!1;for(var b=a.targetContainers;0<b.length;){var c=yc(a.domEventName,a.eventSystemFlags,b[0],a.nativeEvent);if(null!==c)return b=Cb(c),null!==b&&fc(b),a.blockedOn=c,!1;b.shift()}return!0}function zc(a,b,c){xc(a)&&c.delete(b)}
function Ac(){for(ic=!1;0<jc.length;){var a=jc[0];if(null!==a.blockedOn){a=Cb(a.blockedOn);null!==a&&ec(a);break}for(var b=a.targetContainers;0<b.length;){var c=yc(a.domEventName,a.eventSystemFlags,b[0],a.nativeEvent);if(null!==c){a.blockedOn=c;break}b.shift()}null===a.blockedOn&&jc.shift()}null!==kc&&xc(kc)&&(kc=null);null!==lc&&xc(lc)&&(lc=null);null!==mc&&xc(mc)&&(mc=null);nc.forEach(zc);oc.forEach(zc)}
function Bc(a,b){a.blockedOn===b&&(a.blockedOn=null,ic||(ic=!0,r.unstable_scheduleCallback(r.unstable_NormalPriority,Ac)))}
function Cc(a){function b(b){return Bc(b,a)}if(0<jc.length){Bc(jc[0],a);for(var c=1;c<jc.length;c++){var d=jc[c];d.blockedOn===a&&(d.blockedOn=null)}}null!==kc&&Bc(kc,a);null!==lc&&Bc(lc,a);null!==mc&&Bc(mc,a);nc.forEach(b);oc.forEach(b);for(c=0;c<pc.length;c++)d=pc[c],d.blockedOn===a&&(d.blockedOn=null);for(;0<pc.length&&(c=pc[0],null===c.blockedOn);)vc(c),null===c.blockedOn&&pc.shift()}
function Dc(a,b){var c={};c[a.toLowerCase()]=b.toLowerCase();c["Webkit"+a]="webkit"+b;c["Moz"+a]="moz"+b;return c}var Ec={animationend:Dc("Animation","AnimationEnd"),animationiteration:Dc("Animation","AnimationIteration"),animationstart:Dc("Animation","AnimationStart"),transitionend:Dc("Transition","TransitionEnd")},Fc={},Gc={};
fa&&(Gc=document.createElement("div").style,"AnimationEvent"in window||(delete Ec.animationend.animation,delete Ec.animationiteration.animation,delete Ec.animationstart.animation),"TransitionEvent"in window||delete Ec.transitionend.transition);function Hc(a){if(Fc[a])return Fc[a];if(!Ec[a])return a;var b=Ec[a],c;for(c in b)if(b.hasOwnProperty(c)&&c in Gc)return Fc[a]=b[c];return a}
var Ic=Hc("animationend"),Jc=Hc("animationiteration"),Kc=Hc("animationstart"),Lc=Hc("transitionend"),Mc=new Map,Nc=new Map,Oc=["abort","abort",Ic,"animationEnd",Jc,"animationIteration",Kc,"animationStart","canplay","canPlay","canplaythrough","canPlayThrough","durationchange","durationChange","emptied","emptied","encrypted","encrypted","ended","ended","error","error","gotpointercapture","gotPointerCapture","load","load","loadeddata","loadedData","loadedmetadata","loadedMetadata","loadstart","loadStart",
"lostpointercapture","lostPointerCapture","playing","playing","progress","progress","seeking","seeking","stalled","stalled","suspend","suspend","timeupdate","timeUpdate",Lc,"transitionEnd","waiting","waiting"];function Pc(a,b){for(var c=0;c<a.length;c+=2){var d=a[c],e=a[c+1];e="on"+(e[0].toUpperCase()+e.slice(1));Nc.set(d,b);Mc.set(d,e);da(e,[d])}}var Qc=r.unstable_now;Qc();var F=8;
function Rc(a){if(0!==(1&a))return F=15,1;if(0!==(2&a))return F=14,2;if(0!==(4&a))return F=13,4;var b=24&a;if(0!==b)return F=12,b;if(0!==(a&32))return F=11,32;b=192&a;if(0!==b)return F=10,b;if(0!==(a&256))return F=9,256;b=3584&a;if(0!==b)return F=8,b;if(0!==(a&4096))return F=7,4096;b=4186112&a;if(0!==b)return F=6,b;b=62914560&a;if(0!==b)return F=5,b;if(a&67108864)return F=4,67108864;if(0!==(a&134217728))return F=3,134217728;b=805306368&a;if(0!==b)return F=2,b;if(0!==(1073741824&a))return F=1,1073741824;
F=8;return a}function Sc(a){switch(a){case 99:return 15;case 98:return 10;case 97:case 96:return 8;case 95:return 2;default:return 0}}function Tc(a){switch(a){case 15:case 14:return 99;case 13:case 12:case 11:case 10:return 98;case 9:case 8:case 7:case 6:case 4:case 5:return 97;case 3:case 2:case 1:return 95;case 0:return 90;default:throw Error(y(358,a));}}
function Uc(a,b){var c=a.pendingLanes;if(0===c)return F=0;var d=0,e=0,f=a.expiredLanes,g=a.suspendedLanes,h=a.pingedLanes;if(0!==f)d=f,e=F=15;else if(f=c&134217727,0!==f){var k=f&~g;0!==k?(d=Rc(k),e=F):(h&=f,0!==h&&(d=Rc(h),e=F))}else f=c&~g,0!==f?(d=Rc(f),e=F):0!==h&&(d=Rc(h),e=F);if(0===d)return 0;d=31-Vc(d);d=c&((0>d?0:1<<d)<<1)-1;if(0!==b&&b!==d&&0===(b&g)){Rc(b);if(e<=F)return b;F=e}b=a.entangledLanes;if(0!==b)for(a=a.entanglements,b&=d;0<b;)c=31-Vc(b),e=1<<c,d|=a[c],b&=~e;return d}
function Wc(a){a=a.pendingLanes&-1073741825;return 0!==a?a:a&1073741824?1073741824:0}function Xc(a,b){switch(a){case 15:return 1;case 14:return 2;case 12:return a=Yc(24&~b),0===a?Xc(10,b):a;case 10:return a=Yc(192&~b),0===a?Xc(8,b):a;case 8:return a=Yc(3584&~b),0===a&&(a=Yc(4186112&~b),0===a&&(a=512)),a;case 2:return b=Yc(805306368&~b),0===b&&(b=268435456),b}throw Error(y(358,a));}function Yc(a){return a&-a}function Zc(a){for(var b=[],c=0;31>c;c++)b.push(a);return b}
function $c(a,b,c){a.pendingLanes|=b;var d=b-1;a.suspendedLanes&=d;a.pingedLanes&=d;a=a.eventTimes;b=31-Vc(b);a[b]=c}var Vc=Math.clz32?Math.clz32:ad,bd=Math.log,cd=Math.LN2;function ad(a){return 0===a?32:31-(bd(a)/cd|0)|0}var dd=r.unstable_UserBlockingPriority,ed=r.unstable_runWithPriority,fd=!0;function gd(a,b,c,d){Kb||Ib();var e=hd,f=Kb;Kb=!0;try{Hb(e,a,b,c,d)}finally{(Kb=f)||Mb()}}function id(a,b,c,d){ed(dd,hd.bind(null,a,b,c,d))}
function hd(a,b,c,d){if(fd){var e;if((e=0===(b&4))&&0<jc.length&&-1<qc.indexOf(a))a=rc(null,a,b,c,d),jc.push(a);else{var f=yc(a,b,c,d);if(null===f)e&&sc(a,d);else{if(e){if(-1<qc.indexOf(a)){a=rc(f,a,b,c,d);jc.push(a);return}if(uc(f,a,b,c,d))return;sc(a,d)}jd(a,b,d,null,c)}}}}
function yc(a,b,c,d){var e=xb(d);e=wc(e);if(null!==e){var f=Zb(e);if(null===f)e=null;else{var g=f.tag;if(13===g){e=$b(f);if(null!==e)return e;e=null}else if(3===g){if(f.stateNode.hydrate)return 3===f.tag?f.stateNode.containerInfo:null;e=null}else f!==e&&(e=null)}}jd(a,b,d,e,c);return null}var kd=null,ld=null,md=null;
function nd(){if(md)return md;var a,b=ld,c=b.length,d,e="value"in kd?kd.value:kd.textContent,f=e.length;for(a=0;a<c&&b[a]===e[a];a++);var g=c-a;for(d=1;d<=g&&b[c-d]===e[f-d];d++);return md=e.slice(a,1<d?1-d:void 0)}function od(a){var b=a.keyCode;"charCode"in a?(a=a.charCode,0===a&&13===b&&(a=13)):a=b;10===a&&(a=13);return 32<=a||13===a?a:0}function pd(){return!0}function qd(){return!1}
function rd(a){function b(b,d,e,f,g){this._reactName=b;this._targetInst=e;this.type=d;this.nativeEvent=f;this.target=g;this.currentTarget=null;for(var c in a)a.hasOwnProperty(c)&&(b=a[c],this[c]=b?b(f):f[c]);this.isDefaultPrevented=(null!=f.defaultPrevented?f.defaultPrevented:!1===f.returnValue)?pd:qd;this.isPropagationStopped=qd;return this}m(b.prototype,{preventDefault:function(){this.defaultPrevented=!0;var a=this.nativeEvent;a&&(a.preventDefault?a.preventDefault():"unknown"!==typeof a.returnValue&&
(a.returnValue=!1),this.isDefaultPrevented=pd)},stopPropagation:function(){var a=this.nativeEvent;a&&(a.stopPropagation?a.stopPropagation():"unknown"!==typeof a.cancelBubble&&(a.cancelBubble=!0),this.isPropagationStopped=pd)},persist:function(){},isPersistent:pd});return b}
var sd={eventPhase:0,bubbles:0,cancelable:0,timeStamp:function(a){return a.timeStamp||Date.now()},defaultPrevented:0,isTrusted:0},td=rd(sd),ud=m({},sd,{view:0,detail:0}),vd=rd(ud),wd,xd,yd,Ad=m({},ud,{screenX:0,screenY:0,clientX:0,clientY:0,pageX:0,pageY:0,ctrlKey:0,shiftKey:0,altKey:0,metaKey:0,getModifierState:zd,button:0,buttons:0,relatedTarget:function(a){return void 0===a.relatedTarget?a.fromElement===a.srcElement?a.toElement:a.fromElement:a.relatedTarget},movementX:function(a){if("movementX"in
a)return a.movementX;a!==yd&&(yd&&"mousemove"===a.type?(wd=a.screenX-yd.screenX,xd=a.screenY-yd.screenY):xd=wd=0,yd=a);return wd},movementY:function(a){return"movementY"in a?a.movementY:xd}}),Bd=rd(Ad),Cd=m({},Ad,{dataTransfer:0}),Dd=rd(Cd),Ed=m({},ud,{relatedTarget:0}),Fd=rd(Ed),Gd=m({},sd,{animationName:0,elapsedTime:0,pseudoElement:0}),Hd=rd(Gd),Id=m({},sd,{clipboardData:function(a){return"clipboardData"in a?a.clipboardData:window.clipboardData}}),Jd=rd(Id),Kd=m({},sd,{data:0}),Ld=rd(Kd),Md={Esc:"Escape",
Spacebar:" ",Left:"ArrowLeft",Up:"ArrowUp",Right:"ArrowRight",Down:"ArrowDown",Del:"Delete",Win:"OS",Menu:"ContextMenu",Apps:"ContextMenu",Scroll:"ScrollLock",MozPrintableKey:"Unidentified"},Nd={8:"Backspace",9:"Tab",12:"Clear",13:"Enter",16:"Shift",17:"Control",18:"Alt",19:"Pause",20:"CapsLock",27:"Escape",32:" ",33:"PageUp",34:"PageDown",35:"End",36:"Home",37:"ArrowLeft",38:"ArrowUp",39:"ArrowRight",40:"ArrowDown",45:"Insert",46:"Delete",112:"F1",113:"F2",114:"F3",115:"F4",116:"F5",117:"F6",118:"F7",
119:"F8",120:"F9",121:"F10",122:"F11",123:"F12",144:"NumLock",145:"ScrollLock",224:"Meta"},Od={Alt:"altKey",Control:"ctrlKey",Meta:"metaKey",Shift:"shiftKey"};function Pd(a){var b=this.nativeEvent;return b.getModifierState?b.getModifierState(a):(a=Od[a])?!!b[a]:!1}function zd(){return Pd}
var Qd=m({},ud,{key:function(a){if(a.key){var b=Md[a.key]||a.key;if("Unidentified"!==b)return b}return"keypress"===a.type?(a=od(a),13===a?"Enter":String.fromCharCode(a)):"keydown"===a.type||"keyup"===a.type?Nd[a.keyCode]||"Unidentified":""},code:0,location:0,ctrlKey:0,shiftKey:0,altKey:0,metaKey:0,repeat:0,locale:0,getModifierState:zd,charCode:function(a){return"keypress"===a.type?od(a):0},keyCode:function(a){return"keydown"===a.type||"keyup"===a.type?a.keyCode:0},which:function(a){return"keypress"===
a.type?od(a):"keydown"===a.type||"keyup"===a.type?a.keyCode:0}}),Rd=rd(Qd),Sd=m({},Ad,{pointerId:0,width:0,height:0,pressure:0,tangentialPressure:0,tiltX:0,tiltY:0,twist:0,pointerType:0,isPrimary:0}),Td=rd(Sd),Ud=m({},ud,{touches:0,targetTouches:0,changedTouches:0,altKey:0,metaKey:0,ctrlKey:0,shiftKey:0,getModifierState:zd}),Vd=rd(Ud),Wd=m({},sd,{propertyName:0,elapsedTime:0,pseudoElement:0}),Xd=rd(Wd),Yd=m({},Ad,{deltaX:function(a){return"deltaX"in a?a.deltaX:"wheelDeltaX"in a?-a.wheelDeltaX:0},
deltaY:function(a){return"deltaY"in a?a.deltaY:"wheelDeltaY"in a?-a.wheelDeltaY:"wheelDelta"in a?-a.wheelDelta:0},deltaZ:0,deltaMode:0}),Zd=rd(Yd),$d=[9,13,27,32],ae=fa&&"CompositionEvent"in window,be=null;fa&&"documentMode"in document&&(be=document.documentMode);var ce=fa&&"TextEvent"in window&&!be,de=fa&&(!ae||be&&8<be&&11>=be),ee=String.fromCharCode(32),fe=!1;
function ge(a,b){switch(a){case "keyup":return-1!==$d.indexOf(b.keyCode);case "keydown":return 229!==b.keyCode;case "keypress":case "mousedown":case "focusout":return!0;default:return!1}}function he(a){a=a.detail;return"object"===typeof a&&"data"in a?a.data:null}var ie=!1;function je(a,b){switch(a){case "compositionend":return he(b);case "keypress":if(32!==b.which)return null;fe=!0;return ee;case "textInput":return a=b.data,a===ee&&fe?null:a;default:return null}}
function ke(a,b){if(ie)return"compositionend"===a||!ae&&ge(a,b)?(a=nd(),md=ld=kd=null,ie=!1,a):null;switch(a){case "paste":return null;case "keypress":if(!(b.ctrlKey||b.altKey||b.metaKey)||b.ctrlKey&&b.altKey){if(b.char&&1<b.char.length)return b.char;if(b.which)return String.fromCharCode(b.which)}return null;case "compositionend":return de&&"ko"!==b.locale?null:b.data;default:return null}}
var le={color:!0,date:!0,datetime:!0,"datetime-local":!0,email:!0,month:!0,number:!0,password:!0,range:!0,search:!0,tel:!0,text:!0,time:!0,url:!0,week:!0};function me(a){var b=a&&a.nodeName&&a.nodeName.toLowerCase();return"input"===b?!!le[a.type]:"textarea"===b?!0:!1}function ne(a,b,c,d){Eb(d);b=oe(b,"onChange");0<b.length&&(c=new td("onChange","change",null,c,d),a.push({event:c,listeners:b}))}var pe=null,qe=null;function re(a){se(a,0)}function te(a){var b=ue(a);if(Wa(b))return a}
function ve(a,b){if("change"===a)return b}var we=!1;if(fa){var xe;if(fa){var ye="oninput"in document;if(!ye){var ze=document.createElement("div");ze.setAttribute("oninput","return;");ye="function"===typeof ze.oninput}xe=ye}else xe=!1;we=xe&&(!document.documentMode||9<document.documentMode)}function Ae(){pe&&(pe.detachEvent("onpropertychange",Be),qe=pe=null)}function Be(a){if("value"===a.propertyName&&te(qe)){var b=[];ne(b,qe,a,xb(a));a=re;if(Kb)a(b);else{Kb=!0;try{Gb(a,b)}finally{Kb=!1,Mb()}}}}
function Ce(a,b,c){"focusin"===a?(Ae(),pe=b,qe=c,pe.attachEvent("onpropertychange",Be)):"focusout"===a&&Ae()}function De(a){if("selectionchange"===a||"keyup"===a||"keydown"===a)return te(qe)}function Ee(a,b){if("click"===a)return te(b)}function Fe(a,b){if("input"===a||"change"===a)return te(b)}function Ge(a,b){return a===b&&(0!==a||1/a===1/b)||a!==a&&b!==b}var He="function"===typeof Object.is?Object.is:Ge,Ie=Object.prototype.hasOwnProperty;
function Je(a,b){if(He(a,b))return!0;if("object"!==typeof a||null===a||"object"!==typeof b||null===b)return!1;var c=Object.keys(a),d=Object.keys(b);if(c.length!==d.length)return!1;for(d=0;d<c.length;d++)if(!Ie.call(b,c[d])||!He(a[c[d]],b[c[d]]))return!1;return!0}function Ke(a){for(;a&&a.firstChild;)a=a.firstChild;return a}
function Le(a,b){var c=Ke(a);a=0;for(var d;c;){if(3===c.nodeType){d=a+c.textContent.length;if(a<=b&&d>=b)return{node:c,offset:b-a};a=d}a:{for(;c;){if(c.nextSibling){c=c.nextSibling;break a}c=c.parentNode}c=void 0}c=Ke(c)}}function Me(a,b){return a&&b?a===b?!0:a&&3===a.nodeType?!1:b&&3===b.nodeType?Me(a,b.parentNode):"contains"in a?a.contains(b):a.compareDocumentPosition?!!(a.compareDocumentPosition(b)&16):!1:!1}
function Ne(){for(var a=window,b=Xa();b instanceof a.HTMLIFrameElement;){try{var c="string"===typeof b.contentWindow.location.href}catch(d){c=!1}if(c)a=b.contentWindow;else break;b=Xa(a.document)}return b}function Oe(a){var b=a&&a.nodeName&&a.nodeName.toLowerCase();return b&&("input"===b&&("text"===a.type||"search"===a.type||"tel"===a.type||"url"===a.type||"password"===a.type)||"textarea"===b||"true"===a.contentEditable)}
var Pe=fa&&"documentMode"in document&&11>=document.documentMode,Qe=null,Re=null,Se=null,Te=!1;
function Ue(a,b,c){var d=c.window===c?c.document:9===c.nodeType?c:c.ownerDocument;Te||null==Qe||Qe!==Xa(d)||(d=Qe,"selectionStart"in d&&Oe(d)?d={start:d.selectionStart,end:d.selectionEnd}:(d=(d.ownerDocument&&d.ownerDocument.defaultView||window).getSelection(),d={anchorNode:d.anchorNode,anchorOffset:d.anchorOffset,focusNode:d.focusNode,focusOffset:d.focusOffset}),Se&&Je(Se,d)||(Se=d,d=oe(Re,"onSelect"),0<d.length&&(b=new td("onSelect","select",null,b,c),a.push({event:b,listeners:d}),b.target=Qe)))}
Pc("cancel cancel click click close close contextmenu contextMenu copy copy cut cut auxclick auxClick dblclick doubleClick dragend dragEnd dragstart dragStart drop drop focusin focus focusout blur input input invalid invalid keydown keyDown keypress keyPress keyup keyUp mousedown mouseDown mouseup mouseUp paste paste pause pause play play pointercancel pointerCancel pointerdown pointerDown pointerup pointerUp ratechange rateChange reset reset seeked seeked submit submit touchcancel touchCancel touchend touchEnd touchstart touchStart volumechange volumeChange".split(" "),
0);Pc("drag drag dragenter dragEnter dragexit dragExit dragleave dragLeave dragover dragOver mousemove mouseMove mouseout mouseOut mouseover mouseOver pointermove pointerMove pointerout pointerOut pointerover pointerOver scroll scroll toggle toggle touchmove touchMove wheel wheel".split(" "),1);Pc(Oc,2);for(var Ve="change selectionchange textInput compositionstart compositionend compositionupdate".split(" "),We=0;We<Ve.length;We++)Nc.set(Ve[We],0);ea("onMouseEnter",["mouseout","mouseover"]);
ea("onMouseLeave",["mouseout","mouseover"]);ea("onPointerEnter",["pointerout","pointerover"]);ea("onPointerLeave",["pointerout","pointerover"]);da("onChange","change click focusin focusout input keydown keyup selectionchange".split(" "));da("onSelect","focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));da("onBeforeInput",["compositionend","keypress","textInput","paste"]);da("onCompositionEnd","compositionend focusout keydown keypress keyup mousedown".split(" "));
da("onCompositionStart","compositionstart focusout keydown keypress keyup mousedown".split(" "));da("onCompositionUpdate","compositionupdate focusout keydown keypress keyup mousedown".split(" "));var Xe="abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange seeked seeking stalled suspend timeupdate volumechange waiting".split(" "),Ye=new Set("cancel close invalid load scroll toggle".split(" ").concat(Xe));
function Ze(a,b,c){var d=a.type||"unknown-event";a.currentTarget=c;Yb(d,b,void 0,a);a.currentTarget=null}
function se(a,b){b=0!==(b&4);for(var c=0;c<a.length;c++){var d=a[c],e=d.event;d=d.listeners;a:{var f=void 0;if(b)for(var g=d.length-1;0<=g;g--){var h=d[g],k=h.instance,l=h.currentTarget;h=h.listener;if(k!==f&&e.isPropagationStopped())break a;Ze(e,h,l);f=k}else for(g=0;g<d.length;g++){h=d[g];k=h.instance;l=h.currentTarget;h=h.listener;if(k!==f&&e.isPropagationStopped())break a;Ze(e,h,l);f=k}}}if(Ub)throw a=Vb,Ub=!1,Vb=null,a;}
function G(a,b){var c=$e(b),d=a+"__bubble";c.has(d)||(af(b,a,2,!1),c.add(d))}var bf="_reactListening"+Math.random().toString(36).slice(2);function cf(a){a[bf]||(a[bf]=!0,ba.forEach(function(b){Ye.has(b)||df(b,!1,a,null);df(b,!0,a,null)}))}
function df(a,b,c,d){var e=4<arguments.length&&void 0!==arguments[4]?arguments[4]:0,f=c;"selectionchange"===a&&9!==c.nodeType&&(f=c.ownerDocument);if(null!==d&&!b&&Ye.has(a)){if("scroll"!==a)return;e|=2;f=d}var g=$e(f),h=a+"__"+(b?"capture":"bubble");g.has(h)||(b&&(e|=4),af(f,a,e,b),g.add(h))}
function af(a,b,c,d){var e=Nc.get(b);switch(void 0===e?2:e){case 0:e=gd;break;case 1:e=id;break;default:e=hd}c=e.bind(null,b,c,a);e=void 0;!Pb||"touchstart"!==b&&"touchmove"!==b&&"wheel"!==b||(e=!0);d?void 0!==e?a.addEventListener(b,c,{capture:!0,passive:e}):a.addEventListener(b,c,!0):void 0!==e?a.addEventListener(b,c,{passive:e}):a.addEventListener(b,c,!1)}
function jd(a,b,c,d,e){var f=d;if(0===(b&1)&&0===(b&2)&&null!==d)a:for(;;){if(null===d)return;var g=d.tag;if(3===g||4===g){var h=d.stateNode.containerInfo;if(h===e||8===h.nodeType&&h.parentNode===e)break;if(4===g)for(g=d.return;null!==g;){var k=g.tag;if(3===k||4===k)if(k=g.stateNode.containerInfo,k===e||8===k.nodeType&&k.parentNode===e)return;g=g.return}for(;null!==h;){g=wc(h);if(null===g)return;k=g.tag;if(5===k||6===k){d=f=g;continue a}h=h.parentNode}}d=d.return}Nb(function(){var d=f,e=xb(c),g=[];
a:{var h=Mc.get(a);if(void 0!==h){var k=td,x=a;switch(a){case "keypress":if(0===od(c))break a;case "keydown":case "keyup":k=Rd;break;case "focusin":x="focus";k=Fd;break;case "focusout":x="blur";k=Fd;break;case "beforeblur":case "afterblur":k=Fd;break;case "click":if(2===c.button)break a;case "auxclick":case "dblclick":case "mousedown":case "mousemove":case "mouseup":case "mouseout":case "mouseover":case "contextmenu":k=Bd;break;case "drag":case "dragend":case "dragenter":case "dragexit":case "dragleave":case "dragover":case "dragstart":case "drop":k=
Dd;break;case "touchcancel":case "touchend":case "touchmove":case "touchstart":k=Vd;break;case Ic:case Jc:case Kc:k=Hd;break;case Lc:k=Xd;break;case "scroll":k=vd;break;case "wheel":k=Zd;break;case "copy":case "cut":case "paste":k=Jd;break;case "gotpointercapture":case "lostpointercapture":case "pointercancel":case "pointerdown":case "pointermove":case "pointerout":case "pointerover":case "pointerup":k=Td}var w=0!==(b&4),z=!w&&"scroll"===a,u=w?null!==h?h+"Capture":null:h;w=[];for(var t=d,q;null!==
t;){q=t;var v=q.stateNode;5===q.tag&&null!==v&&(q=v,null!==u&&(v=Ob(t,u),null!=v&&w.push(ef(t,v,q))));if(z)break;t=t.return}0<w.length&&(h=new k(h,x,null,c,e),g.push({event:h,listeners:w}))}}if(0===(b&7)){a:{h="mouseover"===a||"pointerover"===a;k="mouseout"===a||"pointerout"===a;if(h&&0===(b&16)&&(x=c.relatedTarget||c.fromElement)&&(wc(x)||x[ff]))break a;if(k||h){h=e.window===e?e:(h=e.ownerDocument)?h.defaultView||h.parentWindow:window;if(k){if(x=c.relatedTarget||c.toElement,k=d,x=x?wc(x):null,null!==
x&&(z=Zb(x),x!==z||5!==x.tag&&6!==x.tag))x=null}else k=null,x=d;if(k!==x){w=Bd;v="onMouseLeave";u="onMouseEnter";t="mouse";if("pointerout"===a||"pointerover"===a)w=Td,v="onPointerLeave",u="onPointerEnter",t="pointer";z=null==k?h:ue(k);q=null==x?h:ue(x);h=new w(v,t+"leave",k,c,e);h.target=z;h.relatedTarget=q;v=null;wc(e)===d&&(w=new w(u,t+"enter",x,c,e),w.target=q,w.relatedTarget=z,v=w);z=v;if(k&&x)b:{w=k;u=x;t=0;for(q=w;q;q=gf(q))t++;q=0;for(v=u;v;v=gf(v))q++;for(;0<t-q;)w=gf(w),t--;for(;0<q-t;)u=
gf(u),q--;for(;t--;){if(w===u||null!==u&&w===u.alternate)break b;w=gf(w);u=gf(u)}w=null}else w=null;null!==k&&hf(g,h,k,w,!1);null!==x&&null!==z&&hf(g,z,x,w,!0)}}}a:{h=d?ue(d):window;k=h.nodeName&&h.nodeName.toLowerCase();if("select"===k||"input"===k&&"file"===h.type)var J=ve;else if(me(h))if(we)J=Fe;else{J=De;var K=Ce}else(k=h.nodeName)&&"input"===k.toLowerCase()&&("checkbox"===h.type||"radio"===h.type)&&(J=Ee);if(J&&(J=J(a,d))){ne(g,J,c,e);break a}K&&K(a,h,d);"focusout"===a&&(K=h._wrapperState)&&
K.controlled&&"number"===h.type&&bb(h,"number",h.value)}K=d?ue(d):window;switch(a){case "focusin":if(me(K)||"true"===K.contentEditable)Qe=K,Re=d,Se=null;break;case "focusout":Se=Re=Qe=null;break;case "mousedown":Te=!0;break;case "contextmenu":case "mouseup":case "dragend":Te=!1;Ue(g,c,e);break;case "selectionchange":if(Pe)break;case "keydown":case "keyup":Ue(g,c,e)}var Q;if(ae)b:{switch(a){case "compositionstart":var L="onCompositionStart";break b;case "compositionend":L="onCompositionEnd";break b;
case "compositionupdate":L="onCompositionUpdate";break b}L=void 0}else ie?ge(a,c)&&(L="onCompositionEnd"):"keydown"===a&&229===c.keyCode&&(L="onCompositionStart");L&&(de&&"ko"!==c.locale&&(ie||"onCompositionStart"!==L?"onCompositionEnd"===L&&ie&&(Q=nd()):(kd=e,ld="value"in kd?kd.value:kd.textContent,ie=!0)),K=oe(d,L),0<K.length&&(L=new Ld(L,a,null,c,e),g.push({event:L,listeners:K}),Q?L.data=Q:(Q=he(c),null!==Q&&(L.data=Q))));if(Q=ce?je(a,c):ke(a,c))d=oe(d,"onBeforeInput"),0<d.length&&(e=new Ld("onBeforeInput",
"beforeinput",null,c,e),g.push({event:e,listeners:d}),e.data=Q)}se(g,b)})}function ef(a,b,c){return{instance:a,listener:b,currentTarget:c}}function oe(a,b){for(var c=b+"Capture",d=[];null!==a;){var e=a,f=e.stateNode;5===e.tag&&null!==f&&(e=f,f=Ob(a,c),null!=f&&d.unshift(ef(a,f,e)),f=Ob(a,b),null!=f&&d.push(ef(a,f,e)));a=a.return}return d}function gf(a){if(null===a)return null;do a=a.return;while(a&&5!==a.tag);return a?a:null}
function hf(a,b,c,d,e){for(var f=b._reactName,g=[];null!==c&&c!==d;){var h=c,k=h.alternate,l=h.stateNode;if(null!==k&&k===d)break;5===h.tag&&null!==l&&(h=l,e?(k=Ob(c,f),null!=k&&g.unshift(ef(c,k,h))):e||(k=Ob(c,f),null!=k&&g.push(ef(c,k,h))));c=c.return}0!==g.length&&a.push({event:b,listeners:g})}function jf(){}var kf=null,lf=null;function mf(a,b){switch(a){case "button":case "input":case "select":case "textarea":return!!b.autoFocus}return!1}
function nf(a,b){return"textarea"===a||"option"===a||"noscript"===a||"string"===typeof b.children||"number"===typeof b.children||"object"===typeof b.dangerouslySetInnerHTML&&null!==b.dangerouslySetInnerHTML&&null!=b.dangerouslySetInnerHTML.__html}var of="function"===typeof setTimeout?setTimeout:void 0,pf="function"===typeof clearTimeout?clearTimeout:void 0;function qf(a){1===a.nodeType?a.textContent="":9===a.nodeType&&(a=a.body,null!=a&&(a.textContent=""))}
function rf(a){for(;null!=a;a=a.nextSibling){var b=a.nodeType;if(1===b||3===b)break}return a}function sf(a){a=a.previousSibling;for(var b=0;a;){if(8===a.nodeType){var c=a.data;if("$"===c||"$!"===c||"$?"===c){if(0===b)return a;b--}else"/$"===c&&b++}a=a.previousSibling}return null}var tf=0;function uf(a){return{$$typeof:Ga,toString:a,valueOf:a}}var vf=Math.random().toString(36).slice(2),wf="__reactFiber$"+vf,xf="__reactProps$"+vf,ff="__reactContainer$"+vf,yf="__reactEvents$"+vf;
function wc(a){var b=a[wf];if(b)return b;for(var c=a.parentNode;c;){if(b=c[ff]||c[wf]){c=b.alternate;if(null!==b.child||null!==c&&null!==c.child)for(a=sf(a);null!==a;){if(c=a[wf])return c;a=sf(a)}return b}a=c;c=a.parentNode}return null}function Cb(a){a=a[wf]||a[ff];return!a||5!==a.tag&&6!==a.tag&&13!==a.tag&&3!==a.tag?null:a}function ue(a){if(5===a.tag||6===a.tag)return a.stateNode;throw Error(y(33));}function Db(a){return a[xf]||null}
function $e(a){var b=a[yf];void 0===b&&(b=a[yf]=new Set);return b}var zf=[],Af=-1;function Bf(a){return{current:a}}function H(a){0>Af||(a.current=zf[Af],zf[Af]=null,Af--)}function I(a,b){Af++;zf[Af]=a.current;a.current=b}var Cf={},M=Bf(Cf),N=Bf(!1),Df=Cf;
function Ef(a,b){var c=a.type.contextTypes;if(!c)return Cf;var d=a.stateNode;if(d&&d.__reactInternalMemoizedUnmaskedChildContext===b)return d.__reactInternalMemoizedMaskedChildContext;var e={},f;for(f in c)e[f]=b[f];d&&(a=a.stateNode,a.__reactInternalMemoizedUnmaskedChildContext=b,a.__reactInternalMemoizedMaskedChildContext=e);return e}function Ff(a){a=a.childContextTypes;return null!==a&&void 0!==a}function Gf(){H(N);H(M)}function Hf(a,b,c){if(M.current!==Cf)throw Error(y(168));I(M,b);I(N,c)}
function If(a,b,c){var d=a.stateNode;a=b.childContextTypes;if("function"!==typeof d.getChildContext)return c;d=d.getChildContext();for(var e in d)if(!(e in a))throw Error(y(108,Ra(b)||"Unknown",e));return m({},c,d)}function Jf(a){a=(a=a.stateNode)&&a.__reactInternalMemoizedMergedChildContext||Cf;Df=M.current;I(M,a);I(N,N.current);return!0}function Kf(a,b,c){var d=a.stateNode;if(!d)throw Error(y(169));c?(a=If(a,b,Df),d.__reactInternalMemoizedMergedChildContext=a,H(N),H(M),I(M,a)):H(N);I(N,c)}
var Lf=null,Mf=null,Nf=r.unstable_runWithPriority,Of=r.unstable_scheduleCallback,Pf=r.unstable_cancelCallback,Qf=r.unstable_shouldYield,Rf=r.unstable_requestPaint,Sf=r.unstable_now,Tf=r.unstable_getCurrentPriorityLevel,Uf=r.unstable_ImmediatePriority,Vf=r.unstable_UserBlockingPriority,Wf=r.unstable_NormalPriority,Xf=r.unstable_LowPriority,Yf=r.unstable_IdlePriority,Zf={},$f=void 0!==Rf?Rf:function(){},ag=null,bg=null,cg=!1,dg=Sf(),O=1E4>dg?Sf:function(){return Sf()-dg};
function eg(){switch(Tf()){case Uf:return 99;case Vf:return 98;case Wf:return 97;case Xf:return 96;case Yf:return 95;default:throw Error(y(332));}}function fg(a){switch(a){case 99:return Uf;case 98:return Vf;case 97:return Wf;case 96:return Xf;case 95:return Yf;default:throw Error(y(332));}}function gg(a,b){a=fg(a);return Nf(a,b)}function hg(a,b,c){a=fg(a);return Of(a,b,c)}function ig(){if(null!==bg){var a=bg;bg=null;Pf(a)}jg()}
function jg(){if(!cg&&null!==ag){cg=!0;var a=0;try{var b=ag;gg(99,function(){for(;a<b.length;a++){var c=b[a];do c=c(!0);while(null!==c)}});ag=null}catch(c){throw null!==ag&&(ag=ag.slice(a+1)),Of(Uf,ig),c;}finally{cg=!1}}}var kg=ra.ReactCurrentBatchConfig;function lg(a,b){if(a&&a.defaultProps){b=m({},b);a=a.defaultProps;for(var c in a)void 0===b[c]&&(b[c]=a[c]);return b}return b}var mg=Bf(null),ng=null,og=null,pg=null;function qg(){pg=og=ng=null}
function rg(a){var b=mg.current;H(mg);a.type._context._currentValue=b}function sg(a,b){for(;null!==a;){var c=a.alternate;if((a.childLanes&b)===b)if(null===c||(c.childLanes&b)===b)break;else c.childLanes|=b;else a.childLanes|=b,null!==c&&(c.childLanes|=b);a=a.return}}function tg(a,b){ng=a;pg=og=null;a=a.dependencies;null!==a&&null!==a.firstContext&&(0!==(a.lanes&b)&&(ug=!0),a.firstContext=null)}
function vg(a,b){if(pg!==a&&!1!==b&&0!==b){if("number"!==typeof b||1073741823===b)pg=a,b=1073741823;b={context:a,observedBits:b,next:null};if(null===og){if(null===ng)throw Error(y(308));og=b;ng.dependencies={lanes:0,firstContext:b,responders:null}}else og=og.next=b}return a._currentValue}var wg=!1;function xg(a){a.updateQueue={baseState:a.memoizedState,firstBaseUpdate:null,lastBaseUpdate:null,shared:{pending:null},effects:null}}
function yg(a,b){a=a.updateQueue;b.updateQueue===a&&(b.updateQueue={baseState:a.baseState,firstBaseUpdate:a.firstBaseUpdate,lastBaseUpdate:a.lastBaseUpdate,shared:a.shared,effects:a.effects})}function zg(a,b){return{eventTime:a,lane:b,tag:0,payload:null,callback:null,next:null}}function Ag(a,b){a=a.updateQueue;if(null!==a){a=a.shared;var c=a.pending;null===c?b.next=b:(b.next=c.next,c.next=b);a.pending=b}}
function Bg(a,b){var c=a.updateQueue,d=a.alternate;if(null!==d&&(d=d.updateQueue,c===d)){var e=null,f=null;c=c.firstBaseUpdate;if(null!==c){do{var g={eventTime:c.eventTime,lane:c.lane,tag:c.tag,payload:c.payload,callback:c.callback,next:null};null===f?e=f=g:f=f.next=g;c=c.next}while(null!==c);null===f?e=f=b:f=f.next=b}else e=f=b;c={baseState:d.baseState,firstBaseUpdate:e,lastBaseUpdate:f,shared:d.shared,effects:d.effects};a.updateQueue=c;return}a=c.lastBaseUpdate;null===a?c.firstBaseUpdate=b:a.next=
b;c.lastBaseUpdate=b}
function Cg(a,b,c,d){var e=a.updateQueue;wg=!1;var f=e.firstBaseUpdate,g=e.lastBaseUpdate,h=e.shared.pending;if(null!==h){e.shared.pending=null;var k=h,l=k.next;k.next=null;null===g?f=l:g.next=l;g=k;var n=a.alternate;if(null!==n){n=n.updateQueue;var A=n.lastBaseUpdate;A!==g&&(null===A?n.firstBaseUpdate=l:A.next=l,n.lastBaseUpdate=k)}}if(null!==f){A=e.baseState;g=0;n=l=k=null;do{h=f.lane;var p=f.eventTime;if((d&h)===h){null!==n&&(n=n.next={eventTime:p,lane:0,tag:f.tag,payload:f.payload,callback:f.callback,
next:null});a:{var C=a,x=f;h=b;p=c;switch(x.tag){case 1:C=x.payload;if("function"===typeof C){A=C.call(p,A,h);break a}A=C;break a;case 3:C.flags=C.flags&-4097|64;case 0:C=x.payload;h="function"===typeof C?C.call(p,A,h):C;if(null===h||void 0===h)break a;A=m({},A,h);break a;case 2:wg=!0}}null!==f.callback&&(a.flags|=32,h=e.effects,null===h?e.effects=[f]:h.push(f))}else p={eventTime:p,lane:h,tag:f.tag,payload:f.payload,callback:f.callback,next:null},null===n?(l=n=p,k=A):n=n.next=p,g|=h;f=f.next;if(null===
f)if(h=e.shared.pending,null===h)break;else f=h.next,h.next=null,e.lastBaseUpdate=h,e.shared.pending=null}while(1);null===n&&(k=A);e.baseState=k;e.firstBaseUpdate=l;e.lastBaseUpdate=n;Dg|=g;a.lanes=g;a.memoizedState=A}}function Eg(a,b,c){a=b.effects;b.effects=null;if(null!==a)for(b=0;b<a.length;b++){var d=a[b],e=d.callback;if(null!==e){d.callback=null;d=c;if("function"!==typeof e)throw Error(y(191,e));e.call(d)}}}var Fg=(new aa.Component).refs;
function Gg(a,b,c,d){b=a.memoizedState;c=c(d,b);c=null===c||void 0===c?b:m({},b,c);a.memoizedState=c;0===a.lanes&&(a.updateQueue.baseState=c)}
var Kg={isMounted:function(a){return(a=a._reactInternals)?Zb(a)===a:!1},enqueueSetState:function(a,b,c){a=a._reactInternals;var d=Hg(),e=Ig(a),f=zg(d,e);f.payload=b;void 0!==c&&null!==c&&(f.callback=c);Ag(a,f);Jg(a,e,d)},enqueueReplaceState:function(a,b,c){a=a._reactInternals;var d=Hg(),e=Ig(a),f=zg(d,e);f.tag=1;f.payload=b;void 0!==c&&null!==c&&(f.callback=c);Ag(a,f);Jg(a,e,d)},enqueueForceUpdate:function(a,b){a=a._reactInternals;var c=Hg(),d=Ig(a),e=zg(c,d);e.tag=2;void 0!==b&&null!==b&&(e.callback=
b);Ag(a,e);Jg(a,d,c)}};function Lg(a,b,c,d,e,f,g){a=a.stateNode;return"function"===typeof a.shouldComponentUpdate?a.shouldComponentUpdate(d,f,g):b.prototype&&b.prototype.isPureReactComponent?!Je(c,d)||!Je(e,f):!0}
function Mg(a,b,c){var d=!1,e=Cf;var f=b.contextType;"object"===typeof f&&null!==f?f=vg(f):(e=Ff(b)?Df:M.current,d=b.contextTypes,f=(d=null!==d&&void 0!==d)?Ef(a,e):Cf);b=new b(c,f);a.memoizedState=null!==b.state&&void 0!==b.state?b.state:null;b.updater=Kg;a.stateNode=b;b._reactInternals=a;d&&(a=a.stateNode,a.__reactInternalMemoizedUnmaskedChildContext=e,a.__reactInternalMemoizedMaskedChildContext=f);return b}
function Ng(a,b,c,d){a=b.state;"function"===typeof b.componentWillReceiveProps&&b.componentWillReceiveProps(c,d);"function"===typeof b.UNSAFE_componentWillReceiveProps&&b.UNSAFE_componentWillReceiveProps(c,d);b.state!==a&&Kg.enqueueReplaceState(b,b.state,null)}
function Og(a,b,c,d){var e=a.stateNode;e.props=c;e.state=a.memoizedState;e.refs=Fg;xg(a);var f=b.contextType;"object"===typeof f&&null!==f?e.context=vg(f):(f=Ff(b)?Df:M.current,e.context=Ef(a,f));Cg(a,c,e,d);e.state=a.memoizedState;f=b.getDerivedStateFromProps;"function"===typeof f&&(Gg(a,b,f,c),e.state=a.memoizedState);"function"===typeof b.getDerivedStateFromProps||"function"===typeof e.getSnapshotBeforeUpdate||"function"!==typeof e.UNSAFE_componentWillMount&&"function"!==typeof e.componentWillMount||
(b=e.state,"function"===typeof e.componentWillMount&&e.componentWillMount(),"function"===typeof e.UNSAFE_componentWillMount&&e.UNSAFE_componentWillMount(),b!==e.state&&Kg.enqueueReplaceState(e,e.state,null),Cg(a,c,e,d),e.state=a.memoizedState);"function"===typeof e.componentDidMount&&(a.flags|=4)}var Pg=Array.isArray;
function Qg(a,b,c){a=c.ref;if(null!==a&&"function"!==typeof a&&"object"!==typeof a){if(c._owner){c=c._owner;if(c){if(1!==c.tag)throw Error(y(309));var d=c.stateNode}if(!d)throw Error(y(147,a));var e=""+a;if(null!==b&&null!==b.ref&&"function"===typeof b.ref&&b.ref._stringRef===e)return b.ref;b=function(a){var b=d.refs;b===Fg&&(b=d.refs={});null===a?delete b[e]:b[e]=a};b._stringRef=e;return b}if("string"!==typeof a)throw Error(y(284));if(!c._owner)throw Error(y(290,a));}return a}
function Rg(a,b){if("textarea"!==a.type)throw Error(y(31,"[object Object]"===Object.prototype.toString.call(b)?"object with keys {"+Object.keys(b).join(", ")+"}":b));}
function Sg(a){function b(b,c){if(a){var d=b.lastEffect;null!==d?(d.nextEffect=c,b.lastEffect=c):b.firstEffect=b.lastEffect=c;c.nextEffect=null;c.flags=8}}function c(c,d){if(!a)return null;for(;null!==d;)b(c,d),d=d.sibling;return null}function d(a,b){for(a=new Map;null!==b;)null!==b.key?a.set(b.key,b):a.set(b.index,b),b=b.sibling;return a}function e(a,b){a=Tg(a,b);a.index=0;a.sibling=null;return a}function f(b,c,d){b.index=d;if(!a)return c;d=b.alternate;if(null!==d)return d=d.index,d<c?(b.flags=2,
c):d;b.flags=2;return c}function g(b){a&&null===b.alternate&&(b.flags=2);return b}function h(a,b,c,d){if(null===b||6!==b.tag)return b=Ug(c,a.mode,d),b.return=a,b;b=e(b,c);b.return=a;return b}function k(a,b,c,d){if(null!==b&&b.elementType===c.type)return d=e(b,c.props),d.ref=Qg(a,b,c),d.return=a,d;d=Vg(c.type,c.key,c.props,null,a.mode,d);d.ref=Qg(a,b,c);d.return=a;return d}function l(a,b,c,d){if(null===b||4!==b.tag||b.stateNode.containerInfo!==c.containerInfo||b.stateNode.implementation!==c.implementation)return b=
Wg(c,a.mode,d),b.return=a,b;b=e(b,c.children||[]);b.return=a;return b}function n(a,b,c,d,f){if(null===b||7!==b.tag)return b=Xg(c,a.mode,d,f),b.return=a,b;b=e(b,c);b.return=a;return b}function A(a,b,c){if("string"===typeof b||"number"===typeof b)return b=Ug(""+b,a.mode,c),b.return=a,b;if("object"===typeof b&&null!==b){switch(b.$$typeof){case sa:return c=Vg(b.type,b.key,b.props,null,a.mode,c),c.ref=Qg(a,null,b),c.return=a,c;case ta:return b=Wg(b,a.mode,c),b.return=a,b}if(Pg(b)||La(b))return b=Xg(b,
a.mode,c,null),b.return=a,b;Rg(a,b)}return null}function p(a,b,c,d){var e=null!==b?b.key:null;if("string"===typeof c||"number"===typeof c)return null!==e?null:h(a,b,""+c,d);if("object"===typeof c&&null!==c){switch(c.$$typeof){case sa:return c.key===e?c.type===ua?n(a,b,c.props.children,d,e):k(a,b,c,d):null;case ta:return c.key===e?l(a,b,c,d):null}if(Pg(c)||La(c))return null!==e?null:n(a,b,c,d,null);Rg(a,c)}return null}function C(a,b,c,d,e){if("string"===typeof d||"number"===typeof d)return a=a.get(c)||
null,h(b,a,""+d,e);if("object"===typeof d&&null!==d){switch(d.$$typeof){case sa:return a=a.get(null===d.key?c:d.key)||null,d.type===ua?n(b,a,d.props.children,e,d.key):k(b,a,d,e);case ta:return a=a.get(null===d.key?c:d.key)||null,l(b,a,d,e)}if(Pg(d)||La(d))return a=a.get(c)||null,n(b,a,d,e,null);Rg(b,d)}return null}function x(e,g,h,k){for(var l=null,t=null,u=g,z=g=0,q=null;null!==u&&z<h.length;z++){u.index>z?(q=u,u=null):q=u.sibling;var n=p(e,u,h[z],k);if(null===n){null===u&&(u=q);break}a&&u&&null===
n.alternate&&b(e,u);g=f(n,g,z);null===t?l=n:t.sibling=n;t=n;u=q}if(z===h.length)return c(e,u),l;if(null===u){for(;z<h.length;z++)u=A(e,h[z],k),null!==u&&(g=f(u,g,z),null===t?l=u:t.sibling=u,t=u);return l}for(u=d(e,u);z<h.length;z++)q=C(u,e,z,h[z],k),null!==q&&(a&&null!==q.alternate&&u.delete(null===q.key?z:q.key),g=f(q,g,z),null===t?l=q:t.sibling=q,t=q);a&&u.forEach(function(a){return b(e,a)});return l}function w(e,g,h,k){var l=La(h);if("function"!==typeof l)throw Error(y(150));h=l.call(h);if(null==
h)throw Error(y(151));for(var t=l=null,u=g,z=g=0,q=null,n=h.next();null!==u&&!n.done;z++,n=h.next()){u.index>z?(q=u,u=null):q=u.sibling;var w=p(e,u,n.value,k);if(null===w){null===u&&(u=q);break}a&&u&&null===w.alternate&&b(e,u);g=f(w,g,z);null===t?l=w:t.sibling=w;t=w;u=q}if(n.done)return c(e,u),l;if(null===u){for(;!n.done;z++,n=h.next())n=A(e,n.value,k),null!==n&&(g=f(n,g,z),null===t?l=n:t.sibling=n,t=n);return l}for(u=d(e,u);!n.done;z++,n=h.next())n=C(u,e,z,n.value,k),null!==n&&(a&&null!==n.alternate&&
u.delete(null===n.key?z:n.key),g=f(n,g,z),null===t?l=n:t.sibling=n,t=n);a&&u.forEach(function(a){return b(e,a)});return l}return function(a,d,f,h){var k="object"===typeof f&&null!==f&&f.type===ua&&null===f.key;k&&(f=f.props.children);var l="object"===typeof f&&null!==f;if(l)switch(f.$$typeof){case sa:a:{l=f.key;for(k=d;null!==k;){if(k.key===l){switch(k.tag){case 7:if(f.type===ua){c(a,k.sibling);d=e(k,f.props.children);d.return=a;a=d;break a}break;default:if(k.elementType===f.type){c(a,k.sibling);
d=e(k,f.props);d.ref=Qg(a,k,f);d.return=a;a=d;break a}}c(a,k);break}else b(a,k);k=k.sibling}f.type===ua?(d=Xg(f.props.children,a.mode,h,f.key),d.return=a,a=d):(h=Vg(f.type,f.key,f.props,null,a.mode,h),h.ref=Qg(a,d,f),h.return=a,a=h)}return g(a);case ta:a:{for(k=f.key;null!==d;){if(d.key===k)if(4===d.tag&&d.stateNode.containerInfo===f.containerInfo&&d.stateNode.implementation===f.implementation){c(a,d.sibling);d=e(d,f.children||[]);d.return=a;a=d;break a}else{c(a,d);break}else b(a,d);d=d.sibling}d=
Wg(f,a.mode,h);d.return=a;a=d}return g(a)}if("string"===typeof f||"number"===typeof f)return f=""+f,null!==d&&6===d.tag?(c(a,d.sibling),d=e(d,f),d.return=a,a=d):(c(a,d),d=Ug(f,a.mode,h),d.return=a,a=d),g(a);if(Pg(f))return x(a,d,f,h);if(La(f))return w(a,d,f,h);l&&Rg(a,f);if("undefined"===typeof f&&!k)switch(a.tag){case 1:case 22:case 0:case 11:case 15:throw Error(y(152,Ra(a.type)||"Component"));}return c(a,d)}}var Yg=Sg(!0),Zg=Sg(!1),$g={},ah=Bf($g),bh=Bf($g),ch=Bf($g);
function dh(a){if(a===$g)throw Error(y(174));return a}function eh(a,b){I(ch,b);I(bh,a);I(ah,$g);a=b.nodeType;switch(a){case 9:case 11:b=(b=b.documentElement)?b.namespaceURI:mb(null,"");break;default:a=8===a?b.parentNode:b,b=a.namespaceURI||null,a=a.tagName,b=mb(b,a)}H(ah);I(ah,b)}function fh(){H(ah);H(bh);H(ch)}function gh(a){dh(ch.current);var b=dh(ah.current);var c=mb(b,a.type);b!==c&&(I(bh,a),I(ah,c))}function hh(a){bh.current===a&&(H(ah),H(bh))}var P=Bf(0);
function ih(a){for(var b=a;null!==b;){if(13===b.tag){var c=b.memoizedState;if(null!==c&&(c=c.dehydrated,null===c||"$?"===c.data||"$!"===c.data))return b}else if(19===b.tag&&void 0!==b.memoizedProps.revealOrder){if(0!==(b.flags&64))return b}else if(null!==b.child){b.child.return=b;b=b.child;continue}if(b===a)break;for(;null===b.sibling;){if(null===b.return||b.return===a)return null;b=b.return}b.sibling.return=b.return;b=b.sibling}return null}var jh=null,kh=null,lh=!1;
function mh(a,b){var c=nh(5,null,null,0);c.elementType="DELETED";c.type="DELETED";c.stateNode=b;c.return=a;c.flags=8;null!==a.lastEffect?(a.lastEffect.nextEffect=c,a.lastEffect=c):a.firstEffect=a.lastEffect=c}function oh(a,b){switch(a.tag){case 5:var c=a.type;b=1!==b.nodeType||c.toLowerCase()!==b.nodeName.toLowerCase()?null:b;return null!==b?(a.stateNode=b,!0):!1;case 6:return b=""===a.pendingProps||3!==b.nodeType?null:b,null!==b?(a.stateNode=b,!0):!1;case 13:return!1;default:return!1}}
function ph(a){if(lh){var b=kh;if(b){var c=b;if(!oh(a,b)){b=rf(c.nextSibling);if(!b||!oh(a,b)){a.flags=a.flags&-1025|2;lh=!1;jh=a;return}mh(jh,c)}jh=a;kh=rf(b.firstChild)}else a.flags=a.flags&-1025|2,lh=!1,jh=a}}function qh(a){for(a=a.return;null!==a&&5!==a.tag&&3!==a.tag&&13!==a.tag;)a=a.return;jh=a}
function rh(a){if(a!==jh)return!1;if(!lh)return qh(a),lh=!0,!1;var b=a.type;if(5!==a.tag||"head"!==b&&"body"!==b&&!nf(b,a.memoizedProps))for(b=kh;b;)mh(a,b),b=rf(b.nextSibling);qh(a);if(13===a.tag){a=a.memoizedState;a=null!==a?a.dehydrated:null;if(!a)throw Error(y(317));a:{a=a.nextSibling;for(b=0;a;){if(8===a.nodeType){var c=a.data;if("/$"===c){if(0===b){kh=rf(a.nextSibling);break a}b--}else"$"!==c&&"$!"!==c&&"$?"!==c||b++}a=a.nextSibling}kh=null}}else kh=jh?rf(a.stateNode.nextSibling):null;return!0}
function sh(){kh=jh=null;lh=!1}var th=[];function uh(){for(var a=0;a<th.length;a++)th[a]._workInProgressVersionPrimary=null;th.length=0}var vh=ra.ReactCurrentDispatcher,wh=ra.ReactCurrentBatchConfig,xh=0,R=null,S=null,T=null,yh=!1,zh=!1;function Ah(){throw Error(y(321));}function Bh(a,b){if(null===b)return!1;for(var c=0;c<b.length&&c<a.length;c++)if(!He(a[c],b[c]))return!1;return!0}
function Ch(a,b,c,d,e,f){xh=f;R=b;b.memoizedState=null;b.updateQueue=null;b.lanes=0;vh.current=null===a||null===a.memoizedState?Dh:Eh;a=c(d,e);if(zh){f=0;do{zh=!1;if(!(25>f))throw Error(y(301));f+=1;T=S=null;b.updateQueue=null;vh.current=Fh;a=c(d,e)}while(zh)}vh.current=Gh;b=null!==S&&null!==S.next;xh=0;T=S=R=null;yh=!1;if(b)throw Error(y(300));return a}function Hh(){var a={memoizedState:null,baseState:null,baseQueue:null,queue:null,next:null};null===T?R.memoizedState=T=a:T=T.next=a;return T}
function Ih(){if(null===S){var a=R.alternate;a=null!==a?a.memoizedState:null}else a=S.next;var b=null===T?R.memoizedState:T.next;if(null!==b)T=b,S=a;else{if(null===a)throw Error(y(310));S=a;a={memoizedState:S.memoizedState,baseState:S.baseState,baseQueue:S.baseQueue,queue:S.queue,next:null};null===T?R.memoizedState=T=a:T=T.next=a}return T}function Jh(a,b){return"function"===typeof b?b(a):b}
function Kh(a){var b=Ih(),c=b.queue;if(null===c)throw Error(y(311));c.lastRenderedReducer=a;var d=S,e=d.baseQueue,f=c.pending;if(null!==f){if(null!==e){var g=e.next;e.next=f.next;f.next=g}d.baseQueue=e=f;c.pending=null}if(null!==e){e=e.next;d=d.baseState;var h=g=f=null,k=e;do{var l=k.lane;if((xh&l)===l)null!==h&&(h=h.next={lane:0,action:k.action,eagerReducer:k.eagerReducer,eagerState:k.eagerState,next:null}),d=k.eagerReducer===a?k.eagerState:a(d,k.action);else{var n={lane:l,action:k.action,eagerReducer:k.eagerReducer,
eagerState:k.eagerState,next:null};null===h?(g=h=n,f=d):h=h.next=n;R.lanes|=l;Dg|=l}k=k.next}while(null!==k&&k!==e);null===h?f=d:h.next=g;He(d,b.memoizedState)||(ug=!0);b.memoizedState=d;b.baseState=f;b.baseQueue=h;c.lastRenderedState=d}return[b.memoizedState,c.dispatch]}
function Lh(a){var b=Ih(),c=b.queue;if(null===c)throw Error(y(311));c.lastRenderedReducer=a;var d=c.dispatch,e=c.pending,f=b.memoizedState;if(null!==e){c.pending=null;var g=e=e.next;do f=a(f,g.action),g=g.next;while(g!==e);He(f,b.memoizedState)||(ug=!0);b.memoizedState=f;null===b.baseQueue&&(b.baseState=f);c.lastRenderedState=f}return[f,d]}
function Mh(a,b,c){var d=b._getVersion;d=d(b._source);var e=b._workInProgressVersionPrimary;if(null!==e)a=e===d;else if(a=a.mutableReadLanes,a=(xh&a)===a)b._workInProgressVersionPrimary=d,th.push(b);if(a)return c(b._source);th.push(b);throw Error(y(350));}
function Nh(a,b,c,d){var e=U;if(null===e)throw Error(y(349));var f=b._getVersion,g=f(b._source),h=vh.current,k=h.useState(function(){return Mh(e,b,c)}),l=k[1],n=k[0];k=T;var A=a.memoizedState,p=A.refs,C=p.getSnapshot,x=A.source;A=A.subscribe;var w=R;a.memoizedState={refs:p,source:b,subscribe:d};h.useEffect(function(){p.getSnapshot=c;p.setSnapshot=l;var a=f(b._source);if(!He(g,a)){a=c(b._source);He(n,a)||(l(a),a=Ig(w),e.mutableReadLanes|=a&e.pendingLanes);a=e.mutableReadLanes;e.entangledLanes|=a;for(var d=
e.entanglements,h=a;0<h;){var k=31-Vc(h),v=1<<k;d[k]|=a;h&=~v}}},[c,b,d]);h.useEffect(function(){return d(b._source,function(){var a=p.getSnapshot,c=p.setSnapshot;try{c(a(b._source));var d=Ig(w);e.mutableReadLanes|=d&e.pendingLanes}catch(q){c(function(){throw q;})}})},[b,d]);He(C,c)&&He(x,b)&&He(A,d)||(a={pending:null,dispatch:null,lastRenderedReducer:Jh,lastRenderedState:n},a.dispatch=l=Oh.bind(null,R,a),k.queue=a,k.baseQueue=null,n=Mh(e,b,c),k.memoizedState=k.baseState=n);return n}
function Ph(a,b,c){var d=Ih();return Nh(d,a,b,c)}function Qh(a){var b=Hh();"function"===typeof a&&(a=a());b.memoizedState=b.baseState=a;a=b.queue={pending:null,dispatch:null,lastRenderedReducer:Jh,lastRenderedState:a};a=a.dispatch=Oh.bind(null,R,a);return[b.memoizedState,a]}
function Rh(a,b,c,d){a={tag:a,create:b,destroy:c,deps:d,next:null};b=R.updateQueue;null===b?(b={lastEffect:null},R.updateQueue=b,b.lastEffect=a.next=a):(c=b.lastEffect,null===c?b.lastEffect=a.next=a:(d=c.next,c.next=a,a.next=d,b.lastEffect=a));return a}function Sh(a){var b=Hh();a={current:a};return b.memoizedState=a}function Th(){return Ih().memoizedState}function Uh(a,b,c,d){var e=Hh();R.flags|=a;e.memoizedState=Rh(1|b,c,void 0,void 0===d?null:d)}
function Vh(a,b,c,d){var e=Ih();d=void 0===d?null:d;var f=void 0;if(null!==S){var g=S.memoizedState;f=g.destroy;if(null!==d&&Bh(d,g.deps)){Rh(b,c,f,d);return}}R.flags|=a;e.memoizedState=Rh(1|b,c,f,d)}function Wh(a,b){return Uh(516,4,a,b)}function Xh(a,b){return Vh(516,4,a,b)}function Yh(a,b){return Vh(4,2,a,b)}function Zh(a,b){if("function"===typeof b)return a=a(),b(a),function(){b(null)};if(null!==b&&void 0!==b)return a=a(),b.current=a,function(){b.current=null}}
function $h(a,b,c){c=null!==c&&void 0!==c?c.concat([a]):null;return Vh(4,2,Zh.bind(null,b,a),c)}function ai(){}function bi(a,b){var c=Ih();b=void 0===b?null:b;var d=c.memoizedState;if(null!==d&&null!==b&&Bh(b,d[1]))return d[0];c.memoizedState=[a,b];return a}function ci(a,b){var c=Ih();b=void 0===b?null:b;var d=c.memoizedState;if(null!==d&&null!==b&&Bh(b,d[1]))return d[0];a=a();c.memoizedState=[a,b];return a}
function di(a,b){var c=eg();gg(98>c?98:c,function(){a(!0)});gg(97<c?97:c,function(){var c=wh.transition;wh.transition=1;try{a(!1),b()}finally{wh.transition=c}})}
function Oh(a,b,c){var d=Hg(),e=Ig(a),f={lane:e,action:c,eagerReducer:null,eagerState:null,next:null},g=b.pending;null===g?f.next=f:(f.next=g.next,g.next=f);b.pending=f;g=a.alternate;if(a===R||null!==g&&g===R)zh=yh=!0;else{if(0===a.lanes&&(null===g||0===g.lanes)&&(g=b.lastRenderedReducer,null!==g))try{var h=b.lastRenderedState,k=g(h,c);f.eagerReducer=g;f.eagerState=k;if(He(k,h))return}catch(l){}finally{}Jg(a,e,d)}}
var Gh={readContext:vg,useCallback:Ah,useContext:Ah,useEffect:Ah,useImperativeHandle:Ah,useLayoutEffect:Ah,useMemo:Ah,useReducer:Ah,useRef:Ah,useState:Ah,useDebugValue:Ah,useDeferredValue:Ah,useTransition:Ah,useMutableSource:Ah,useOpaqueIdentifier:Ah,unstable_isNewReconciler:!1},Dh={readContext:vg,useCallback:function(a,b){Hh().memoizedState=[a,void 0===b?null:b];return a},useContext:vg,useEffect:Wh,useImperativeHandle:function(a,b,c){c=null!==c&&void 0!==c?c.concat([a]):null;return Uh(4,2,Zh.bind(null,
b,a),c)},useLayoutEffect:function(a,b){return Uh(4,2,a,b)},useMemo:function(a,b){var c=Hh();b=void 0===b?null:b;a=a();c.memoizedState=[a,b];return a},useReducer:function(a,b,c){var d=Hh();b=void 0!==c?c(b):b;d.memoizedState=d.baseState=b;a=d.queue={pending:null,dispatch:null,lastRenderedReducer:a,lastRenderedState:b};a=a.dispatch=Oh.bind(null,R,a);return[d.memoizedState,a]},useRef:Sh,useState:Qh,useDebugValue:ai,useDeferredValue:function(a){var b=Qh(a),c=b[0],d=b[1];Wh(function(){var b=wh.transition;
wh.transition=1;try{d(a)}finally{wh.transition=b}},[a]);return c},useTransition:function(){var a=Qh(!1),b=a[0];a=di.bind(null,a[1]);Sh(a);return[a,b]},useMutableSource:function(a,b,c){var d=Hh();d.memoizedState={refs:{getSnapshot:b,setSnapshot:null},source:a,subscribe:c};return Nh(d,a,b,c)},useOpaqueIdentifier:function(){if(lh){var a=!1,b=uf(function(){a||(a=!0,c("r:"+(tf++).toString(36)));throw Error(y(355));}),c=Qh(b)[1];0===(R.mode&2)&&(R.flags|=516,Rh(5,function(){c("r:"+(tf++).toString(36))},
void 0,null));return b}b="r:"+(tf++).toString(36);Qh(b);return b},unstable_isNewReconciler:!1},Eh={readContext:vg,useCallback:bi,useContext:vg,useEffect:Xh,useImperativeHandle:$h,useLayoutEffect:Yh,useMemo:ci,useReducer:Kh,useRef:Th,useState:function(){return Kh(Jh)},useDebugValue:ai,useDeferredValue:function(a){var b=Kh(Jh),c=b[0],d=b[1];Xh(function(){var b=wh.transition;wh.transition=1;try{d(a)}finally{wh.transition=b}},[a]);return c},useTransition:function(){var a=Kh(Jh)[0];return[Th().current,
a]},useMutableSource:Ph,useOpaqueIdentifier:function(){return Kh(Jh)[0]},unstable_isNewReconciler:!1},Fh={readContext:vg,useCallback:bi,useContext:vg,useEffect:Xh,useImperativeHandle:$h,useLayoutEffect:Yh,useMemo:ci,useReducer:Lh,useRef:Th,useState:function(){return Lh(Jh)},useDebugValue:ai,useDeferredValue:function(a){var b=Lh(Jh),c=b[0],d=b[1];Xh(function(){var b=wh.transition;wh.transition=1;try{d(a)}finally{wh.transition=b}},[a]);return c},useTransition:function(){var a=Lh(Jh)[0];return[Th().current,
a]},useMutableSource:Ph,useOpaqueIdentifier:function(){return Lh(Jh)[0]},unstable_isNewReconciler:!1},ei=ra.ReactCurrentOwner,ug=!1;function fi(a,b,c,d){b.child=null===a?Zg(b,null,c,d):Yg(b,a.child,c,d)}function gi(a,b,c,d,e){c=c.render;var f=b.ref;tg(b,e);d=Ch(a,b,c,d,f,e);if(null!==a&&!ug)return b.updateQueue=a.updateQueue,b.flags&=-517,a.lanes&=~e,hi(a,b,e);b.flags|=1;fi(a,b,d,e);return b.child}
function ii(a,b,c,d,e,f){if(null===a){var g=c.type;if("function"===typeof g&&!ji(g)&&void 0===g.defaultProps&&null===c.compare&&void 0===c.defaultProps)return b.tag=15,b.type=g,ki(a,b,g,d,e,f);a=Vg(c.type,null,d,b,b.mode,f);a.ref=b.ref;a.return=b;return b.child=a}g=a.child;if(0===(e&f)&&(e=g.memoizedProps,c=c.compare,c=null!==c?c:Je,c(e,d)&&a.ref===b.ref))return hi(a,b,f);b.flags|=1;a=Tg(g,d);a.ref=b.ref;a.return=b;return b.child=a}
function ki(a,b,c,d,e,f){if(null!==a&&Je(a.memoizedProps,d)&&a.ref===b.ref)if(ug=!1,0!==(f&e))0!==(a.flags&16384)&&(ug=!0);else return b.lanes=a.lanes,hi(a,b,f);return li(a,b,c,d,f)}
function mi(a,b,c){var d=b.pendingProps,e=d.children,f=null!==a?a.memoizedState:null;if("hidden"===d.mode||"unstable-defer-without-hiding"===d.mode)if(0===(b.mode&4))b.memoizedState={baseLanes:0},ni(b,c);else if(0!==(c&1073741824))b.memoizedState={baseLanes:0},ni(b,null!==f?f.baseLanes:c);else return a=null!==f?f.baseLanes|c:c,b.lanes=b.childLanes=1073741824,b.memoizedState={baseLanes:a},ni(b,a),null;else null!==f?(d=f.baseLanes|c,b.memoizedState=null):d=c,ni(b,d);fi(a,b,e,c);return b.child}
function oi(a,b){var c=b.ref;if(null===a&&null!==c||null!==a&&a.ref!==c)b.flags|=128}function li(a,b,c,d,e){var f=Ff(c)?Df:M.current;f=Ef(b,f);tg(b,e);c=Ch(a,b,c,d,f,e);if(null!==a&&!ug)return b.updateQueue=a.updateQueue,b.flags&=-517,a.lanes&=~e,hi(a,b,e);b.flags|=1;fi(a,b,c,e);return b.child}
function pi(a,b,c,d,e){if(Ff(c)){var f=!0;Jf(b)}else f=!1;tg(b,e);if(null===b.stateNode)null!==a&&(a.alternate=null,b.alternate=null,b.flags|=2),Mg(b,c,d),Og(b,c,d,e),d=!0;else if(null===a){var g=b.stateNode,h=b.memoizedProps;g.props=h;var k=g.context,l=c.contextType;"object"===typeof l&&null!==l?l=vg(l):(l=Ff(c)?Df:M.current,l=Ef(b,l));var n=c.getDerivedStateFromProps,A="function"===typeof n||"function"===typeof g.getSnapshotBeforeUpdate;A||"function"!==typeof g.UNSAFE_componentWillReceiveProps&&
"function"!==typeof g.componentWillReceiveProps||(h!==d||k!==l)&&Ng(b,g,d,l);wg=!1;var p=b.memoizedState;g.state=p;Cg(b,d,g,e);k=b.memoizedState;h!==d||p!==k||N.current||wg?("function"===typeof n&&(Gg(b,c,n,d),k=b.memoizedState),(h=wg||Lg(b,c,h,d,p,k,l))?(A||"function"!==typeof g.UNSAFE_componentWillMount&&"function"!==typeof g.componentWillMount||("function"===typeof g.componentWillMount&&g.componentWillMount(),"function"===typeof g.UNSAFE_componentWillMount&&g.UNSAFE_componentWillMount()),"function"===
typeof g.componentDidMount&&(b.flags|=4)):("function"===typeof g.componentDidMount&&(b.flags|=4),b.memoizedProps=d,b.memoizedState=k),g.props=d,g.state=k,g.context=l,d=h):("function"===typeof g.componentDidMount&&(b.flags|=4),d=!1)}else{g=b.stateNode;yg(a,b);h=b.memoizedProps;l=b.type===b.elementType?h:lg(b.type,h);g.props=l;A=b.pendingProps;p=g.context;k=c.contextType;"object"===typeof k&&null!==k?k=vg(k):(k=Ff(c)?Df:M.current,k=Ef(b,k));var C=c.getDerivedStateFromProps;(n="function"===typeof C||
"function"===typeof g.getSnapshotBeforeUpdate)||"function"!==typeof g.UNSAFE_componentWillReceiveProps&&"function"!==typeof g.componentWillReceiveProps||(h!==A||p!==k)&&Ng(b,g,d,k);wg=!1;p=b.memoizedState;g.state=p;Cg(b,d,g,e);var x=b.memoizedState;h!==A||p!==x||N.current||wg?("function"===typeof C&&(Gg(b,c,C,d),x=b.memoizedState),(l=wg||Lg(b,c,l,d,p,x,k))?(n||"function"!==typeof g.UNSAFE_componentWillUpdate&&"function"!==typeof g.componentWillUpdate||("function"===typeof g.componentWillUpdate&&g.componentWillUpdate(d,
x,k),"function"===typeof g.UNSAFE_componentWillUpdate&&g.UNSAFE_componentWillUpdate(d,x,k)),"function"===typeof g.componentDidUpdate&&(b.flags|=4),"function"===typeof g.getSnapshotBeforeUpdate&&(b.flags|=256)):("function"!==typeof g.componentDidUpdate||h===a.memoizedProps&&p===a.memoizedState||(b.flags|=4),"function"!==typeof g.getSnapshotBeforeUpdate||h===a.memoizedProps&&p===a.memoizedState||(b.flags|=256),b.memoizedProps=d,b.memoizedState=x),g.props=d,g.state=x,g.context=k,d=l):("function"!==typeof g.componentDidUpdate||
h===a.memoizedProps&&p===a.memoizedState||(b.flags|=4),"function"!==typeof g.getSnapshotBeforeUpdate||h===a.memoizedProps&&p===a.memoizedState||(b.flags|=256),d=!1)}return qi(a,b,c,d,f,e)}
function qi(a,b,c,d,e,f){oi(a,b);var g=0!==(b.flags&64);if(!d&&!g)return e&&Kf(b,c,!1),hi(a,b,f);d=b.stateNode;ei.current=b;var h=g&&"function"!==typeof c.getDerivedStateFromError?null:d.render();b.flags|=1;null!==a&&g?(b.child=Yg(b,a.child,null,f),b.child=Yg(b,null,h,f)):fi(a,b,h,f);b.memoizedState=d.state;e&&Kf(b,c,!0);return b.child}function ri(a){var b=a.stateNode;b.pendingContext?Hf(a,b.pendingContext,b.pendingContext!==b.context):b.context&&Hf(a,b.context,!1);eh(a,b.containerInfo)}
var si={dehydrated:null,retryLane:0};
function ti(a,b,c){var d=b.pendingProps,e=P.current,f=!1,g;(g=0!==(b.flags&64))||(g=null!==a&&null===a.memoizedState?!1:0!==(e&2));g?(f=!0,b.flags&=-65):null!==a&&null===a.memoizedState||void 0===d.fallback||!0===d.unstable_avoidThisFallback||(e|=1);I(P,e&1);if(null===a){void 0!==d.fallback&&ph(b);a=d.children;e=d.fallback;if(f)return a=ui(b,a,e,c),b.child.memoizedState={baseLanes:c},b.memoizedState=si,a;if("number"===typeof d.unstable_expectedLoadTime)return a=ui(b,a,e,c),b.child.memoizedState={baseLanes:c},
b.memoizedState=si,b.lanes=33554432,a;c=vi({mode:"visible",children:a},b.mode,c,null);c.return=b;return b.child=c}if(null!==a.memoizedState){if(f)return d=wi(a,b,d.children,d.fallback,c),f=b.child,e=a.child.memoizedState,f.memoizedState=null===e?{baseLanes:c}:{baseLanes:e.baseLanes|c},f.childLanes=a.childLanes&~c,b.memoizedState=si,d;c=xi(a,b,d.children,c);b.memoizedState=null;return c}if(f)return d=wi(a,b,d.children,d.fallback,c),f=b.child,e=a.child.memoizedState,f.memoizedState=null===e?{baseLanes:c}:
{baseLanes:e.baseLanes|c},f.childLanes=a.childLanes&~c,b.memoizedState=si,d;c=xi(a,b,d.children,c);b.memoizedState=null;return c}function ui(a,b,c,d){var e=a.mode,f=a.child;b={mode:"hidden",children:b};0===(e&2)&&null!==f?(f.childLanes=0,f.pendingProps=b):f=vi(b,e,0,null);c=Xg(c,e,d,null);f.return=a;c.return=a;f.sibling=c;a.child=f;return c}
function xi(a,b,c,d){var e=a.child;a=e.sibling;c=Tg(e,{mode:"visible",children:c});0===(b.mode&2)&&(c.lanes=d);c.return=b;c.sibling=null;null!==a&&(a.nextEffect=null,a.flags=8,b.firstEffect=b.lastEffect=a);return b.child=c}
function wi(a,b,c,d,e){var f=b.mode,g=a.child;a=g.sibling;var h={mode:"hidden",children:c};0===(f&2)&&b.child!==g?(c=b.child,c.childLanes=0,c.pendingProps=h,g=c.lastEffect,null!==g?(b.firstEffect=c.firstEffect,b.lastEffect=g,g.nextEffect=null):b.firstEffect=b.lastEffect=null):c=Tg(g,h);null!==a?d=Tg(a,d):(d=Xg(d,f,e,null),d.flags|=2);d.return=b;c.return=b;c.sibling=d;b.child=c;return d}function yi(a,b){a.lanes|=b;var c=a.alternate;null!==c&&(c.lanes|=b);sg(a.return,b)}
function zi(a,b,c,d,e,f){var g=a.memoizedState;null===g?a.memoizedState={isBackwards:b,rendering:null,renderingStartTime:0,last:d,tail:c,tailMode:e,lastEffect:f}:(g.isBackwards=b,g.rendering=null,g.renderingStartTime=0,g.last=d,g.tail=c,g.tailMode=e,g.lastEffect=f)}
function Ai(a,b,c){var d=b.pendingProps,e=d.revealOrder,f=d.tail;fi(a,b,d.children,c);d=P.current;if(0!==(d&2))d=d&1|2,b.flags|=64;else{if(null!==a&&0!==(a.flags&64))a:for(a=b.child;null!==a;){if(13===a.tag)null!==a.memoizedState&&yi(a,c);else if(19===a.tag)yi(a,c);else if(null!==a.child){a.child.return=a;a=a.child;continue}if(a===b)break a;for(;null===a.sibling;){if(null===a.return||a.return===b)break a;a=a.return}a.sibling.return=a.return;a=a.sibling}d&=1}I(P,d);if(0===(b.mode&2))b.memoizedState=
null;else switch(e){case "forwards":c=b.child;for(e=null;null!==c;)a=c.alternate,null!==a&&null===ih(a)&&(e=c),c=c.sibling;c=e;null===c?(e=b.child,b.child=null):(e=c.sibling,c.sibling=null);zi(b,!1,e,c,f,b.lastEffect);break;case "backwards":c=null;e=b.child;for(b.child=null;null!==e;){a=e.alternate;if(null!==a&&null===ih(a)){b.child=e;break}a=e.sibling;e.sibling=c;c=e;e=a}zi(b,!0,c,null,f,b.lastEffect);break;case "together":zi(b,!1,null,null,void 0,b.lastEffect);break;default:b.memoizedState=null}return b.child}
function hi(a,b,c){null!==a&&(b.dependencies=a.dependencies);Dg|=b.lanes;if(0!==(c&b.childLanes)){if(null!==a&&b.child!==a.child)throw Error(y(153));if(null!==b.child){a=b.child;c=Tg(a,a.pendingProps);b.child=c;for(c.return=b;null!==a.sibling;)a=a.sibling,c=c.sibling=Tg(a,a.pendingProps),c.return=b;c.sibling=null}return b.child}return null}var Bi,Ci,Di,Ei;
Bi=function(a,b){for(var c=b.child;null!==c;){if(5===c.tag||6===c.tag)a.appendChild(c.stateNode);else if(4!==c.tag&&null!==c.child){c.child.return=c;c=c.child;continue}if(c===b)break;for(;null===c.sibling;){if(null===c.return||c.return===b)return;c=c.return}c.sibling.return=c.return;c=c.sibling}};Ci=function(){};
Di=function(a,b,c,d){var e=a.memoizedProps;if(e!==d){a=b.stateNode;dh(ah.current);var f=null;switch(c){case "input":e=Ya(a,e);d=Ya(a,d);f=[];break;case "option":e=eb(a,e);d=eb(a,d);f=[];break;case "select":e=m({},e,{value:void 0});d=m({},d,{value:void 0});f=[];break;case "textarea":e=gb(a,e);d=gb(a,d);f=[];break;default:"function"!==typeof e.onClick&&"function"===typeof d.onClick&&(a.onclick=jf)}vb(c,d);var g;c=null;for(l in e)if(!d.hasOwnProperty(l)&&e.hasOwnProperty(l)&&null!=e[l])if("style"===
l){var h=e[l];for(g in h)h.hasOwnProperty(g)&&(c||(c={}),c[g]="")}else"dangerouslySetInnerHTML"!==l&&"children"!==l&&"suppressContentEditableWarning"!==l&&"suppressHydrationWarning"!==l&&"autoFocus"!==l&&(ca.hasOwnProperty(l)?f||(f=[]):(f=f||[]).push(l,null));for(l in d){var k=d[l];h=null!=e?e[l]:void 0;if(d.hasOwnProperty(l)&&k!==h&&(null!=k||null!=h))if("style"===l)if(h){for(g in h)!h.hasOwnProperty(g)||k&&k.hasOwnProperty(g)||(c||(c={}),c[g]="");for(g in k)k.hasOwnProperty(g)&&h[g]!==k[g]&&(c||
(c={}),c[g]=k[g])}else c||(f||(f=[]),f.push(l,c)),c=k;else"dangerouslySetInnerHTML"===l?(k=k?k.__html:void 0,h=h?h.__html:void 0,null!=k&&h!==k&&(f=f||[]).push(l,k)):"children"===l?"string"!==typeof k&&"number"!==typeof k||(f=f||[]).push(l,""+k):"suppressContentEditableWarning"!==l&&"suppressHydrationWarning"!==l&&(ca.hasOwnProperty(l)?(null!=k&&"onScroll"===l&&G("scroll",a),f||h===k||(f=[])):"object"===typeof k&&null!==k&&k.$$typeof===Ga?k.toString():(f=f||[]).push(l,k))}c&&(f=f||[]).push("style",
c);var l=f;if(b.updateQueue=l)b.flags|=4}};Ei=function(a,b,c,d){c!==d&&(b.flags|=4)};function Fi(a,b){if(!lh)switch(a.tailMode){case "hidden":b=a.tail;for(var c=null;null!==b;)null!==b.alternate&&(c=b),b=b.sibling;null===c?a.tail=null:c.sibling=null;break;case "collapsed":c=a.tail;for(var d=null;null!==c;)null!==c.alternate&&(d=c),c=c.sibling;null===d?b||null===a.tail?a.tail=null:a.tail.sibling=null:d.sibling=null}}
function Gi(a,b,c){var d=b.pendingProps;switch(b.tag){case 2:case 16:case 15:case 0:case 11:case 7:case 8:case 12:case 9:case 14:return null;case 1:return Ff(b.type)&&Gf(),null;case 3:fh();H(N);H(M);uh();d=b.stateNode;d.pendingContext&&(d.context=d.pendingContext,d.pendingContext=null);if(null===a||null===a.child)rh(b)?b.flags|=4:d.hydrate||(b.flags|=256);Ci(b);return null;case 5:hh(b);var e=dh(ch.current);c=b.type;if(null!==a&&null!=b.stateNode)Di(a,b,c,d,e),a.ref!==b.ref&&(b.flags|=128);else{if(!d){if(null===
b.stateNode)throw Error(y(166));return null}a=dh(ah.current);if(rh(b)){d=b.stateNode;c=b.type;var f=b.memoizedProps;d[wf]=b;d[xf]=f;switch(c){case "dialog":G("cancel",d);G("close",d);break;case "iframe":case "object":case "embed":G("load",d);break;case "video":case "audio":for(a=0;a<Xe.length;a++)G(Xe[a],d);break;case "source":G("error",d);break;case "img":case "image":case "link":G("error",d);G("load",d);break;case "details":G("toggle",d);break;case "input":Za(d,f);G("invalid",d);break;case "select":d._wrapperState=
{wasMultiple:!!f.multiple};G("invalid",d);break;case "textarea":hb(d,f),G("invalid",d)}vb(c,f);a=null;for(var g in f)f.hasOwnProperty(g)&&(e=f[g],"children"===g?"string"===typeof e?d.textContent!==e&&(a=["children",e]):"number"===typeof e&&d.textContent!==""+e&&(a=["children",""+e]):ca.hasOwnProperty(g)&&null!=e&&"onScroll"===g&&G("scroll",d));switch(c){case "input":Va(d);cb(d,f,!0);break;case "textarea":Va(d);jb(d);break;case "select":case "option":break;default:"function"===typeof f.onClick&&(d.onclick=
jf)}d=a;b.updateQueue=d;null!==d&&(b.flags|=4)}else{g=9===e.nodeType?e:e.ownerDocument;a===kb.html&&(a=lb(c));a===kb.html?"script"===c?(a=g.createElement("div"),a.innerHTML="<script>\x3c/script>",a=a.removeChild(a.firstChild)):"string"===typeof d.is?a=g.createElement(c,{is:d.is}):(a=g.createElement(c),"select"===c&&(g=a,d.multiple?g.multiple=!0:d.size&&(g.size=d.size))):a=g.createElementNS(a,c);a[wf]=b;a[xf]=d;Bi(a,b,!1,!1);b.stateNode=a;g=wb(c,d);switch(c){case "dialog":G("cancel",a);G("close",a);
e=d;break;case "iframe":case "object":case "embed":G("load",a);e=d;break;case "video":case "audio":for(e=0;e<Xe.length;e++)G(Xe[e],a);e=d;break;case "source":G("error",a);e=d;break;case "img":case "image":case "link":G("error",a);G("load",a);e=d;break;case "details":G("toggle",a);e=d;break;case "input":Za(a,d);e=Ya(a,d);G("invalid",a);break;case "option":e=eb(a,d);break;case "select":a._wrapperState={wasMultiple:!!d.multiple};e=m({},d,{value:void 0});G("invalid",a);break;case "textarea":hb(a,d);e=
gb(a,d);G("invalid",a);break;default:e=d}vb(c,e);var h=e;for(f in h)if(h.hasOwnProperty(f)){var k=h[f];"style"===f?tb(a,k):"dangerouslySetInnerHTML"===f?(k=k?k.__html:void 0,null!=k&&ob(a,k)):"children"===f?"string"===typeof k?("textarea"!==c||""!==k)&&pb(a,k):"number"===typeof k&&pb(a,""+k):"suppressContentEditableWarning"!==f&&"suppressHydrationWarning"!==f&&"autoFocus"!==f&&(ca.hasOwnProperty(f)?null!=k&&"onScroll"===f&&G("scroll",a):null!=k&&qa(a,f,k,g))}switch(c){case "input":Va(a);cb(a,d,!1);
break;case "textarea":Va(a);jb(a);break;case "option":null!=d.value&&a.setAttribute("value",""+Sa(d.value));break;case "select":a.multiple=!!d.multiple;f=d.value;null!=f?fb(a,!!d.multiple,f,!1):null!=d.defaultValue&&fb(a,!!d.multiple,d.defaultValue,!0);break;default:"function"===typeof e.onClick&&(a.onclick=jf)}mf(c,d)&&(b.flags|=4)}null!==b.ref&&(b.flags|=128)}return null;case 6:if(a&&null!=b.stateNode)Ei(a,b,a.memoizedProps,d);else{if("string"!==typeof d&&null===b.stateNode)throw Error(y(166));
c=dh(ch.current);dh(ah.current);rh(b)?(d=b.stateNode,c=b.memoizedProps,d[wf]=b,d.nodeValue!==c&&(b.flags|=4)):(d=(9===c.nodeType?c:c.ownerDocument).createTextNode(d),d[wf]=b,b.stateNode=d)}return null;case 13:H(P);d=b.memoizedState;if(0!==(b.flags&64))return b.lanes=c,b;d=null!==d;c=!1;null===a?void 0!==b.memoizedProps.fallback&&rh(b):c=null!==a.memoizedState;if(d&&!c&&0!==(b.mode&2))if(null===a&&!0!==b.memoizedProps.unstable_avoidThisFallback||0!==(P.current&1))0===V&&(V=3);else{if(0===V||3===V)V=
4;null===U||0===(Dg&134217727)&&0===(Hi&134217727)||Ii(U,W)}if(d||c)b.flags|=4;return null;case 4:return fh(),Ci(b),null===a&&cf(b.stateNode.containerInfo),null;case 10:return rg(b),null;case 17:return Ff(b.type)&&Gf(),null;case 19:H(P);d=b.memoizedState;if(null===d)return null;f=0!==(b.flags&64);g=d.rendering;if(null===g)if(f)Fi(d,!1);else{if(0!==V||null!==a&&0!==(a.flags&64))for(a=b.child;null!==a;){g=ih(a);if(null!==g){b.flags|=64;Fi(d,!1);f=g.updateQueue;null!==f&&(b.updateQueue=f,b.flags|=4);
null===d.lastEffect&&(b.firstEffect=null);b.lastEffect=d.lastEffect;d=c;for(c=b.child;null!==c;)f=c,a=d,f.flags&=2,f.nextEffect=null,f.firstEffect=null,f.lastEffect=null,g=f.alternate,null===g?(f.childLanes=0,f.lanes=a,f.child=null,f.memoizedProps=null,f.memoizedState=null,f.updateQueue=null,f.dependencies=null,f.stateNode=null):(f.childLanes=g.childLanes,f.lanes=g.lanes,f.child=g.child,f.memoizedProps=g.memoizedProps,f.memoizedState=g.memoizedState,f.updateQueue=g.updateQueue,f.type=g.type,a=g.dependencies,
f.dependencies=null===a?null:{lanes:a.lanes,firstContext:a.firstContext}),c=c.sibling;I(P,P.current&1|2);return b.child}a=a.sibling}null!==d.tail&&O()>Ji&&(b.flags|=64,f=!0,Fi(d,!1),b.lanes=33554432)}else{if(!f)if(a=ih(g),null!==a){if(b.flags|=64,f=!0,c=a.updateQueue,null!==c&&(b.updateQueue=c,b.flags|=4),Fi(d,!0),null===d.tail&&"hidden"===d.tailMode&&!g.alternate&&!lh)return b=b.lastEffect=d.lastEffect,null!==b&&(b.nextEffect=null),null}else 2*O()-d.renderingStartTime>Ji&&1073741824!==c&&(b.flags|=
64,f=!0,Fi(d,!1),b.lanes=33554432);d.isBackwards?(g.sibling=b.child,b.child=g):(c=d.last,null!==c?c.sibling=g:b.child=g,d.last=g)}return null!==d.tail?(c=d.tail,d.rendering=c,d.tail=c.sibling,d.lastEffect=b.lastEffect,d.renderingStartTime=O(),c.sibling=null,b=P.current,I(P,f?b&1|2:b&1),c):null;case 23:case 24:return Ki(),null!==a&&null!==a.memoizedState!==(null!==b.memoizedState)&&"unstable-defer-without-hiding"!==d.mode&&(b.flags|=4),null}throw Error(y(156,b.tag));}
function Li(a){switch(a.tag){case 1:Ff(a.type)&&Gf();var b=a.flags;return b&4096?(a.flags=b&-4097|64,a):null;case 3:fh();H(N);H(M);uh();b=a.flags;if(0!==(b&64))throw Error(y(285));a.flags=b&-4097|64;return a;case 5:return hh(a),null;case 13:return H(P),b=a.flags,b&4096?(a.flags=b&-4097|64,a):null;case 19:return H(P),null;case 4:return fh(),null;case 10:return rg(a),null;case 23:case 24:return Ki(),null;default:return null}}
function Mi(a,b){try{var c="",d=b;do c+=Qa(d),d=d.return;while(d);var e=c}catch(f){e="\nError generating stack: "+f.message+"\n"+f.stack}return{value:a,source:b,stack:e}}function Ni(a,b){try{console.error(b.value)}catch(c){setTimeout(function(){throw c;})}}var Oi="function"===typeof WeakMap?WeakMap:Map;function Pi(a,b,c){c=zg(-1,c);c.tag=3;c.payload={element:null};var d=b.value;c.callback=function(){Qi||(Qi=!0,Ri=d);Ni(a,b)};return c}
function Si(a,b,c){c=zg(-1,c);c.tag=3;var d=a.type.getDerivedStateFromError;if("function"===typeof d){var e=b.value;c.payload=function(){Ni(a,b);return d(e)}}var f=a.stateNode;null!==f&&"function"===typeof f.componentDidCatch&&(c.callback=function(){"function"!==typeof d&&(null===Ti?Ti=new Set([this]):Ti.add(this),Ni(a,b));var c=b.stack;this.componentDidCatch(b.value,{componentStack:null!==c?c:""})});return c}var Ui="function"===typeof WeakSet?WeakSet:Set;
function Vi(a){var b=a.ref;if(null!==b)if("function"===typeof b)try{b(null)}catch(c){Wi(a,c)}else b.current=null}function Xi(a,b){switch(b.tag){case 0:case 11:case 15:case 22:return;case 1:if(b.flags&256&&null!==a){var c=a.memoizedProps,d=a.memoizedState;a=b.stateNode;b=a.getSnapshotBeforeUpdate(b.elementType===b.type?c:lg(b.type,c),d);a.__reactInternalSnapshotBeforeUpdate=b}return;case 3:b.flags&256&&qf(b.stateNode.containerInfo);return;case 5:case 6:case 4:case 17:return}throw Error(y(163));}
function Yi(a,b,c){switch(c.tag){case 0:case 11:case 15:case 22:b=c.updateQueue;b=null!==b?b.lastEffect:null;if(null!==b){a=b=b.next;do{if(3===(a.tag&3)){var d=a.create;a.destroy=d()}a=a.next}while(a!==b)}b=c.updateQueue;b=null!==b?b.lastEffect:null;if(null!==b){a=b=b.next;do{var e=a;d=e.next;e=e.tag;0!==(e&4)&&0!==(e&1)&&(Zi(c,a),$i(c,a));a=d}while(a!==b)}return;case 1:a=c.stateNode;c.flags&4&&(null===b?a.componentDidMount():(d=c.elementType===c.type?b.memoizedProps:lg(c.type,b.memoizedProps),a.componentDidUpdate(d,
b.memoizedState,a.__reactInternalSnapshotBeforeUpdate)));b=c.updateQueue;null!==b&&Eg(c,b,a);return;case 3:b=c.updateQueue;if(null!==b){a=null;if(null!==c.child)switch(c.child.tag){case 5:a=c.child.stateNode;break;case 1:a=c.child.stateNode}Eg(c,b,a)}return;case 5:a=c.stateNode;null===b&&c.flags&4&&mf(c.type,c.memoizedProps)&&a.focus();return;case 6:return;case 4:return;case 12:return;case 13:null===c.memoizedState&&(c=c.alternate,null!==c&&(c=c.memoizedState,null!==c&&(c=c.dehydrated,null!==c&&Cc(c))));
return;case 19:case 17:case 20:case 21:case 23:case 24:return}throw Error(y(163));}
function aj(a,b){for(var c=a;;){if(5===c.tag){var d=c.stateNode;if(b)d=d.style,"function"===typeof d.setProperty?d.setProperty("display","none","important"):d.display="none";else{d=c.stateNode;var e=c.memoizedProps.style;e=void 0!==e&&null!==e&&e.hasOwnProperty("display")?e.display:null;d.style.display=sb("display",e)}}else if(6===c.tag)c.stateNode.nodeValue=b?"":c.memoizedProps;else if((23!==c.tag&&24!==c.tag||null===c.memoizedState||c===a)&&null!==c.child){c.child.return=c;c=c.child;continue}if(c===
a)break;for(;null===c.sibling;){if(null===c.return||c.return===a)return;c=c.return}c.sibling.return=c.return;c=c.sibling}}
function bj(a,b){if(Mf&&"function"===typeof Mf.onCommitFiberUnmount)try{Mf.onCommitFiberUnmount(Lf,b)}catch(f){}switch(b.tag){case 0:case 11:case 14:case 15:case 22:a=b.updateQueue;if(null!==a&&(a=a.lastEffect,null!==a)){var c=a=a.next;do{var d=c,e=d.destroy;d=d.tag;if(void 0!==e)if(0!==(d&4))Zi(b,c);else{d=b;try{e()}catch(f){Wi(d,f)}}c=c.next}while(c!==a)}break;case 1:Vi(b);a=b.stateNode;if("function"===typeof a.componentWillUnmount)try{a.props=b.memoizedProps,a.state=b.memoizedState,a.componentWillUnmount()}catch(f){Wi(b,
f)}break;case 5:Vi(b);break;case 4:cj(a,b)}}function dj(a){a.alternate=null;a.child=null;a.dependencies=null;a.firstEffect=null;a.lastEffect=null;a.memoizedProps=null;a.memoizedState=null;a.pendingProps=null;a.return=null;a.updateQueue=null}function ej(a){return 5===a.tag||3===a.tag||4===a.tag}
function fj(a){a:{for(var b=a.return;null!==b;){if(ej(b))break a;b=b.return}throw Error(y(160));}var c=b;b=c.stateNode;switch(c.tag){case 5:var d=!1;break;case 3:b=b.containerInfo;d=!0;break;case 4:b=b.containerInfo;d=!0;break;default:throw Error(y(161));}c.flags&16&&(pb(b,""),c.flags&=-17);a:b:for(c=a;;){for(;null===c.sibling;){if(null===c.return||ej(c.return)){c=null;break a}c=c.return}c.sibling.return=c.return;for(c=c.sibling;5!==c.tag&&6!==c.tag&&18!==c.tag;){if(c.flags&2)continue b;if(null===
c.child||4===c.tag)continue b;else c.child.return=c,c=c.child}if(!(c.flags&2)){c=c.stateNode;break a}}d?gj(a,c,b):hj(a,c,b)}
function gj(a,b,c){var d=a.tag,e=5===d||6===d;if(e)a=e?a.stateNode:a.stateNode.instance,b?8===c.nodeType?c.parentNode.insertBefore(a,b):c.insertBefore(a,b):(8===c.nodeType?(b=c.parentNode,b.insertBefore(a,c)):(b=c,b.appendChild(a)),c=c._reactRootContainer,null!==c&&void 0!==c||null!==b.onclick||(b.onclick=jf));else if(4!==d&&(a=a.child,null!==a))for(gj(a,b,c),a=a.sibling;null!==a;)gj(a,b,c),a=a.sibling}
function hj(a,b,c){var d=a.tag,e=5===d||6===d;if(e)a=e?a.stateNode:a.stateNode.instance,b?c.insertBefore(a,b):c.appendChild(a);else if(4!==d&&(a=a.child,null!==a))for(hj(a,b,c),a=a.sibling;null!==a;)hj(a,b,c),a=a.sibling}
function cj(a,b){for(var c=b,d=!1,e,f;;){if(!d){d=c.return;a:for(;;){if(null===d)throw Error(y(160));e=d.stateNode;switch(d.tag){case 5:f=!1;break a;case 3:e=e.containerInfo;f=!0;break a;case 4:e=e.containerInfo;f=!0;break a}d=d.return}d=!0}if(5===c.tag||6===c.tag){a:for(var g=a,h=c,k=h;;)if(bj(g,k),null!==k.child&&4!==k.tag)k.child.return=k,k=k.child;else{if(k===h)break a;for(;null===k.sibling;){if(null===k.return||k.return===h)break a;k=k.return}k.sibling.return=k.return;k=k.sibling}f?(g=e,h=c.stateNode,
8===g.nodeType?g.parentNode.removeChild(h):g.removeChild(h)):e.removeChild(c.stateNode)}else if(4===c.tag){if(null!==c.child){e=c.stateNode.containerInfo;f=!0;c.child.return=c;c=c.child;continue}}else if(bj(a,c),null!==c.child){c.child.return=c;c=c.child;continue}if(c===b)break;for(;null===c.sibling;){if(null===c.return||c.return===b)return;c=c.return;4===c.tag&&(d=!1)}c.sibling.return=c.return;c=c.sibling}}
function ij(a,b){switch(b.tag){case 0:case 11:case 14:case 15:case 22:var c=b.updateQueue;c=null!==c?c.lastEffect:null;if(null!==c){var d=c=c.next;do 3===(d.tag&3)&&(a=d.destroy,d.destroy=void 0,void 0!==a&&a()),d=d.next;while(d!==c)}return;case 1:return;case 5:c=b.stateNode;if(null!=c){d=b.memoizedProps;var e=null!==a?a.memoizedProps:d;a=b.type;var f=b.updateQueue;b.updateQueue=null;if(null!==f){c[xf]=d;"input"===a&&"radio"===d.type&&null!=d.name&&$a(c,d);wb(a,e);b=wb(a,d);for(e=0;e<f.length;e+=
2){var g=f[e],h=f[e+1];"style"===g?tb(c,h):"dangerouslySetInnerHTML"===g?ob(c,h):"children"===g?pb(c,h):qa(c,g,h,b)}switch(a){case "input":ab(c,d);break;case "textarea":ib(c,d);break;case "select":a=c._wrapperState.wasMultiple,c._wrapperState.wasMultiple=!!d.multiple,f=d.value,null!=f?fb(c,!!d.multiple,f,!1):a!==!!d.multiple&&(null!=d.defaultValue?fb(c,!!d.multiple,d.defaultValue,!0):fb(c,!!d.multiple,d.multiple?[]:"",!1))}}}return;case 6:if(null===b.stateNode)throw Error(y(162));b.stateNode.nodeValue=
b.memoizedProps;return;case 3:c=b.stateNode;c.hydrate&&(c.hydrate=!1,Cc(c.containerInfo));return;case 12:return;case 13:null!==b.memoizedState&&(jj=O(),aj(b.child,!0));kj(b);return;case 19:kj(b);return;case 17:return;case 23:case 24:aj(b,null!==b.memoizedState);return}throw Error(y(163));}function kj(a){var b=a.updateQueue;if(null!==b){a.updateQueue=null;var c=a.stateNode;null===c&&(c=a.stateNode=new Ui);b.forEach(function(b){var d=lj.bind(null,a,b);c.has(b)||(c.add(b),b.then(d,d))})}}
function mj(a,b){return null!==a&&(a=a.memoizedState,null===a||null!==a.dehydrated)?(b=b.memoizedState,null!==b&&null===b.dehydrated):!1}var nj=Math.ceil,oj=ra.ReactCurrentDispatcher,pj=ra.ReactCurrentOwner,X=0,U=null,Y=null,W=0,qj=0,rj=Bf(0),V=0,sj=null,tj=0,Dg=0,Hi=0,uj=0,vj=null,jj=0,Ji=Infinity;function wj(){Ji=O()+500}var Z=null,Qi=!1,Ri=null,Ti=null,xj=!1,yj=null,zj=90,Aj=[],Bj=[],Cj=null,Dj=0,Ej=null,Fj=-1,Gj=0,Hj=0,Ij=null,Jj=!1;function Hg(){return 0!==(X&48)?O():-1!==Fj?Fj:Fj=O()}
function Ig(a){a=a.mode;if(0===(a&2))return 1;if(0===(a&4))return 99===eg()?1:2;0===Gj&&(Gj=tj);if(0!==kg.transition){0!==Hj&&(Hj=null!==vj?vj.pendingLanes:0);a=Gj;var b=4186112&~Hj;b&=-b;0===b&&(a=4186112&~a,b=a&-a,0===b&&(b=8192));return b}a=eg();0!==(X&4)&&98===a?a=Xc(12,Gj):(a=Sc(a),a=Xc(a,Gj));return a}
function Jg(a,b,c){if(50<Dj)throw Dj=0,Ej=null,Error(y(185));a=Kj(a,b);if(null===a)return null;$c(a,b,c);a===U&&(Hi|=b,4===V&&Ii(a,W));var d=eg();1===b?0!==(X&8)&&0===(X&48)?Lj(a):(Mj(a,c),0===X&&(wj(),ig())):(0===(X&4)||98!==d&&99!==d||(null===Cj?Cj=new Set([a]):Cj.add(a)),Mj(a,c));vj=a}function Kj(a,b){a.lanes|=b;var c=a.alternate;null!==c&&(c.lanes|=b);c=a;for(a=a.return;null!==a;)a.childLanes|=b,c=a.alternate,null!==c&&(c.childLanes|=b),c=a,a=a.return;return 3===c.tag?c.stateNode:null}
function Mj(a,b){for(var c=a.callbackNode,d=a.suspendedLanes,e=a.pingedLanes,f=a.expirationTimes,g=a.pendingLanes;0<g;){var h=31-Vc(g),k=1<<h,l=f[h];if(-1===l){if(0===(k&d)||0!==(k&e)){l=b;Rc(k);var n=F;f[h]=10<=n?l+250:6<=n?l+5E3:-1}}else l<=b&&(a.expiredLanes|=k);g&=~k}d=Uc(a,a===U?W:0);b=F;if(0===d)null!==c&&(c!==Zf&&Pf(c),a.callbackNode=null,a.callbackPriority=0);else{if(null!==c){if(a.callbackPriority===b)return;c!==Zf&&Pf(c)}15===b?(c=Lj.bind(null,a),null===ag?(ag=[c],bg=Of(Uf,jg)):ag.push(c),
c=Zf):14===b?c=hg(99,Lj.bind(null,a)):(c=Tc(b),c=hg(c,Nj.bind(null,a)));a.callbackPriority=b;a.callbackNode=c}}
function Nj(a){Fj=-1;Hj=Gj=0;if(0!==(X&48))throw Error(y(327));var b=a.callbackNode;if(Oj()&&a.callbackNode!==b)return null;var c=Uc(a,a===U?W:0);if(0===c)return null;var d=c;var e=X;X|=16;var f=Pj();if(U!==a||W!==d)wj(),Qj(a,d);do try{Rj();break}catch(h){Sj(a,h)}while(1);qg();oj.current=f;X=e;null!==Y?d=0:(U=null,W=0,d=V);if(0!==(tj&Hi))Qj(a,0);else if(0!==d){2===d&&(X|=64,a.hydrate&&(a.hydrate=!1,qf(a.containerInfo)),c=Wc(a),0!==c&&(d=Tj(a,c)));if(1===d)throw b=sj,Qj(a,0),Ii(a,c),Mj(a,O()),b;a.finishedWork=
a.current.alternate;a.finishedLanes=c;switch(d){case 0:case 1:throw Error(y(345));case 2:Uj(a);break;case 3:Ii(a,c);if((c&62914560)===c&&(d=jj+500-O(),10<d)){if(0!==Uc(a,0))break;e=a.suspendedLanes;if((e&c)!==c){Hg();a.pingedLanes|=a.suspendedLanes&e;break}a.timeoutHandle=of(Uj.bind(null,a),d);break}Uj(a);break;case 4:Ii(a,c);if((c&4186112)===c)break;d=a.eventTimes;for(e=-1;0<c;){var g=31-Vc(c);f=1<<g;g=d[g];g>e&&(e=g);c&=~f}c=e;c=O()-c;c=(120>c?120:480>c?480:1080>c?1080:1920>c?1920:3E3>c?3E3:4320>
c?4320:1960*nj(c/1960))-c;if(10<c){a.timeoutHandle=of(Uj.bind(null,a),c);break}Uj(a);break;case 5:Uj(a);break;default:throw Error(y(329));}}Mj(a,O());return a.callbackNode===b?Nj.bind(null,a):null}function Ii(a,b){b&=~uj;b&=~Hi;a.suspendedLanes|=b;a.pingedLanes&=~b;for(a=a.expirationTimes;0<b;){var c=31-Vc(b),d=1<<c;a[c]=-1;b&=~d}}
function Lj(a){if(0!==(X&48))throw Error(y(327));Oj();if(a===U&&0!==(a.expiredLanes&W)){var b=W;var c=Tj(a,b);0!==(tj&Hi)&&(b=Uc(a,b),c=Tj(a,b))}else b=Uc(a,0),c=Tj(a,b);0!==a.tag&&2===c&&(X|=64,a.hydrate&&(a.hydrate=!1,qf(a.containerInfo)),b=Wc(a),0!==b&&(c=Tj(a,b)));if(1===c)throw c=sj,Qj(a,0),Ii(a,b),Mj(a,O()),c;a.finishedWork=a.current.alternate;a.finishedLanes=b;Uj(a);Mj(a,O());return null}
function Vj(){if(null!==Cj){var a=Cj;Cj=null;a.forEach(function(a){a.expiredLanes|=24&a.pendingLanes;Mj(a,O())})}ig()}function Wj(a,b){var c=X;X|=1;try{return a(b)}finally{X=c,0===X&&(wj(),ig())}}function Xj(a,b){var c=X;X&=-2;X|=8;try{return a(b)}finally{X=c,0===X&&(wj(),ig())}}function ni(a,b){I(rj,qj);qj|=b;tj|=b}function Ki(){qj=rj.current;H(rj)}
function Qj(a,b){a.finishedWork=null;a.finishedLanes=0;var c=a.timeoutHandle;-1!==c&&(a.timeoutHandle=-1,pf(c));if(null!==Y)for(c=Y.return;null!==c;){var d=c;switch(d.tag){case 1:d=d.type.childContextTypes;null!==d&&void 0!==d&&Gf();break;case 3:fh();H(N);H(M);uh();break;case 5:hh(d);break;case 4:fh();break;case 13:H(P);break;case 19:H(P);break;case 10:rg(d);break;case 23:case 24:Ki()}c=c.return}U=a;Y=Tg(a.current,null);W=qj=tj=b;V=0;sj=null;uj=Hi=Dg=0}
function Sj(a,b){do{var c=Y;try{qg();vh.current=Gh;if(yh){for(var d=R.memoizedState;null!==d;){var e=d.queue;null!==e&&(e.pending=null);d=d.next}yh=!1}xh=0;T=S=R=null;zh=!1;pj.current=null;if(null===c||null===c.return){V=1;sj=b;Y=null;break}a:{var f=a,g=c.return,h=c,k=b;b=W;h.flags|=2048;h.firstEffect=h.lastEffect=null;if(null!==k&&"object"===typeof k&&"function"===typeof k.then){var l=k;if(0===(h.mode&2)){var n=h.alternate;n?(h.updateQueue=n.updateQueue,h.memoizedState=n.memoizedState,h.lanes=n.lanes):
(h.updateQueue=null,h.memoizedState=null)}var A=0!==(P.current&1),p=g;do{var C;if(C=13===p.tag){var x=p.memoizedState;if(null!==x)C=null!==x.dehydrated?!0:!1;else{var w=p.memoizedProps;C=void 0===w.fallback?!1:!0!==w.unstable_avoidThisFallback?!0:A?!1:!0}}if(C){var z=p.updateQueue;if(null===z){var u=new Set;u.add(l);p.updateQueue=u}else z.add(l);if(0===(p.mode&2)){p.flags|=64;h.flags|=16384;h.flags&=-2981;if(1===h.tag)if(null===h.alternate)h.tag=17;else{var t=zg(-1,1);t.tag=2;Ag(h,t)}h.lanes|=1;break a}k=
void 0;h=b;var q=f.pingCache;null===q?(q=f.pingCache=new Oi,k=new Set,q.set(l,k)):(k=q.get(l),void 0===k&&(k=new Set,q.set(l,k)));if(!k.has(h)){k.add(h);var v=Yj.bind(null,f,l,h);l.then(v,v)}p.flags|=4096;p.lanes=b;break a}p=p.return}while(null!==p);k=Error((Ra(h.type)||"A React component")+" suspended while rendering, but no fallback UI was specified.\n\nAdd a <Suspense fallback=...> component higher in the tree to provide a loading indicator or placeholder to display.")}5!==V&&(V=2);k=Mi(k,h);p=
g;do{switch(p.tag){case 3:f=k;p.flags|=4096;b&=-b;p.lanes|=b;var J=Pi(p,f,b);Bg(p,J);break a;case 1:f=k;var K=p.type,Q=p.stateNode;if(0===(p.flags&64)&&("function"===typeof K.getDerivedStateFromError||null!==Q&&"function"===typeof Q.componentDidCatch&&(null===Ti||!Ti.has(Q)))){p.flags|=4096;b&=-b;p.lanes|=b;var L=Si(p,f,b);Bg(p,L);break a}}p=p.return}while(null!==p)}Zj(c)}catch(va){b=va;Y===c&&null!==c&&(Y=c=c.return);continue}break}while(1)}
function Pj(){var a=oj.current;oj.current=Gh;return null===a?Gh:a}function Tj(a,b){var c=X;X|=16;var d=Pj();U===a&&W===b||Qj(a,b);do try{ak();break}catch(e){Sj(a,e)}while(1);qg();X=c;oj.current=d;if(null!==Y)throw Error(y(261));U=null;W=0;return V}function ak(){for(;null!==Y;)bk(Y)}function Rj(){for(;null!==Y&&!Qf();)bk(Y)}function bk(a){var b=ck(a.alternate,a,qj);a.memoizedProps=a.pendingProps;null===b?Zj(a):Y=b;pj.current=null}
function Zj(a){var b=a;do{var c=b.alternate;a=b.return;if(0===(b.flags&2048)){c=Gi(c,b,qj);if(null!==c){Y=c;return}c=b;if(24!==c.tag&&23!==c.tag||null===c.memoizedState||0!==(qj&1073741824)||0===(c.mode&4)){for(var d=0,e=c.child;null!==e;)d|=e.lanes|e.childLanes,e=e.sibling;c.childLanes=d}null!==a&&0===(a.flags&2048)&&(null===a.firstEffect&&(a.firstEffect=b.firstEffect),null!==b.lastEffect&&(null!==a.lastEffect&&(a.lastEffect.nextEffect=b.firstEffect),a.lastEffect=b.lastEffect),1<b.flags&&(null!==
a.lastEffect?a.lastEffect.nextEffect=b:a.firstEffect=b,a.lastEffect=b))}else{c=Li(b);if(null!==c){c.flags&=2047;Y=c;return}null!==a&&(a.firstEffect=a.lastEffect=null,a.flags|=2048)}b=b.sibling;if(null!==b){Y=b;return}Y=b=a}while(null!==b);0===V&&(V=5)}function Uj(a){var b=eg();gg(99,dk.bind(null,a,b));return null}
function dk(a,b){do Oj();while(null!==yj);if(0!==(X&48))throw Error(y(327));var c=a.finishedWork;if(null===c)return null;a.finishedWork=null;a.finishedLanes=0;if(c===a.current)throw Error(y(177));a.callbackNode=null;var d=c.lanes|c.childLanes,e=d,f=a.pendingLanes&~e;a.pendingLanes=e;a.suspendedLanes=0;a.pingedLanes=0;a.expiredLanes&=e;a.mutableReadLanes&=e;a.entangledLanes&=e;e=a.entanglements;for(var g=a.eventTimes,h=a.expirationTimes;0<f;){var k=31-Vc(f),l=1<<k;e[k]=0;g[k]=-1;h[k]=-1;f&=~l}null!==
Cj&&0===(d&24)&&Cj.has(a)&&Cj.delete(a);a===U&&(Y=U=null,W=0);1<c.flags?null!==c.lastEffect?(c.lastEffect.nextEffect=c,d=c.firstEffect):d=c:d=c.firstEffect;if(null!==d){e=X;X|=32;pj.current=null;kf=fd;g=Ne();if(Oe(g)){if("selectionStart"in g)h={start:g.selectionStart,end:g.selectionEnd};else a:if(h=(h=g.ownerDocument)&&h.defaultView||window,(l=h.getSelection&&h.getSelection())&&0!==l.rangeCount){h=l.anchorNode;f=l.anchorOffset;k=l.focusNode;l=l.focusOffset;try{h.nodeType,k.nodeType}catch(va){h=null;
break a}var n=0,A=-1,p=-1,C=0,x=0,w=g,z=null;b:for(;;){for(var u;;){w!==h||0!==f&&3!==w.nodeType||(A=n+f);w!==k||0!==l&&3!==w.nodeType||(p=n+l);3===w.nodeType&&(n+=w.nodeValue.length);if(null===(u=w.firstChild))break;z=w;w=u}for(;;){if(w===g)break b;z===h&&++C===f&&(A=n);z===k&&++x===l&&(p=n);if(null!==(u=w.nextSibling))break;w=z;z=w.parentNode}w=u}h=-1===A||-1===p?null:{start:A,end:p}}else h=null;h=h||{start:0,end:0}}else h=null;lf={focusedElem:g,selectionRange:h};fd=!1;Ij=null;Jj=!1;Z=d;do try{ek()}catch(va){if(null===
Z)throw Error(y(330));Wi(Z,va);Z=Z.nextEffect}while(null!==Z);Ij=null;Z=d;do try{for(g=a;null!==Z;){var t=Z.flags;t&16&&pb(Z.stateNode,"");if(t&128){var q=Z.alternate;if(null!==q){var v=q.ref;null!==v&&("function"===typeof v?v(null):v.current=null)}}switch(t&1038){case 2:fj(Z);Z.flags&=-3;break;case 6:fj(Z);Z.flags&=-3;ij(Z.alternate,Z);break;case 1024:Z.flags&=-1025;break;case 1028:Z.flags&=-1025;ij(Z.alternate,Z);break;case 4:ij(Z.alternate,Z);break;case 8:h=Z;cj(g,h);var J=h.alternate;dj(h);null!==
J&&dj(J)}Z=Z.nextEffect}}catch(va){if(null===Z)throw Error(y(330));Wi(Z,va);Z=Z.nextEffect}while(null!==Z);v=lf;q=Ne();t=v.focusedElem;g=v.selectionRange;if(q!==t&&t&&t.ownerDocument&&Me(t.ownerDocument.documentElement,t)){null!==g&&Oe(t)&&(q=g.start,v=g.end,void 0===v&&(v=q),"selectionStart"in t?(t.selectionStart=q,t.selectionEnd=Math.min(v,t.value.length)):(v=(q=t.ownerDocument||document)&&q.defaultView||window,v.getSelection&&(v=v.getSelection(),h=t.textContent.length,J=Math.min(g.start,h),g=void 0===
g.end?J:Math.min(g.end,h),!v.extend&&J>g&&(h=g,g=J,J=h),h=Le(t,J),f=Le(t,g),h&&f&&(1!==v.rangeCount||v.anchorNode!==h.node||v.anchorOffset!==h.offset||v.focusNode!==f.node||v.focusOffset!==f.offset)&&(q=q.createRange(),q.setStart(h.node,h.offset),v.removeAllRanges(),J>g?(v.addRange(q),v.extend(f.node,f.offset)):(q.setEnd(f.node,f.offset),v.addRange(q))))));q=[];for(v=t;v=v.parentNode;)1===v.nodeType&&q.push({element:v,left:v.scrollLeft,top:v.scrollTop});"function"===typeof t.focus&&t.focus();for(t=
0;t<q.length;t++)v=q[t],v.element.scrollLeft=v.left,v.element.scrollTop=v.top}fd=!!kf;lf=kf=null;a.current=c;Z=d;do try{for(t=a;null!==Z;){var K=Z.flags;K&36&&Yi(t,Z.alternate,Z);if(K&128){q=void 0;var Q=Z.ref;if(null!==Q){var L=Z.stateNode;switch(Z.tag){case 5:q=L;break;default:q=L}"function"===typeof Q?Q(q):Q.current=q}}Z=Z.nextEffect}}catch(va){if(null===Z)throw Error(y(330));Wi(Z,va);Z=Z.nextEffect}while(null!==Z);Z=null;$f();X=e}else a.current=c;if(xj)xj=!1,yj=a,zj=b;else for(Z=d;null!==Z;)b=
Z.nextEffect,Z.nextEffect=null,Z.flags&8&&(K=Z,K.sibling=null,K.stateNode=null),Z=b;d=a.pendingLanes;0===d&&(Ti=null);1===d?a===Ej?Dj++:(Dj=0,Ej=a):Dj=0;c=c.stateNode;if(Mf&&"function"===typeof Mf.onCommitFiberRoot)try{Mf.onCommitFiberRoot(Lf,c,void 0,64===(c.current.flags&64))}catch(va){}Mj(a,O());if(Qi)throw Qi=!1,a=Ri,Ri=null,a;if(0!==(X&8))return null;ig();return null}
function ek(){for(;null!==Z;){var a=Z.alternate;Jj||null===Ij||(0!==(Z.flags&8)?dc(Z,Ij)&&(Jj=!0):13===Z.tag&&mj(a,Z)&&dc(Z,Ij)&&(Jj=!0));var b=Z.flags;0!==(b&256)&&Xi(a,Z);0===(b&512)||xj||(xj=!0,hg(97,function(){Oj();return null}));Z=Z.nextEffect}}function Oj(){if(90!==zj){var a=97<zj?97:zj;zj=90;return gg(a,fk)}return!1}function $i(a,b){Aj.push(b,a);xj||(xj=!0,hg(97,function(){Oj();return null}))}function Zi(a,b){Bj.push(b,a);xj||(xj=!0,hg(97,function(){Oj();return null}))}
function fk(){if(null===yj)return!1;var a=yj;yj=null;if(0!==(X&48))throw Error(y(331));var b=X;X|=32;var c=Bj;Bj=[];for(var d=0;d<c.length;d+=2){var e=c[d],f=c[d+1],g=e.destroy;e.destroy=void 0;if("function"===typeof g)try{g()}catch(k){if(null===f)throw Error(y(330));Wi(f,k)}}c=Aj;Aj=[];for(d=0;d<c.length;d+=2){e=c[d];f=c[d+1];try{var h=e.create;e.destroy=h()}catch(k){if(null===f)throw Error(y(330));Wi(f,k)}}for(h=a.current.firstEffect;null!==h;)a=h.nextEffect,h.nextEffect=null,h.flags&8&&(h.sibling=
null,h.stateNode=null),h=a;X=b;ig();return!0}function gk(a,b,c){b=Mi(c,b);b=Pi(a,b,1);Ag(a,b);b=Hg();a=Kj(a,1);null!==a&&($c(a,1,b),Mj(a,b))}
function Wi(a,b){if(3===a.tag)gk(a,a,b);else for(var c=a.return;null!==c;){if(3===c.tag){gk(c,a,b);break}else if(1===c.tag){var d=c.stateNode;if("function"===typeof c.type.getDerivedStateFromError||"function"===typeof d.componentDidCatch&&(null===Ti||!Ti.has(d))){a=Mi(b,a);var e=Si(c,a,1);Ag(c,e);e=Hg();c=Kj(c,1);if(null!==c)$c(c,1,e),Mj(c,e);else if("function"===typeof d.componentDidCatch&&(null===Ti||!Ti.has(d)))try{d.componentDidCatch(b,a)}catch(f){}break}}c=c.return}}
function Yj(a,b,c){var d=a.pingCache;null!==d&&d.delete(b);b=Hg();a.pingedLanes|=a.suspendedLanes&c;U===a&&(W&c)===c&&(4===V||3===V&&(W&62914560)===W&&500>O()-jj?Qj(a,0):uj|=c);Mj(a,b)}function lj(a,b){var c=a.stateNode;null!==c&&c.delete(b);b=0;0===b&&(b=a.mode,0===(b&2)?b=1:0===(b&4)?b=99===eg()?1:2:(0===Gj&&(Gj=tj),b=Yc(62914560&~Gj),0===b&&(b=4194304)));c=Hg();a=Kj(a,b);null!==a&&($c(a,b,c),Mj(a,c))}var ck;
ck=function(a,b,c){var d=b.lanes;if(null!==a)if(a.memoizedProps!==b.pendingProps||N.current)ug=!0;else if(0!==(c&d))ug=0!==(a.flags&16384)?!0:!1;else{ug=!1;switch(b.tag){case 3:ri(b);sh();break;case 5:gh(b);break;case 1:Ff(b.type)&&Jf(b);break;case 4:eh(b,b.stateNode.containerInfo);break;case 10:d=b.memoizedProps.value;var e=b.type._context;I(mg,e._currentValue);e._currentValue=d;break;case 13:if(null!==b.memoizedState){if(0!==(c&b.child.childLanes))return ti(a,b,c);I(P,P.current&1);b=hi(a,b,c);return null!==
b?b.sibling:null}I(P,P.current&1);break;case 19:d=0!==(c&b.childLanes);if(0!==(a.flags&64)){if(d)return Ai(a,b,c);b.flags|=64}e=b.memoizedState;null!==e&&(e.rendering=null,e.tail=null,e.lastEffect=null);I(P,P.current);if(d)break;else return null;case 23:case 24:return b.lanes=0,mi(a,b,c)}return hi(a,b,c)}else ug=!1;b.lanes=0;switch(b.tag){case 2:d=b.type;null!==a&&(a.alternate=null,b.alternate=null,b.flags|=2);a=b.pendingProps;e=Ef(b,M.current);tg(b,c);e=Ch(null,b,d,a,e,c);b.flags|=1;if("object"===
typeof e&&null!==e&&"function"===typeof e.render&&void 0===e.$$typeof){b.tag=1;b.memoizedState=null;b.updateQueue=null;if(Ff(d)){var f=!0;Jf(b)}else f=!1;b.memoizedState=null!==e.state&&void 0!==e.state?e.state:null;xg(b);var g=d.getDerivedStateFromProps;"function"===typeof g&&Gg(b,d,g,a);e.updater=Kg;b.stateNode=e;e._reactInternals=b;Og(b,d,a,c);b=qi(null,b,d,!0,f,c)}else b.tag=0,fi(null,b,e,c),b=b.child;return b;case 16:e=b.elementType;a:{null!==a&&(a.alternate=null,b.alternate=null,b.flags|=2);
a=b.pendingProps;f=e._init;e=f(e._payload);b.type=e;f=b.tag=hk(e);a=lg(e,a);switch(f){case 0:b=li(null,b,e,a,c);break a;case 1:b=pi(null,b,e,a,c);break a;case 11:b=gi(null,b,e,a,c);break a;case 14:b=ii(null,b,e,lg(e.type,a),d,c);break a}throw Error(y(306,e,""));}return b;case 0:return d=b.type,e=b.pendingProps,e=b.elementType===d?e:lg(d,e),li(a,b,d,e,c);case 1:return d=b.type,e=b.pendingProps,e=b.elementType===d?e:lg(d,e),pi(a,b,d,e,c);case 3:ri(b);d=b.updateQueue;if(null===a||null===d)throw Error(y(282));
d=b.pendingProps;e=b.memoizedState;e=null!==e?e.element:null;yg(a,b);Cg(b,d,null,c);d=b.memoizedState.element;if(d===e)sh(),b=hi(a,b,c);else{e=b.stateNode;if(f=e.hydrate)kh=rf(b.stateNode.containerInfo.firstChild),jh=b,f=lh=!0;if(f){a=e.mutableSourceEagerHydrationData;if(null!=a)for(e=0;e<a.length;e+=2)f=a[e],f._workInProgressVersionPrimary=a[e+1],th.push(f);c=Zg(b,null,d,c);for(b.child=c;c;)c.flags=c.flags&-3|1024,c=c.sibling}else fi(a,b,d,c),sh();b=b.child}return b;case 5:return gh(b),null===a&&
ph(b),d=b.type,e=b.pendingProps,f=null!==a?a.memoizedProps:null,g=e.children,nf(d,e)?g=null:null!==f&&nf(d,f)&&(b.flags|=16),oi(a,b),fi(a,b,g,c),b.child;case 6:return null===a&&ph(b),null;case 13:return ti(a,b,c);case 4:return eh(b,b.stateNode.containerInfo),d=b.pendingProps,null===a?b.child=Yg(b,null,d,c):fi(a,b,d,c),b.child;case 11:return d=b.type,e=b.pendingProps,e=b.elementType===d?e:lg(d,e),gi(a,b,d,e,c);case 7:return fi(a,b,b.pendingProps,c),b.child;case 8:return fi(a,b,b.pendingProps.children,
c),b.child;case 12:return fi(a,b,b.pendingProps.children,c),b.child;case 10:a:{d=b.type._context;e=b.pendingProps;g=b.memoizedProps;f=e.value;var h=b.type._context;I(mg,h._currentValue);h._currentValue=f;if(null!==g)if(h=g.value,f=He(h,f)?0:("function"===typeof d._calculateChangedBits?d._calculateChangedBits(h,f):1073741823)|0,0===f){if(g.children===e.children&&!N.current){b=hi(a,b,c);break a}}else for(h=b.child,null!==h&&(h.return=b);null!==h;){var k=h.dependencies;if(null!==k){g=h.child;for(var l=
k.firstContext;null!==l;){if(l.context===d&&0!==(l.observedBits&f)){1===h.tag&&(l=zg(-1,c&-c),l.tag=2,Ag(h,l));h.lanes|=c;l=h.alternate;null!==l&&(l.lanes|=c);sg(h.return,c);k.lanes|=c;break}l=l.next}}else g=10===h.tag?h.type===b.type?null:h.child:h.child;if(null!==g)g.return=h;else for(g=h;null!==g;){if(g===b){g=null;break}h=g.sibling;if(null!==h){h.return=g.return;g=h;break}g=g.return}h=g}fi(a,b,e.children,c);b=b.child}return b;case 9:return e=b.type,f=b.pendingProps,d=f.children,tg(b,c),e=vg(e,
f.unstable_observedBits),d=d(e),b.flags|=1,fi(a,b,d,c),b.child;case 14:return e=b.type,f=lg(e,b.pendingProps),f=lg(e.type,f),ii(a,b,e,f,d,c);case 15:return ki(a,b,b.type,b.pendingProps,d,c);case 17:return d=b.type,e=b.pendingProps,e=b.elementType===d?e:lg(d,e),null!==a&&(a.alternate=null,b.alternate=null,b.flags|=2),b.tag=1,Ff(d)?(a=!0,Jf(b)):a=!1,tg(b,c),Mg(b,d,e),Og(b,d,e,c),qi(null,b,d,!0,a,c);case 19:return Ai(a,b,c);case 23:return mi(a,b,c);case 24:return mi(a,b,c)}throw Error(y(156,b.tag));
};function ik(a,b,c,d){this.tag=a;this.key=c;this.sibling=this.child=this.return=this.stateNode=this.type=this.elementType=null;this.index=0;this.ref=null;this.pendingProps=b;this.dependencies=this.memoizedState=this.updateQueue=this.memoizedProps=null;this.mode=d;this.flags=0;this.lastEffect=this.firstEffect=this.nextEffect=null;this.childLanes=this.lanes=0;this.alternate=null}function nh(a,b,c,d){return new ik(a,b,c,d)}function ji(a){a=a.prototype;return!(!a||!a.isReactComponent)}
function hk(a){if("function"===typeof a)return ji(a)?1:0;if(void 0!==a&&null!==a){a=a.$$typeof;if(a===Aa)return 11;if(a===Da)return 14}return 2}
function Tg(a,b){var c=a.alternate;null===c?(c=nh(a.tag,b,a.key,a.mode),c.elementType=a.elementType,c.type=a.type,c.stateNode=a.stateNode,c.alternate=a,a.alternate=c):(c.pendingProps=b,c.type=a.type,c.flags=0,c.nextEffect=null,c.firstEffect=null,c.lastEffect=null);c.childLanes=a.childLanes;c.lanes=a.lanes;c.child=a.child;c.memoizedProps=a.memoizedProps;c.memoizedState=a.memoizedState;c.updateQueue=a.updateQueue;b=a.dependencies;c.dependencies=null===b?null:{lanes:b.lanes,firstContext:b.firstContext};
c.sibling=a.sibling;c.index=a.index;c.ref=a.ref;return c}
function Vg(a,b,c,d,e,f){var g=2;d=a;if("function"===typeof a)ji(a)&&(g=1);else if("string"===typeof a)g=5;else a:switch(a){case ua:return Xg(c.children,e,f,b);case Ha:g=8;e|=16;break;case wa:g=8;e|=1;break;case xa:return a=nh(12,c,b,e|8),a.elementType=xa,a.type=xa,a.lanes=f,a;case Ba:return a=nh(13,c,b,e),a.type=Ba,a.elementType=Ba,a.lanes=f,a;case Ca:return a=nh(19,c,b,e),a.elementType=Ca,a.lanes=f,a;case Ia:return vi(c,e,f,b);case Ja:return a=nh(24,c,b,e),a.elementType=Ja,a.lanes=f,a;default:if("object"===
typeof a&&null!==a)switch(a.$$typeof){case ya:g=10;break a;case za:g=9;break a;case Aa:g=11;break a;case Da:g=14;break a;case Ea:g=16;d=null;break a;case Fa:g=22;break a}throw Error(y(130,null==a?a:typeof a,""));}b=nh(g,c,b,e);b.elementType=a;b.type=d;b.lanes=f;return b}function Xg(a,b,c,d){a=nh(7,a,d,b);a.lanes=c;return a}function vi(a,b,c,d){a=nh(23,a,d,b);a.elementType=Ia;a.lanes=c;return a}function Ug(a,b,c){a=nh(6,a,null,b);a.lanes=c;return a}
function Wg(a,b,c){b=nh(4,null!==a.children?a.children:[],a.key,b);b.lanes=c;b.stateNode={containerInfo:a.containerInfo,pendingChildren:null,implementation:a.implementation};return b}
function jk(a,b,c){this.tag=b;this.containerInfo=a;this.finishedWork=this.pingCache=this.current=this.pendingChildren=null;this.timeoutHandle=-1;this.pendingContext=this.context=null;this.hydrate=c;this.callbackNode=null;this.callbackPriority=0;this.eventTimes=Zc(0);this.expirationTimes=Zc(-1);this.entangledLanes=this.finishedLanes=this.mutableReadLanes=this.expiredLanes=this.pingedLanes=this.suspendedLanes=this.pendingLanes=0;this.entanglements=Zc(0);this.mutableSourceEagerHydrationData=null}
function kk(a,b,c){var d=3<arguments.length&&void 0!==arguments[3]?arguments[3]:null;return{$$typeof:ta,key:null==d?null:""+d,children:a,containerInfo:b,implementation:c}}
function lk(a,b,c,d){var e=b.current,f=Hg(),g=Ig(e);a:if(c){c=c._reactInternals;b:{if(Zb(c)!==c||1!==c.tag)throw Error(y(170));var h=c;do{switch(h.tag){case 3:h=h.stateNode.context;break b;case 1:if(Ff(h.type)){h=h.stateNode.__reactInternalMemoizedMergedChildContext;break b}}h=h.return}while(null!==h);throw Error(y(171));}if(1===c.tag){var k=c.type;if(Ff(k)){c=If(c,k,h);break a}}c=h}else c=Cf;null===b.context?b.context=c:b.pendingContext=c;b=zg(f,g);b.payload={element:a};d=void 0===d?null:d;null!==
d&&(b.callback=d);Ag(e,b);Jg(e,g,f);return g}function mk(a){a=a.current;if(!a.child)return null;switch(a.child.tag){case 5:return a.child.stateNode;default:return a.child.stateNode}}function nk(a,b){a=a.memoizedState;if(null!==a&&null!==a.dehydrated){var c=a.retryLane;a.retryLane=0!==c&&c<b?c:b}}function ok(a,b){nk(a,b);(a=a.alternate)&&nk(a,b)}function pk(){return null}
function qk(a,b,c){var d=null!=c&&null!=c.hydrationOptions&&c.hydrationOptions.mutableSources||null;c=new jk(a,b,null!=c&&!0===c.hydrate);b=nh(3,null,null,2===b?7:1===b?3:0);c.current=b;b.stateNode=c;xg(b);a[ff]=c.current;cf(8===a.nodeType?a.parentNode:a);if(d)for(a=0;a<d.length;a++){b=d[a];var e=b._getVersion;e=e(b._source);null==c.mutableSourceEagerHydrationData?c.mutableSourceEagerHydrationData=[b,e]:c.mutableSourceEagerHydrationData.push(b,e)}this._internalRoot=c}
qk.prototype.render=function(a){lk(a,this._internalRoot,null,null)};qk.prototype.unmount=function(){var a=this._internalRoot,b=a.containerInfo;lk(null,a,null,function(){b[ff]=null})};function rk(a){return!(!a||1!==a.nodeType&&9!==a.nodeType&&11!==a.nodeType&&(8!==a.nodeType||" react-mount-point-unstable "!==a.nodeValue))}
function sk(a,b){b||(b=a?9===a.nodeType?a.documentElement:a.firstChild:null,b=!(!b||1!==b.nodeType||!b.hasAttribute("data-reactroot")));if(!b)for(var c;c=a.lastChild;)a.removeChild(c);return new qk(a,0,b?{hydrate:!0}:void 0)}
function tk(a,b,c,d,e){var f=c._reactRootContainer;if(f){var g=f._internalRoot;if("function"===typeof e){var h=e;e=function(){var a=mk(g);h.call(a)}}lk(b,g,a,e)}else{f=c._reactRootContainer=sk(c,d);g=f._internalRoot;if("function"===typeof e){var k=e;e=function(){var a=mk(g);k.call(a)}}Xj(function(){lk(b,g,a,e)})}return mk(g)}ec=function(a){if(13===a.tag){var b=Hg();Jg(a,4,b);ok(a,4)}};fc=function(a){if(13===a.tag){var b=Hg();Jg(a,67108864,b);ok(a,67108864)}};
gc=function(a){if(13===a.tag){var b=Hg(),c=Ig(a);Jg(a,c,b);ok(a,c)}};hc=function(a,b){return b()};
yb=function(a,b,c){switch(b){case "input":ab(a,c);b=c.name;if("radio"===c.type&&null!=b){for(c=a;c.parentNode;)c=c.parentNode;c=c.querySelectorAll("input[name="+JSON.stringify(""+b)+'][type="radio"]');for(b=0;b<c.length;b++){var d=c[b];if(d!==a&&d.form===a.form){var e=Db(d);if(!e)throw Error(y(90));Wa(d);ab(d,e)}}}break;case "textarea":ib(a,c);break;case "select":b=c.value,null!=b&&fb(a,!!c.multiple,b,!1)}};Gb=Wj;
Hb=function(a,b,c,d,e){var f=X;X|=4;try{return gg(98,a.bind(null,b,c,d,e))}finally{X=f,0===X&&(wj(),ig())}};Ib=function(){0===(X&49)&&(Vj(),Oj())};Jb=function(a,b){var c=X;X|=2;try{return a(b)}finally{X=c,0===X&&(wj(),ig())}};function uk(a,b){var c=2<arguments.length&&void 0!==arguments[2]?arguments[2]:null;if(!rk(b))throw Error(y(200));return kk(a,b,null,c)}var vk={Events:[Cb,ue,Db,Eb,Fb,Oj,{current:!1}]},wk={findFiberByHostInstance:wc,bundleType:0,version:"17.0.2",rendererPackageName:"react-dom"};
var xk={bundleType:wk.bundleType,version:wk.version,rendererPackageName:wk.rendererPackageName,rendererConfig:wk.rendererConfig,overrideHookState:null,overrideHookStateDeletePath:null,overrideHookStateRenamePath:null,overrideProps:null,overridePropsDeletePath:null,overridePropsRenamePath:null,setSuspenseHandler:null,scheduleUpdate:null,currentDispatcherRef:ra.ReactCurrentDispatcher,findHostInstanceByFiber:function(a){a=cc(a);return null===a?null:a.stateNode},findFiberByHostInstance:wk.findFiberByHostInstance||
pk,findHostInstancesForRefresh:null,scheduleRefresh:null,scheduleRoot:null,setRefreshHandler:null,getCurrentFiber:null};if("undefined"!==typeof __REACT_DEVTOOLS_GLOBAL_HOOK__){var yk=__REACT_DEVTOOLS_GLOBAL_HOOK__;if(!yk.isDisabled&&yk.supportsFiber)try{Lf=yk.inject(xk),Mf=yk}catch(a){}}exports.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED=vk;exports.createPortal=uk;
exports.findDOMNode=function(a){if(null==a)return null;if(1===a.nodeType)return a;var b=a._reactInternals;if(void 0===b){if("function"===typeof a.render)throw Error(y(188));throw Error(y(268,Object.keys(a)));}a=cc(b);a=null===a?null:a.stateNode;return a};exports.flushSync=function(a,b){var c=X;if(0!==(c&48))return a(b);X|=1;try{if(a)return gg(99,a.bind(null,b))}finally{X=c,ig()}};exports.hydrate=function(a,b,c){if(!rk(b))throw Error(y(200));return tk(null,a,b,!0,c)};
exports.render=function(a,b,c){if(!rk(b))throw Error(y(200));return tk(null,a,b,!1,c)};exports.unmountComponentAtNode=function(a){if(!rk(a))throw Error(y(40));return a._reactRootContainer?(Xj(function(){tk(null,null,a,!1,function(){a._reactRootContainer=null;a[ff]=null})}),!0):!1};exports.unstable_batchedUpdates=Wj;exports.unstable_createPortal=function(a,b){return uk(a,b,2<arguments.length&&void 0!==arguments[2]?arguments[2]:null)};
exports.unstable_renderSubtreeIntoContainer=function(a,b,c,d){if(!rk(c))throw Error(y(200));if(null==a||void 0===a._reactInternals)throw Error(y(38));return tk(a,b,c,!1,d)};exports.version="17.0.2";


/***/ }),
/* 38 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


if (true) {
  module.exports = __webpack_require__(39);
} else {}


/***/ }),
/* 39 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/** @license React v0.20.2
 * scheduler.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var f,g,h,k;if("object"===typeof performance&&"function"===typeof performance.now){var l=performance;exports.unstable_now=function(){return l.now()}}else{var p=Date,q=p.now();exports.unstable_now=function(){return p.now()-q}}
if("undefined"===typeof window||"function"!==typeof MessageChannel){var t=null,u=null,w=function(){if(null!==t)try{var a=exports.unstable_now();t(!0,a);t=null}catch(b){throw setTimeout(w,0),b;}};f=function(a){null!==t?setTimeout(f,0,a):(t=a,setTimeout(w,0))};g=function(a,b){u=setTimeout(a,b)};h=function(){clearTimeout(u)};exports.unstable_shouldYield=function(){return!1};k=exports.unstable_forceFrameRate=function(){}}else{var x=window.setTimeout,y=window.clearTimeout;if("undefined"!==typeof console){var z=
window.cancelAnimationFrame;"function"!==typeof window.requestAnimationFrame&&console.error("This browser doesn't support requestAnimationFrame. Make sure that you load a polyfill in older browsers. https://reactjs.org/link/react-polyfills");"function"!==typeof z&&console.error("This browser doesn't support cancelAnimationFrame. Make sure that you load a polyfill in older browsers. https://reactjs.org/link/react-polyfills")}var A=!1,B=null,C=-1,D=5,E=0;exports.unstable_shouldYield=function(){return exports.unstable_now()>=
E};k=function(){};exports.unstable_forceFrameRate=function(a){0>a||125<a?console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported"):D=0<a?Math.floor(1E3/a):5};var F=new MessageChannel,G=F.port2;F.port1.onmessage=function(){if(null!==B){var a=exports.unstable_now();E=a+D;try{B(!0,a)?G.postMessage(null):(A=!1,B=null)}catch(b){throw G.postMessage(null),b;}}else A=!1};f=function(a){B=a;A||(A=!0,G.postMessage(null))};g=function(a,b){C=
x(function(){a(exports.unstable_now())},b)};h=function(){y(C);C=-1}}function H(a,b){var c=a.length;a.push(b);a:for(;;){var d=c-1>>>1,e=a[d];if(void 0!==e&&0<I(e,b))a[d]=b,a[c]=e,c=d;else break a}}function J(a){a=a[0];return void 0===a?null:a}
function K(a){var b=a[0];if(void 0!==b){var c=a.pop();if(c!==b){a[0]=c;a:for(var d=0,e=a.length;d<e;){var m=2*(d+1)-1,n=a[m],v=m+1,r=a[v];if(void 0!==n&&0>I(n,c))void 0!==r&&0>I(r,n)?(a[d]=r,a[v]=c,d=v):(a[d]=n,a[m]=c,d=m);else if(void 0!==r&&0>I(r,c))a[d]=r,a[v]=c,d=v;else break a}}return b}return null}function I(a,b){var c=a.sortIndex-b.sortIndex;return 0!==c?c:a.id-b.id}var L=[],M=[],N=1,O=null,P=3,Q=!1,R=!1,S=!1;
function T(a){for(var b=J(M);null!==b;){if(null===b.callback)K(M);else if(b.startTime<=a)K(M),b.sortIndex=b.expirationTime,H(L,b);else break;b=J(M)}}function U(a){S=!1;T(a);if(!R)if(null!==J(L))R=!0,f(V);else{var b=J(M);null!==b&&g(U,b.startTime-a)}}
function V(a,b){R=!1;S&&(S=!1,h());Q=!0;var c=P;try{T(b);for(O=J(L);null!==O&&(!(O.expirationTime>b)||a&&!exports.unstable_shouldYield());){var d=O.callback;if("function"===typeof d){O.callback=null;P=O.priorityLevel;var e=d(O.expirationTime<=b);b=exports.unstable_now();"function"===typeof e?O.callback=e:O===J(L)&&K(L);T(b)}else K(L);O=J(L)}if(null!==O)var m=!0;else{var n=J(M);null!==n&&g(U,n.startTime-b);m=!1}return m}finally{O=null,P=c,Q=!1}}var W=k;exports.unstable_IdlePriority=5;
exports.unstable_ImmediatePriority=1;exports.unstable_LowPriority=4;exports.unstable_NormalPriority=3;exports.unstable_Profiling=null;exports.unstable_UserBlockingPriority=2;exports.unstable_cancelCallback=function(a){a.callback=null};exports.unstable_continueExecution=function(){R||Q||(R=!0,f(V))};exports.unstable_getCurrentPriorityLevel=function(){return P};exports.unstable_getFirstCallbackNode=function(){return J(L)};
exports.unstable_next=function(a){switch(P){case 1:case 2:case 3:var b=3;break;default:b=P}var c=P;P=b;try{return a()}finally{P=c}};exports.unstable_pauseExecution=function(){};exports.unstable_requestPaint=W;exports.unstable_runWithPriority=function(a,b){switch(a){case 1:case 2:case 3:case 4:case 5:break;default:a=3}var c=P;P=a;try{return b()}finally{P=c}};
exports.unstable_scheduleCallback=function(a,b,c){var d=exports.unstable_now();"object"===typeof c&&null!==c?(c=c.delay,c="number"===typeof c&&0<c?d+c:d):c=d;switch(a){case 1:var e=-1;break;case 2:e=250;break;case 5:e=1073741823;break;case 4:e=1E4;break;default:e=5E3}e=c+e;a={id:N++,callback:b,priorityLevel:a,startTime:c,expirationTime:e,sortIndex:-1};c>d?(a.sortIndex=c,H(M,a),null===J(L)&&a===J(M)&&(S?h():S=!0,g(U,c-d))):(a.sortIndex=e,H(L,a),R||Q||(R=!0,f(V)));return a};
exports.unstable_wrapCallback=function(a){var b=P;return function(){var c=P;P=b;try{return a.apply(this,arguments)}finally{P=c}}};


/***/ }),
/* 40 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/** @license React v16.13.1
 * react-is.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

var b="function"===typeof Symbol&&Symbol.for,c=b?Symbol.for("react.element"):60103,d=b?Symbol.for("react.portal"):60106,e=b?Symbol.for("react.fragment"):60107,f=b?Symbol.for("react.strict_mode"):60108,g=b?Symbol.for("react.profiler"):60114,h=b?Symbol.for("react.provider"):60109,k=b?Symbol.for("react.context"):60110,l=b?Symbol.for("react.async_mode"):60111,m=b?Symbol.for("react.concurrent_mode"):60111,n=b?Symbol.for("react.forward_ref"):60112,p=b?Symbol.for("react.suspense"):60113,q=b?
Symbol.for("react.suspense_list"):60120,r=b?Symbol.for("react.memo"):60115,t=b?Symbol.for("react.lazy"):60116,v=b?Symbol.for("react.block"):60121,w=b?Symbol.for("react.fundamental"):60117,x=b?Symbol.for("react.responder"):60118,y=b?Symbol.for("react.scope"):60119;
function z(a){if("object"===typeof a&&null!==a){var u=a.$$typeof;switch(u){case c:switch(a=a.type,a){case l:case m:case e:case g:case f:case p:return a;default:switch(a=a&&a.$$typeof,a){case k:case n:case t:case r:case h:return a;default:return u}}case d:return u}}}function A(a){return z(a)===m}exports.AsyncMode=l;exports.ConcurrentMode=m;exports.ContextConsumer=k;exports.ContextProvider=h;exports.Element=c;exports.ForwardRef=n;exports.Fragment=e;exports.Lazy=t;exports.Memo=r;exports.Portal=d;
exports.Profiler=g;exports.StrictMode=f;exports.Suspense=p;exports.isAsyncMode=function(a){return A(a)||z(a)===l};exports.isConcurrentMode=A;exports.isContextConsumer=function(a){return z(a)===k};exports.isContextProvider=function(a){return z(a)===h};exports.isElement=function(a){return"object"===typeof a&&null!==a&&a.$$typeof===c};exports.isForwardRef=function(a){return z(a)===n};exports.isFragment=function(a){return z(a)===e};exports.isLazy=function(a){return z(a)===t};
exports.isMemo=function(a){return z(a)===r};exports.isPortal=function(a){return z(a)===d};exports.isProfiler=function(a){return z(a)===g};exports.isStrictMode=function(a){return z(a)===f};exports.isSuspense=function(a){return z(a)===p};
exports.isValidElementType=function(a){return"string"===typeof a||"function"===typeof a||a===e||a===m||a===g||a===f||a===p||a===q||"object"===typeof a&&null!==a&&(a.$$typeof===t||a.$$typeof===r||a.$$typeof===h||a.$$typeof===k||a.$$typeof===n||a.$$typeof===w||a.$$typeof===x||a.$$typeof===y||a.$$typeof===v)};exports.typeOf=z;


/***/ }),
/* 41 */,
/* 42 */,
/* 43 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var CompletionType;
(function (CompletionType) {
    CompletionType[CompletionType["SearchEngines"] = 0] = "SearchEngines";
    CompletionType[CompletionType["History"] = 1] = "History";
    CompletionType[CompletionType["Bookmarks"] = 2] = "Bookmarks";
})(CompletionType || (CompletionType = {}));
exports.default = CompletionType;


/***/ }),
/* 44 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
var TabFlag;
(function (TabFlag) {
    TabFlag["CurrentTab"] = "%";
    TabFlag["LastTab"] = "#";
    TabFlag["None"] = "";
})(TabFlag || (TabFlag = {}));
exports.default = TabFlag;


/***/ }),
/* 45 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var _node_modules_css_loader_dist_runtime_cssWithMappingToString_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(66);
/* harmony import */ var _node_modules_css_loader_dist_runtime_cssWithMappingToString_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_css_loader_dist_runtime_cssWithMappingToString_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(67);
/* harmony import */ var _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_1__);
// Imports


var ___CSS_LOADER_EXPORT___ = _node_modules_css_loader_dist_runtime_api_js__WEBPACK_IMPORTED_MODULE_1___default()(_node_modules_css_loader_dist_runtime_cssWithMappingToString_js__WEBPACK_IMPORTED_MODULE_0___default.a);
// Module
___CSS_LOADER_EXPORT___.push([module.i, "html, body, * {\n  margin: 0;\n  padding: 0;\n\n  font-style: normal;\n  font-family: monospace;\n  font-size: 12px;\n  line-height: 16px;\n}\n\ninput {\n  font-style: normal;\n  font-family: monospace;\n  font-size: 12px;\n  line-height: 16px;\n}\n\nbody {\n  position: absolute;\n  bottom: 0;\n  left: 0;\n  right: 0;\n  overflow: hidden;\n}\n\n.vimvixen-console {\n  bottom: 0;\n  margin: 0;\n  padding: 0;\n}\n", "",{"version":3,"sources":["webpack://./src/console/index.css"],"names":[],"mappings":"AAAA;EACE,SAAS;EACT,UAAU;;EAEV,kBAAkB;EAClB,sBAAsB;EACtB,eAAe;EACf,iBAAiB;AACnB;;AAEA;EACE,kBAAkB;EAClB,sBAAsB;EACtB,eAAe;EACf,iBAAiB;AACnB;;AAEA;EACE,kBAAkB;EAClB,SAAS;EACT,OAAO;EACP,QAAQ;EACR,gBAAgB;AAClB;;AAEA;EACE,SAAS;EACT,SAAS;EACT,UAAU;AACZ","sourcesContent":["html, body, * {\n  margin: 0;\n  padding: 0;\n\n  font-style: normal;\n  font-family: monospace;\n  font-size: 12px;\n  line-height: 16px;\n}\n\ninput {\n  font-style: normal;\n  font-family: monospace;\n  font-size: 12px;\n  line-height: 16px;\n}\n\nbody {\n  position: absolute;\n  bottom: 0;\n  left: 0;\n  right: 0;\n  overflow: hidden;\n}\n\n.vimvixen-console {\n  bottom: 0;\n  margin: 0;\n  padding: 0;\n}\n"],"sourceRoot":""}]);
// Exports
/* harmony default export */ __webpack_exports__["a"] = (___CSS_LOADER_EXPORT___);


/***/ }),
/* 46 */,
/* 47 */,
/* 48 */,
/* 49 */,
/* 50 */,
/* 51 */,
/* 52 */,
/* 53 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const styled_1 = tslib_1.__importDefault(__webpack_require__(27));
const Container = styled_1.default.div `
  background-color: ${({ theme }) => theme.commandBackground};
  color: ${({ theme }) => theme.commandForeground};
  display: flex;
`;
const Prompt = styled_1.default.i `
  font-style: normal;
`;
const InputInner = styled_1.default.input `
  border: none;
  flex-grow: 1;
  background-color: ${({ theme }) => theme.commandBackground};
  color: ${({ theme }) => theme.commandForeground};
`;
const Input = (props) => {
    const input = react_1.default.useRef(null);
    react_1.default.useEffect(() => {
        var _a;
        (_a = input === null || input === void 0 ? void 0 : input.current) === null || _a === void 0 ? void 0 : _a.focus();
    }, []);
    return (react_1.default.createElement(Container, null,
        react_1.default.createElement(Prompt, null, props.prompt),
        react_1.default.createElement(InputInner, { ref: input, onBlur: props.onBlur, onKeyDown: props.onKeyDown, onChange: props.onChange, value: props.value })));
};
exports.default = Input;


/***/ }),
/* 54 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const ConsoleFrameClient_1 = tslib_1.__importDefault(__webpack_require__(262));
const useAutoResize = () => {
    const [prevWidth, setPrevWidth] = react_1.default.useState(-1);
    const [prevHeight, setPrevHeight] = react_1.default.useState(-1);
    const consoleFrameClient = react_1.default.useMemo(() => {
        return new ConsoleFrameClient_1.default();
    }, []);
    react_1.default.useLayoutEffect(() => {
        const { scrollWidth: width, scrollHeight: height } = document.getElementById("vimvixen-console");
        consoleFrameClient.resize(width, height);
        if (width === prevWidth && height === prevHeight) {
            return;
        }
        setPrevWidth(width);
        setPrevHeight(height);
    });
};
exports.default = useAutoResize;


/***/ }),
/* 55 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.hideCommand = exports.showInfo = exports.showError = exports.showFind = exports.showCommand = exports.hide = exports.HIDE = exports.SHOW_FIND = exports.HIDE_COMMAND = exports.SHOW_INFO = exports.SHOW_ERROR = exports.SHOW_COMMAND = void 0;
exports.SHOW_COMMAND = "show.command";
exports.SHOW_ERROR = "show.error";
exports.SHOW_INFO = "show.info";
exports.HIDE_COMMAND = "hide.command";
exports.SHOW_FIND = "show.find";
exports.HIDE = "hide";
const hide = () => {
    return {
        type: exports.HIDE,
    };
};
exports.hide = hide;
const showCommand = (text) => {
    return {
        type: exports.SHOW_COMMAND,
        text,
    };
};
exports.showCommand = showCommand;
const showFind = () => {
    return {
        type: exports.SHOW_FIND,
    };
};
exports.showFind = showFind;
const showError = (text) => {
    return {
        type: exports.SHOW_ERROR,
        text: text,
    };
};
exports.showError = showError;
const showInfo = (text) => {
    return {
        type: exports.SHOW_INFO,
        text: text,
    };
};
exports.showInfo = showInfo;
const hideCommand = () => {
    return {
        type: exports.HIDE_COMMAND,
    };
};
exports.hideCommand = hideCommand;


/***/ }),
/* 56 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.AppDispatchContext = exports.AppStateContext = void 0;
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const recuer_1 = __webpack_require__(57);
exports.AppStateContext = react_1.default.createContext(recuer_1.defaultState);
exports.AppDispatchContext = react_1.default.createContext(() => { });


/***/ }),
/* 57 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.defaultState = void 0;
const actions_1 = __webpack_require__(55);
exports.defaultState = {
    mode: "",
    messageText: "",
    consoleText: "",
};
function reducer(state = exports.defaultState, action) {
    switch (action.type) {
        case actions_1.HIDE:
            return Object.assign(Object.assign({}, state), { mode: "" });
        case actions_1.SHOW_COMMAND:
            return Object.assign(Object.assign({}, state), { mode: "command", consoleText: action.text });
        case actions_1.SHOW_FIND:
            return Object.assign(Object.assign({}, state), { mode: "find", consoleText: "" });
        case actions_1.SHOW_ERROR:
            return Object.assign(Object.assign({}, state), { mode: "error", messageText: action.text });
        case actions_1.SHOW_INFO:
            return Object.assign(Object.assign({}, state), { mode: "info", messageText: action.text });
        case actions_1.HIDE_COMMAND:
            return Object.assign(Object.assign({}, state), { mode: state.mode === "command" || state.mode === "find" ? "" : state.mode });
        default:
            return state;
    }
}
exports.default = reducer;


/***/ }),
/* 58 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.selectPrev = exports.selectNext = exports.setCompletions = exports.setCompletionSource = exports.initCompletion = exports.COMPLETION_PREV = exports.COMPLETION_NEXT = exports.SET_COMPLETIONS = exports.SET_COMPLETION_SOURCE = exports.INIT_COMPLETIONS = void 0;
exports.INIT_COMPLETIONS = "reset.completions";
exports.SET_COMPLETION_SOURCE = "set.completion.source";
exports.SET_COMPLETIONS = "set.completions";
exports.COMPLETION_NEXT = "completion.next";
exports.COMPLETION_PREV = "completion.prev";
const initCompletion = (completionTypes) => {
    return {
        type: exports.INIT_COMPLETIONS,
        completionTypes,
    };
};
exports.initCompletion = initCompletion;
const setCompletionSource = (query) => {
    return {
        type: exports.SET_COMPLETION_SOURCE,
        completionSource: query,
    };
};
exports.setCompletionSource = setCompletionSource;
const setCompletions = (completions) => {
    return {
        type: exports.SET_COMPLETIONS,
        completions,
    };
};
exports.setCompletions = setCompletions;
const selectNext = () => {
    return {
        type: exports.COMPLETION_NEXT,
    };
};
exports.selectNext = selectNext;
const selectPrev = () => {
    return {
        type: exports.COMPLETION_PREV,
    };
};
exports.selectPrev = selectPrev;


/***/ }),
/* 59 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.Command = void 0;
var Command;
(function (Command) {
    Command["Open"] = "open";
    Command["TabOpen"] = "tabopen";
    Command["WindowOpen"] = "winopen";
    Command["Buffer"] = "buffer";
    Command["BufferDelete"] = "bdelete";
    Command["BufferDeleteForce"] = "bdelete!";
    Command["BuffersDelete"] = "bdeletes";
    Command["BuffersDeleteForce"] = "bdeletes!";
    Command["AddBookmark"] = "addbookmark";
    Command["Quit"] = "quit";
    Command["QuitAll"] = "quitall";
    Command["Set"] = "set";
    Command["Help"] = "help";
})(Command = exports.Command || (exports.Command = {}));


/***/ }),
/* 60 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.CompletionDispatchContext = exports.CompletionStateContext = void 0;
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const reducer_1 = __webpack_require__(61);
exports.CompletionStateContext = react_1.default.createContext(reducer_1.defaultState);
exports.CompletionDispatchContext = react_1.default.createContext(() => { });


/***/ }),
/* 61 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.defaultState = void 0;
const actions_1 = __webpack_require__(58);
exports.defaultState = {
    completionTypes: undefined,
    completionSource: "",
    completions: [],
    select: -1,
};
const nextSelection = (state) => {
    const length = state.completions
        .map((g) => g.items.length)
        .reduce((x, y) => x + y, 0);
    if (length === 0) {
        return -1;
    }
    if (state.select < 0) {
        return 0;
    }
    if (state.select + 1 < length) {
        return state.select + 1;
    }
    return -1;
};
const prevSelection = (state) => {
    if (state.completions.length === 0) {
        return -1;
    }
    const length = state.completions
        .map((g) => g.items.length)
        .reduce((x, y) => x + y);
    if (state.select < 0) {
        return length - 1;
    }
    return state.select - 1;
};
function reducer(state = exports.defaultState, action) {
    switch (action.type) {
        case actions_1.INIT_COMPLETIONS:
            return Object.assign(Object.assign({}, state), { completionTypes: action.completionTypes, completions: [], select: -1 });
        case actions_1.SET_COMPLETION_SOURCE:
            return Object.assign(Object.assign({}, state), { completionSource: action.completionSource, select: -1 });
        case actions_1.SET_COMPLETIONS:
            return Object.assign(Object.assign({}, state), { completions: action.completions });
        case actions_1.COMPLETION_NEXT: {
            const select = nextSelection(state);
            return Object.assign(Object.assign({}, state), { select: select });
        }
        case actions_1.COMPLETION_PREV: {
            const select = prevSelection(state);
            return Object.assign(Object.assign({}, state), { select: select });
        }
        default:
            return state;
    }
}
exports.default = reducer;


/***/ }),
/* 62 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.UnknownCommandError = void 0;
const Command_1 = __webpack_require__(59);
class UnknownCommandError extends Error {
    constructor(value) {
        super(`unknown command '${value}'`);
    }
}
exports.UnknownCommandError = UnknownCommandError;
class CommandParser {
    parse(value) {
        switch (value) {
            case "o":
            case "open":
                return Command_1.Command.Open;
            case "t":
            case "tabopen":
                return Command_1.Command.TabOpen;
            case "w":
            case "winopen":
                return Command_1.Command.WindowOpen;
            case "b":
            case "buffer":
                return Command_1.Command.Buffer;
            case "bd":
            case "bdel":
            case "bdelete":
                return Command_1.Command.BufferDelete;
            case "bd!":
            case "bdel!":
            case "bdelete!":
                return Command_1.Command.BufferDeleteForce;
            case "bdeletes":
                return Command_1.Command.BuffersDelete;
            case "bdeletes!":
                return Command_1.Command.BuffersDeleteForce;
            case "addbookmark":
                return Command_1.Command.AddBookmark;
            case "q":
            case "quit":
                return Command_1.Command.Quit;
            case "qa":
            case "quitall":
                return Command_1.Command.QuitAll;
            case "set":
                return Command_1.Command.Set;
            case "h":
            case "help":
                return Command_1.Command.Help;
        }
        throw new UnknownCommandError(value);
    }
}
exports.default = CommandParser;


/***/ }),
/* 63 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.ColorSchemeUpdateContext = exports.ColorSchemeContext = void 0;
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const ColorScheme_1 = tslib_1.__importDefault(__webpack_require__(11));
exports.ColorSchemeContext = react_1.default.createContext(ColorScheme_1.default.System);
exports.ColorSchemeUpdateContext = react_1.default.createContext(() => { });


/***/ }),
/* 64 */,
/* 65 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var isOldIE = function isOldIE() {
  var memo;
  return function memorize() {
    if (typeof memo === 'undefined') {
      // Test for IE <= 9 as proposed by Browserhacks
      // @see http://browserhacks.com/#hack-e71d8692f65334173fee715c222cb805
      // Tests for existence of standard globals is to allow style-loader
      // to operate correctly into non-standard environments
      // @see https://github.com/webpack-contrib/style-loader/issues/177
      memo = Boolean(window && document && document.all && !window.atob);
    }

    return memo;
  };
}();

var getTarget = function getTarget() {
  var memo = {};
  return function memorize(target) {
    if (typeof memo[target] === 'undefined') {
      var styleTarget = document.querySelector(target); // Special case to return head of iframe instead of iframe itself

      if (window.HTMLIFrameElement && styleTarget instanceof window.HTMLIFrameElement) {
        try {
          // This will throw an exception if access to iframe is blocked
          // due to cross-origin restrictions
          styleTarget = styleTarget.contentDocument.head;
        } catch (e) {
          // istanbul ignore next
          styleTarget = null;
        }
      }

      memo[target] = styleTarget;
    }

    return memo[target];
  };
}();

var stylesInDom = [];

function getIndexByIdentifier(identifier) {
  var result = -1;

  for (var i = 0; i < stylesInDom.length; i++) {
    if (stylesInDom[i].identifier === identifier) {
      result = i;
      break;
    }
  }

  return result;
}

function modulesToDom(list, options) {
  var idCountMap = {};
  var identifiers = [];

  for (var i = 0; i < list.length; i++) {
    var item = list[i];
    var id = options.base ? item[0] + options.base : item[0];
    var count = idCountMap[id] || 0;
    var identifier = "".concat(id, " ").concat(count);
    idCountMap[id] = count + 1;
    var index = getIndexByIdentifier(identifier);
    var obj = {
      css: item[1],
      media: item[2],
      sourceMap: item[3]
    };

    if (index !== -1) {
      stylesInDom[index].references++;
      stylesInDom[index].updater(obj);
    } else {
      stylesInDom.push({
        identifier: identifier,
        updater: addStyle(obj, options),
        references: 1
      });
    }

    identifiers.push(identifier);
  }

  return identifiers;
}

function insertStyleElement(options) {
  var style = document.createElement('style');
  var attributes = options.attributes || {};

  if (typeof attributes.nonce === 'undefined') {
    var nonce =  true ? __webpack_require__.nc : undefined;

    if (nonce) {
      attributes.nonce = nonce;
    }
  }

  Object.keys(attributes).forEach(function (key) {
    style.setAttribute(key, attributes[key]);
  });

  if (typeof options.insert === 'function') {
    options.insert(style);
  } else {
    var target = getTarget(options.insert || 'head');

    if (!target) {
      throw new Error("Couldn't find a style target. This probably means that the value for the 'insert' parameter is invalid.");
    }

    target.appendChild(style);
  }

  return style;
}

function removeStyleElement(style) {
  // istanbul ignore if
  if (style.parentNode === null) {
    return false;
  }

  style.parentNode.removeChild(style);
}
/* istanbul ignore next  */


var replaceText = function replaceText() {
  var textStore = [];
  return function replace(index, replacement) {
    textStore[index] = replacement;
    return textStore.filter(Boolean).join('\n');
  };
}();

function applyToSingletonTag(style, index, remove, obj) {
  var css = remove ? '' : obj.media ? "@media ".concat(obj.media, " {").concat(obj.css, "}") : obj.css; // For old IE

  /* istanbul ignore if  */

  if (style.styleSheet) {
    style.styleSheet.cssText = replaceText(index, css);
  } else {
    var cssNode = document.createTextNode(css);
    var childNodes = style.childNodes;

    if (childNodes[index]) {
      style.removeChild(childNodes[index]);
    }

    if (childNodes.length) {
      style.insertBefore(cssNode, childNodes[index]);
    } else {
      style.appendChild(cssNode);
    }
  }
}

function applyToTag(style, options, obj) {
  var css = obj.css;
  var media = obj.media;
  var sourceMap = obj.sourceMap;

  if (media) {
    style.setAttribute('media', media);
  } else {
    style.removeAttribute('media');
  }

  if (sourceMap && typeof btoa !== 'undefined') {
    css += "\n/*# sourceMappingURL=data:application/json;base64,".concat(btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))), " */");
  } // For old IE

  /* istanbul ignore if  */


  if (style.styleSheet) {
    style.styleSheet.cssText = css;
  } else {
    while (style.firstChild) {
      style.removeChild(style.firstChild);
    }

    style.appendChild(document.createTextNode(css));
  }
}

var singleton = null;
var singletonCounter = 0;

function addStyle(obj, options) {
  var style;
  var update;
  var remove;

  if (options.singleton) {
    var styleIndex = singletonCounter++;
    style = singleton || (singleton = insertStyleElement(options));
    update = applyToSingletonTag.bind(null, style, styleIndex, false);
    remove = applyToSingletonTag.bind(null, style, styleIndex, true);
  } else {
    style = insertStyleElement(options);
    update = applyToTag.bind(null, style, options);

    remove = function remove() {
      removeStyleElement(style);
    };
  }

  update(obj);
  return function updateStyle(newObj) {
    if (newObj) {
      if (newObj.css === obj.css && newObj.media === obj.media && newObj.sourceMap === obj.sourceMap) {
        return;
      }

      update(obj = newObj);
    } else {
      remove();
    }
  };
}

module.exports = function (list, options) {
  options = options || {}; // Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
  // tags it will allow on a page

  if (!options.singleton && typeof options.singleton !== 'boolean') {
    options.singleton = isOldIE();
  }

  list = list || [];
  var lastIdentifiers = modulesToDom(list, options);
  return function update(newList) {
    newList = newList || [];

    if (Object.prototype.toString.call(newList) !== '[object Array]') {
      return;
    }

    for (var i = 0; i < lastIdentifiers.length; i++) {
      var identifier = lastIdentifiers[i];
      var index = getIndexByIdentifier(identifier);
      stylesInDom[index].references--;
    }

    var newLastIdentifiers = modulesToDom(newList, options);

    for (var _i = 0; _i < lastIdentifiers.length; _i++) {
      var _identifier = lastIdentifiers[_i];

      var _index = getIndexByIdentifier(_identifier);

      if (stylesInDom[_index].references === 0) {
        stylesInDom[_index].updater();

        stylesInDom.splice(_index, 1);
      }
    }

    lastIdentifiers = newLastIdentifiers;
  };
};

/***/ }),
/* 66 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _unsupportedIterableToArray(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

function _iterableToArrayLimit(arr, i) { var _i = arr && (typeof Symbol !== "undefined" && arr[Symbol.iterator] || arr["@@iterator"]); if (_i == null) return; var _arr = []; var _n = true; var _d = false; var _s, _e; try { for (_i = _i.call(arr); !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

module.exports = function cssWithMappingToString(item) {
  var _item = _slicedToArray(item, 4),
      content = _item[1],
      cssMapping = _item[3];

  if (typeof btoa === "function") {
    // eslint-disable-next-line no-undef
    var base64 = btoa(unescape(encodeURIComponent(JSON.stringify(cssMapping))));
    var data = "sourceMappingURL=data:application/json;charset=utf-8;base64,".concat(base64);
    var sourceMapping = "/*# ".concat(data, " */");
    var sourceURLs = cssMapping.sources.map(function (source) {
      return "/*# sourceURL=".concat(cssMapping.sourceRoot || "").concat(source, " */");
    });
    return [content].concat(sourceURLs).concat([sourceMapping]).join("\n");
  }

  return [content].join("\n");
};

/***/ }),
/* 67 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


/*
  MIT License http://www.opensource.org/licenses/mit-license.php
  Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
// eslint-disable-next-line func-names
module.exports = function (cssWithMappingToString) {
  var list = []; // return the list of modules as css string

  list.toString = function toString() {
    return this.map(function (item) {
      var content = cssWithMappingToString(item);

      if (item[2]) {
        return "@media ".concat(item[2], " {").concat(content, "}");
      }

      return content;
    }).join("");
  }; // import a list of modules into the list
  // eslint-disable-next-line func-names


  list.i = function (modules, mediaQuery, dedupe) {
    if (typeof modules === "string") {
      // eslint-disable-next-line no-param-reassign
      modules = [[null, modules, ""]];
    }

    var alreadyImportedModules = {};

    if (dedupe) {
      for (var i = 0; i < this.length; i++) {
        // eslint-disable-next-line prefer-destructuring
        var id = this[i][0];

        if (id != null) {
          alreadyImportedModules[id] = true;
        }
      }
    }

    for (var _i = 0; _i < modules.length; _i++) {
      var item = [].concat(modules[_i]);

      if (dedupe && alreadyImportedModules[item[0]]) {
        // eslint-disable-next-line no-continue
        continue;
      }

      if (mediaQuery) {
        if (!item[2]) {
          item[2] = mediaQuery;
        } else {
          item[2] = "".concat(mediaQuery, " and ").concat(item[2]);
        }
      }

      list.push(item);
    }
  };

  return list;
};

/***/ }),
/* 68 */,
/* 69 */,
/* 70 */,
/* 71 */,
/* 72 */,
/* 73 */,
/* 74 */,
/* 75 */,
/* 76 */,
/* 77 */,
/* 78 */,
/* 79 */,
/* 80 */,
/* 81 */,
/* 82 */,
/* 83 */,
/* 84 */,
/* 85 */,
/* 86 */,
/* 87 */,
/* 88 */,
/* 89 */,
/* 90 */,
/* 91 */,
/* 92 */,
/* 93 */,
/* 94 */,
/* 95 */,
/* 96 */,
/* 97 */,
/* 98 */,
/* 99 */,
/* 100 */,
/* 101 */,
/* 102 */,
/* 103 */,
/* 104 */,
/* 105 */,
/* 106 */,
/* 107 */,
/* 108 */,
/* 109 */,
/* 110 */,
/* 111 */,
/* 112 */,
/* 113 */,
/* 114 */,
/* 115 */,
/* 116 */,
/* 117 */,
/* 118 */,
/* 119 */,
/* 120 */,
/* 121 */,
/* 122 */,
/* 123 */,
/* 124 */,
/* 125 */,
/* 126 */,
/* 127 */,
/* 128 */,
/* 129 */,
/* 130 */,
/* 131 */,
/* 132 */,
/* 133 */,
/* 134 */,
/* 135 */,
/* 136 */,
/* 137 */,
/* 138 */,
/* 139 */,
/* 140 */,
/* 141 */,
/* 142 */,
/* 143 */,
/* 144 */,
/* 145 */,
/* 146 */,
/* 147 */,
/* 148 */,
/* 149 */,
/* 150 */,
/* 151 */,
/* 152 */,
/* 153 */,
/* 154 */,
/* 155 */,
/* 156 */,
/* 157 */,
/* 158 */,
/* 159 */,
/* 160 */,
/* 161 */,
/* 162 */,
/* 163 */,
/* 164 */,
/* 165 */,
/* 166 */,
/* 167 */,
/* 168 */,
/* 169 */,
/* 170 */,
/* 171 */,
/* 172 */,
/* 173 */,
/* 174 */,
/* 175 */,
/* 176 */,
/* 177 */,
/* 178 */,
/* 179 */,
/* 180 */,
/* 181 */,
/* 182 */,
/* 183 */,
/* 184 */,
/* 185 */,
/* 186 */,
/* 187 */,
/* 188 */,
/* 189 */,
/* 190 */,
/* 191 */,
/* 192 */,
/* 193 */,
/* 194 */,
/* 195 */,
/* 196 */,
/* 197 */,
/* 198 */,
/* 199 */,
/* 200 */,
/* 201 */,
/* 202 */,
/* 203 */,
/* 204 */,
/* 205 */,
/* 206 */,
/* 207 */,
/* 208 */,
/* 209 */,
/* 210 */,
/* 211 */,
/* 212 */,
/* 213 */,
/* 214 */,
/* 215 */,
/* 216 */,
/* 217 */,
/* 218 */,
/* 219 */,
/* 220 */,
/* 221 */,
/* 222 */,
/* 223 */,
/* 224 */,
/* 225 */,
/* 226 */,
/* 227 */,
/* 228 */,
/* 229 */,
/* 230 */,
/* 231 */,
/* 232 */,
/* 233 */,
/* 234 */,
/* 235 */,
/* 236 */,
/* 237 */,
/* 238 */,
/* 239 */,
/* 240 */,
/* 241 */,
/* 242 */,
/* 243 */,
/* 244 */,
/* 245 */,
/* 246 */,
/* 247 */,
/* 248 */,
/* 249 */,
/* 250 */,
/* 251 */,
/* 252 */,
/* 253 */,
/* 254 */,
/* 255 */,
/* 256 */,
/* 257 */,
/* 258 */,
/* 259 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const messages = tslib_1.__importStar(__webpack_require__(4));
const Console_1 = tslib_1.__importDefault(__webpack_require__(260));
__webpack_require__(275);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const react_dom_1 = tslib_1.__importDefault(__webpack_require__(26));
const providers_1 = tslib_1.__importDefault(__webpack_require__(276));
const provider_1 = __webpack_require__(278);
const hooks_1 = __webpack_require__(33);
const RootComponent = () => {
    const hide = hooks_1.useHide();
    const { show: showCommand } = hooks_1.useCommandMode();
    const { show: showFind } = hooks_1.useFindMode();
    const { show: showError } = hooks_1.useErrorMessage();
    const { show: showInfo } = hooks_1.useInfoMessage();
    react_1.default.useEffect(() => {
        const onMessage = async (message) => {
            const msg = messages.valueOf(message);
            switch (msg.type) {
                case messages.CONSOLE_SHOW_COMMAND:
                    showCommand(msg.command);
                    break;
                case messages.CONSOLE_SHOW_FIND:
                    showFind();
                    break;
                case messages.CONSOLE_SHOW_ERROR:
                    showError(msg.text);
                    break;
                case messages.CONSOLE_SHOW_INFO:
                    showInfo(msg.text);
                    break;
                case messages.CONSOLE_HIDE:
                    hide();
                    break;
            }
        };
        browser.runtime.onMessage.addListener(onMessage);
        const port = browser.runtime.connect(undefined, {
            name: "vimvixen-console",
        });
        port.onMessage.addListener(onMessage);
    }, []);
    return react_1.default.createElement(Console_1.default, null);
};
const App = () => (react_1.default.createElement(provider_1.AppProvider, null,
    react_1.default.createElement(providers_1.default, null,
        react_1.default.createElement(RootComponent, null))));
window.addEventListener("DOMContentLoaded", () => {
    const wrapper = document.getElementById("vimvixen-console");
    react_dom_1.default.render(react_1.default.createElement(App, null), wrapper);
});


/***/ }),
/* 260 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const FindPrompt_1 = tslib_1.__importDefault(__webpack_require__(261));
const CommandPrompt_1 = tslib_1.__importDefault(__webpack_require__(263));
const InfoMessage_1 = tslib_1.__importDefault(__webpack_require__(271));
const ErrorMessage_1 = tslib_1.__importDefault(__webpack_require__(272));
const hooks_1 = __webpack_require__(273);
const hooks_2 = __webpack_require__(33);
const Console = () => {
    const refreshColorScheme = hooks_1.useColorSchemeRefresh();
    const { visible: visibleCommand, initialInputValue } = hooks_2.useCommandMode();
    const { visible: visibleFind } = hooks_2.useFindMode();
    const { visible: visibleInfo, message: infoMessage } = hooks_2.useInfoMessage();
    const { visible: visibleError, message: errorMessage } = hooks_2.useErrorMessage();
    react_1.default.useEffect(() => {
        if (visibleCommand || visibleFind || visibleInfo || visibleError) {
            refreshColorScheme();
        }
    }, [visibleCommand, visibleFind, visibleInfo, visibleError]);
    if (visibleCommand) {
        return react_1.default.createElement(CommandPrompt_1.default, { initialInputValue: initialInputValue });
    }
    else if (visibleFind) {
        return react_1.default.createElement(FindPrompt_1.default, null);
    }
    else if (visibleInfo) {
        return react_1.default.createElement(InfoMessage_1.default, null, infoMessage);
    }
    else if (visibleError) {
        return react_1.default.createElement(ErrorMessage_1.default, null, errorMessage);
    }
    return null;
};
exports.default = Console;


/***/ }),
/* 261 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const Input_1 = tslib_1.__importDefault(__webpack_require__(53));
const styled_components_1 = tslib_1.__importDefault(__webpack_require__(5));
const useAutoResize_1 = tslib_1.__importDefault(__webpack_require__(54));
const hooks_1 = __webpack_require__(33);
const ConsoleWrapper = styled_components_1.default.div `
  border-top: 1px solid gray;
`;
const FindPrompt = () => {
    const [inputValue, setInputValue] = react_1.default.useState("");
    const hide = hooks_1.useHide();
    const execFind = hooks_1.useExecFind();
    const onBlur = () => {
        hide();
    };
    useAutoResize_1.default();
    const doEnter = (e) => {
        e.stopPropagation();
        e.preventDefault();
        const value = e.target.value;
        execFind(value === "" ? undefined : value);
        hide();
    };
    const onKeyDown = (e) => {
        switch (e.key) {
            case "Escape":
                hide();
                break;
            case "Enter":
                doEnter(e);
                break;
        }
    };
    const onChange = (e) => {
        setInputValue(e.target.value);
    };
    return (react_1.default.createElement(ConsoleWrapper, null,
        react_1.default.createElement(Input_1.default, { prompt: "/", onBlur: onBlur, onKeyDown: onKeyDown, onChange: onChange, value: inputValue })));
};
exports.default = FindPrompt;


/***/ }),
/* 262 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const messages = tslib_1.__importStar(__webpack_require__(4));
class ConsoleFrameClient {
    async resize(width, height) {
        await browser.runtime.sendMessage({
            type: messages.CONSOLE_RESIZE,
            width,
            height,
        });
    }
}
exports.default = ConsoleFrameClient;


/***/ }),
/* 263 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const Completion_1 = tslib_1.__importDefault(__webpack_require__(264));
const Input_1 = tslib_1.__importDefault(__webpack_require__(53));
const styled_components_1 = tslib_1.__importDefault(__webpack_require__(5));
const hooks_1 = __webpack_require__(267);
const useAutoResize_1 = tslib_1.__importDefault(__webpack_require__(54));
const provider_1 = __webpack_require__(270);
const hooks_2 = __webpack_require__(33);
const COMPLETION_MAX_ITEMS = 33;
const ConsoleWrapper = styled_components_1.default.div `
  border-top: 1px solid gray;
`;
const CommandPromptInner = ({ initialInputValue }) => {
    const hide = hooks_2.useHide();
    const [inputValue, setInputValue] = react_1.default.useState(initialInputValue);
    const { completions, updateCompletions } = hooks_1.useCompletions();
    const { select, currentValue, selectNext, selectPrev } = hooks_1.useSelectCompletion();
    const execCommand = hooks_2.useExecCommand();
    useAutoResize_1.default();
    const onBlur = () => {
        hide();
    };
    const isCancelKey = react_1.default.useCallback((e) => e.key === "Escape" ||
        (e.ctrlKey && e.key === "[") ||
        (e.ctrlKey && e.key === "c"), []);
    const isNextKey = react_1.default.useCallback((e) => (!e.shiftKey && e.key === "Tab") || (e.ctrlKey && e.key === "n"), []);
    const isPrevKey = react_1.default.useCallback((e) => (e.shiftKey && e.key === "Tab") || (e.ctrlKey && e.key === "p"), []);
    const isEnterKey = react_1.default.useCallback((e) => e.key === "Enter" || (e.ctrlKey && e.key === "m"), []);
    const onKeyDown = (e) => {
        if (isCancelKey(e)) {
            hide();
        }
        else if (isEnterKey(e)) {
            const value = e.target.value;
            execCommand(value);
            hide();
        }
        else if (isNextKey(e)) {
            selectNext();
        }
        else if (isPrevKey(e)) {
            selectPrev();
        }
        else {
            return;
        }
        e.stopPropagation();
        e.preventDefault();
    };
    const onChange = (e) => {
        const text = e.target.value;
        setInputValue(text);
    };
    react_1.default.useEffect(() => {
        updateCompletions(inputValue);
    }, [inputValue]);
    return (react_1.default.createElement(ConsoleWrapper, null,
        react_1.default.createElement(Completion_1.default, { size: COMPLETION_MAX_ITEMS, completions: completions, select: select }),
        react_1.default.createElement(Input_1.default, { prompt: ":", onBlur: onBlur, onKeyDown: onKeyDown, onChange: onChange, value: select == -1 ? inputValue : currentValue })));
};
const CommandPrompt = ({ initialInputValue }) => (react_1.default.createElement(provider_1.CompletionProvider, { initialInputValue: initialInputValue },
    react_1.default.createElement(CommandPromptInner, { initialInputValue: initialInputValue })));
exports.default = CommandPrompt;


/***/ }),
/* 264 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const CompletionItem_1 = tslib_1.__importDefault(__webpack_require__(265));
const CompletionTitle_1 = tslib_1.__importDefault(__webpack_require__(266));
const Completion = ({ select, size, completions }) => {
    const [viewOffset, setViewOffset] = react_1.default.useState(0);
    const [prevSelect, setPrevSelect] = react_1.default.useState(-1);
    react_1.default.useEffect(() => {
        if (select === prevSelect) {
            return;
        }
        const viewSelect = (() => {
            let index = 0;
            for (let i = 0; i < completions.length; ++i) {
                ++index;
                const g = completions[i];
                if (select + i + 1 < index + g.items.length) {
                    return select + i + 1;
                }
                index += g.items.length;
            }
            return -1;
        })();
        const nextViewOffset = (() => {
            if (prevSelect < select) {
                return Math.max(viewOffset, viewSelect - size + 1);
            }
            else if (prevSelect > select) {
                return Math.min(viewOffset, viewSelect);
            }
            return 0;
        })();
        setPrevSelect(select);
        setViewOffset(nextViewOffset);
    }, [select]);
    let itemIndex = 0;
    let viewIndex = 0;
    const groups = [];
    completions.forEach((group, groupIndex) => {
        const items = [];
        const title = (react_1.default.createElement(CompletionTitle_1.default, { id: `title-${groupIndex}`, key: `group-${groupIndex}`, shown: viewOffset <= viewIndex && viewIndex < viewOffset + size, title: group.name }));
        ++viewIndex;
        for (const item of group.items) {
            items.push(react_1.default.createElement(CompletionItem_1.default, { shown: viewOffset <= viewIndex && viewIndex < viewOffset + size, key: `item-${itemIndex}`, icon: item.icon, caption: item.caption, url: item.url, highlight: itemIndex === select, "aria-selected": itemIndex === select, role: "menuitem" }));
            ++viewIndex;
            ++itemIndex;
        }
        groups.push(react_1.default.createElement("div", { key: `group-${groupIndex}`, role: "group", "aria-describedby": `title-${groupIndex}` },
            title,
            react_1.default.createElement("ul", null, items)));
    });
    return react_1.default.createElement("div", { role: "menu" }, groups);
};
exports.default = Completion;


/***/ }),
/* 265 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const styled_1 = tslib_1.__importDefault(__webpack_require__(27));
const Container = styled_1.default.li `
  background-image: ${({ icon }) => "url(" + icon + ")"};
  background-color: ${({ highlight, theme }) => highlight
    ? theme.completionSelectedBackground
    : theme.completionItemBackground};
  color: ${({ highlight, theme }) => highlight
    ? theme.completionSelectedForeground
    : theme.completionItemForeground};
  display: ${({ shown }) => (shown ? "display" : "none")};
  padding-left: 1.8rem;
  background-position: 0 center;
  background-size: contain;
  background-repeat: no-repeat;
  white-space: pre;
`;
const Caption = styled_1.default.span `
  display: inline-block;
  width: 40%;
  text-overflow: ellipsis;
  overflow: hidden;
`;
const Description = styled_1.default.span `
  display: inline-block;
  color: ${({ theme }) => theme.completionItemDescriptionForeground};
  width: 60%;
  text-overflow: ellipsis;
  overflow: hidden;
`;
const CompletionItem = (props) => (react_1.default.createElement(Container, Object.assign({ icon: props.icon || "", "aria-labelledby": `completion-item-${props.caption}` }, props),
    react_1.default.createElement(Caption, { id: `completion-item-${props.caption}` }, props.caption),
    react_1.default.createElement(Description, null, props.url)));
exports.default = CompletionItem;


/***/ }),
/* 266 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const styled_1 = tslib_1.__importDefault(__webpack_require__(27));
const Li = styled_1.default.li `
  display: ${({ shown }) => (shown ? "display" : "none")};
  background-color: ${({ theme }) => theme.completionTitleBackground};
  color: ${({ theme }) => theme.completionTitleForeground};
  font-weight: bold;
  margin: 0;
  padding: 0;
`;
const CompletionTitle = (props) => (react_1.default.createElement(Li, Object.assign({}, props), props.title));
exports.default = CompletionTitle;


/***/ }),
/* 267 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.useSelectCompletion = exports.useCompletions = exports.getPropertyCompletions = exports.getTabCompletions = void 0;
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const actions = tslib_1.__importStar(__webpack_require__(58));
const Command_1 = __webpack_require__(59);
const TabFlag_1 = tslib_1.__importDefault(__webpack_require__(44));
const context_1 = __webpack_require__(60);
const CompletionClient_1 = tslib_1.__importDefault(__webpack_require__(268));
const CommandLineParser_1 = tslib_1.__importStar(__webpack_require__(269));
const CommandParser_1 = __webpack_require__(62);
const CompletionType_1 = tslib_1.__importDefault(__webpack_require__(43));
const commandDocs = {
    [Command_1.Command.Set]: "Set a value of the property",
    [Command_1.Command.Open]: "Open a URL or search by keywords in current tab",
    [Command_1.Command.TabOpen]: "Open a URL or search by keywords in new tab",
    [Command_1.Command.WindowOpen]: "Open a URL or search by keywords in new window",
    [Command_1.Command.Buffer]: "Select tabs by matched keywords",
    [Command_1.Command.BufferDelete]: "Close a certain tab matched by keywords",
    [Command_1.Command.BuffersDelete]: "Close all tabs matched by keywords",
    [Command_1.Command.Quit]: "Close the current tab",
    [Command_1.Command.QuitAll]: "Close all tabs",
    [Command_1.Command.AddBookmark]: "Add current page to bookmarks",
    [Command_1.Command.Help]: "Open Vim Vixen help in new tab",
};
const propertyDocs = {
    hintchars: "hint characters on follow mode",
    smoothscroll: "smooth scroll",
    complete: "which are completed at the open page",
    colorscheme: "color scheme of the console",
};
const completionClient = new CompletionClient_1.default();
const useDelayedCallback = (callback, timeout) => {
    const [timer, setTimer] = react_1.default.useState();
    const [enabled, setEnabled] = react_1.default.useState(false);
    const enableDelay = react_1.default.useCallback(() => {
        setEnabled(true);
    }, [setEnabled]);
    const delayedCallback = react_1.default.useCallback((arg1, arg2) => {
        if (enabled) {
            if (typeof timer !== "undefined") {
                clearTimeout(timer);
            }
            const id = setTimeout(() => {
                callback(arg1, arg2);
                clearTimeout(timer);
                setTimer(undefined);
            }, timeout);
            setTimer(id);
        }
        else {
            callback(arg1, arg2);
        }
    }, [enabled, timer]);
    return { enableDelay, delayedCallback };
};
const getCommandCompletions = async (query) => {
    const items = Object.entries(commandDocs)
        .filter(([name]) => name.startsWith(query))
        .map(([name, doc]) => ({
        caption: name,
        content: name,
        url: doc,
    }));
    return [
        {
            name: "Console Command",
            items,
        },
    ];
};
const getOpenCompletions = async (command, query, completionTypes) => {
    const completions = [];
    for (const type of completionTypes) {
        switch (type) {
            case CompletionType_1.default.SearchEngines: {
                const items = await completionClient.requestSearchEngines(query);
                if (items.length === 0) {
                    break;
                }
                completions.push({
                    name: "Search Engines",
                    items: items.map((key) => ({
                        caption: key.title,
                        content: command + " " + key.title,
                    })),
                });
                break;
            }
            case CompletionType_1.default.History: {
                const items = await completionClient.requestHistory(query);
                if (items.length === 0) {
                    break;
                }
                completions.push({
                    name: "History",
                    items: items.map((item) => ({
                        caption: item.title,
                        content: command + " " + item.url,
                        url: item.url,
                    })),
                });
                break;
            }
            case CompletionType_1.default.Bookmarks: {
                const items = await completionClient.requestBookmarks(query);
                if (items.length === 0) {
                    break;
                }
                completions.push({
                    name: "Bookmarks",
                    items: items.map((item) => ({
                        caption: item.title,
                        content: command + " " + item.url,
                        url: item.url,
                    })),
                });
                break;
            }
        }
    }
    return completions;
};
const getTabCompletions = async (command, query, excludePinned) => {
    const items = await completionClient.requestTabs(query, excludePinned);
    if (items.length === 0) {
        return [];
    }
    return [
        {
            name: "Buffers",
            items: items.map((item) => ({
                content: command + " " + item.url,
                caption: `${item.index}: ${item.flag != TabFlag_1.default.None ? item.flag : " "} ${item.title}`,
                url: item.url,
                icon: item.faviconUrl,
            })),
        },
    ];
};
exports.getTabCompletions = getTabCompletions;
const getPropertyCompletions = async (command, query) => {
    const properties = await completionClient.getProperties();
    const items = properties
        .map((item) => {
        const desc = propertyDocs[item.name] || "";
        if (item.type === "boolean") {
            return [
                {
                    caption: item.name,
                    content: command + " " + item.name,
                    url: "Enable " + desc,
                },
                {
                    caption: "no" + item.name,
                    content: command + " no" + item.name,
                    url: "Disable " + desc,
                },
            ];
        }
        else {
            return [
                {
                    caption: item.name,
                    content: command + " " + item.name,
                    url: "Set " + desc,
                },
            ];
        }
    })
        .reduce((acc, val) => acc.concat(val), [])
        .filter((item) => item.caption.startsWith(query));
    return [{ name: "Properties", items }];
};
exports.getPropertyCompletions = getPropertyCompletions;
const useCompletions = () => {
    const state = react_1.default.useContext(context_1.CompletionStateContext);
    const dispatch = react_1.default.useContext(context_1.CompletionDispatchContext);
    const commandLineParser = react_1.default.useMemo(() => new CommandLineParser_1.default(), []);
    const updateCompletions = react_1.default.useCallback((source) => {
        dispatch(actions.setCompletionSource(source));
    }, []);
    const initCompletion = react_1.default.useCallback((source) => {
        completionClient.getCompletionTypes().then((completionTypes) => {
            dispatch(actions.initCompletion(completionTypes));
            dispatch(actions.setCompletionSource(source));
        });
    }, []);
    const { delayedCallback: queryCompletions, enableDelay } = useDelayedCallback(react_1.default.useCallback((text, completionTypes) => {
        const phase = commandLineParser.inputPhase(text);
        if (phase === CommandLineParser_1.InputPhase.OnCommand) {
            getCommandCompletions(text).then((completions) => dispatch(actions.setCompletions(completions)));
        }
        else {
            let cmd = null;
            try {
                cmd = commandLineParser.parse(text);
            }
            catch (e) {
                if (e instanceof CommandParser_1.UnknownCommandError) {
                    return;
                }
            }
            switch (cmd === null || cmd === void 0 ? void 0 : cmd.command) {
                case Command_1.Command.Open:
                case Command_1.Command.TabOpen:
                case Command_1.Command.WindowOpen:
                    if (!completionTypes) {
                        initCompletion(text);
                        return;
                    }
                    getOpenCompletions(cmd.command, cmd.args, completionTypes).then((completions) => dispatch(actions.setCompletions(completions)));
                    break;
                case Command_1.Command.Buffer:
                    exports.getTabCompletions(cmd.command, cmd.args, false).then((completions) => dispatch(actions.setCompletions(completions)));
                    break;
                case Command_1.Command.BufferDelete:
                case Command_1.Command.BuffersDelete:
                    exports.getTabCompletions(cmd.command, cmd.args, true).then((completions) => dispatch(actions.setCompletions(completions)));
                    break;
                case Command_1.Command.BufferDeleteForce:
                case Command_1.Command.BuffersDeleteForce:
                    exports.getTabCompletions(cmd.command, cmd.args, false).then((completions) => dispatch(actions.setCompletions(completions)));
                    break;
                case Command_1.Command.Set:
                    exports.getPropertyCompletions(cmd.command, cmd.args).then((completions) => dispatch(actions.setCompletions(completions)));
                    break;
            }
            enableDelay();
        }
    }, [dispatch]), 100);
    react_1.default.useEffect(() => {
        queryCompletions(state.completionSource, state.completionTypes);
    }, [state.completionSource, state.completionTypes]);
    return {
        completions: state.completions,
        updateCompletions,
        initCompletion,
    };
};
exports.useCompletions = useCompletions;
const useSelectCompletion = () => {
    const state = react_1.default.useContext(context_1.CompletionStateContext);
    const dispatch = react_1.default.useContext(context_1.CompletionDispatchContext);
    const next = react_1.default.useCallback(() => dispatch(actions.selectNext()), [dispatch]);
    const prev = react_1.default.useCallback(() => dispatch(actions.selectPrev()), [dispatch]);
    const currentValue = react_1.default.useMemo(() => {
        var _a;
        if (state.select < 0) {
            return state.completionSource;
        }
        const items = state.completions.map((g) => g.items).flat();
        return ((_a = items[state.select]) === null || _a === void 0 ? void 0 : _a.content) || "";
    }, [state.completionSource, state.select]);
    return {
        select: state.select,
        currentValue,
        selectNext: next,
        selectPrev: prev,
    };
};
exports.useSelectCompletion = useSelectCompletion;


/***/ }),
/* 268 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const messages = tslib_1.__importStar(__webpack_require__(4));
class CompletionClient {
    async getCompletionTypes() {
        const resp = (await browser.runtime.sendMessage({
            type: messages.CONSOLE_GET_COMPLETION_TYPES,
        }));
        return resp;
    }
    async requestSearchEngines(query) {
        const resp = (await browser.runtime.sendMessage({
            type: messages.CONSOLE_REQUEST_SEARCH_ENGINES_MESSAGE,
            query,
        }));
        return resp;
    }
    async requestBookmarks(query) {
        const resp = (await browser.runtime.sendMessage({
            type: messages.CONSOLE_REQUEST_BOOKMARKS,
            query,
        }));
        return resp;
    }
    async requestHistory(query) {
        const resp = (await browser.runtime.sendMessage({
            type: messages.CONSOLE_REQUEST_HISTORY,
            query,
        }));
        return resp;
    }
    async requestTabs(query, excludePinned) {
        const resp = (await browser.runtime.sendMessage({
            type: messages.CONSOLE_REQUEST_TABS,
            query,
            excludePinned,
        }));
        return resp;
    }
    async getProperties() {
        const resp = (await browser.runtime.sendMessage({
            type: messages.CONSOLE_GET_PROPERTIES,
        }));
        return resp;
    }
}
exports.default = CompletionClient;


/***/ }),
/* 269 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.InputPhase = void 0;
const tslib_1 = __webpack_require__(0);
const CommandParser_1 = tslib_1.__importDefault(__webpack_require__(62));
var InputPhase;
(function (InputPhase) {
    InputPhase[InputPhase["OnCommand"] = 0] = "OnCommand";
    InputPhase[InputPhase["OnArgs"] = 1] = "OnArgs";
})(InputPhase = exports.InputPhase || (exports.InputPhase = {}));
class CommandLineParser {
    constructor() {
        this.commandParser = new CommandParser_1.default();
    }
    inputPhase(line) {
        line = line.trimLeft();
        if (line.length == 0) {
            return InputPhase.OnCommand;
        }
        const command = line.split(/\s+/, 1)[0];
        if (line.length == command.length) {
            return InputPhase.OnCommand;
        }
        return InputPhase.OnArgs;
    }
    parse(line) {
        const trimLeft = line.trimLeft();
        const command = trimLeft.split(/\s+/, 1)[0];
        const args = trimLeft.slice(command.length).trimLeft();
        return {
            command: this.commandParser.parse(command),
            args: args,
        };
    }
}
exports.default = CommandLineParser;


/***/ }),
/* 270 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.CompletionProvider = void 0;
const tslib_1 = __webpack_require__(0);
const reducer_1 = tslib_1.__importStar(__webpack_require__(61));
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const context_1 = __webpack_require__(60);
const CompletionProvider = ({ initialInputValue, children, }) => {
    const initialState = Object.assign(Object.assign({}, reducer_1.defaultState), { completionSource: initialInputValue });
    const [state, dispatch] = react_1.default.useReducer(reducer_1.default, initialState);
    return (react_1.default.createElement(context_1.CompletionStateContext.Provider, { value: state },
        react_1.default.createElement(context_1.CompletionDispatchContext.Provider, { value: dispatch }, children)));
};
exports.CompletionProvider = CompletionProvider;


/***/ }),
/* 271 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const styled_1 = tslib_1.__importDefault(__webpack_require__(27));
const Wrapper = styled_1.default.p `
  border-top: 1px solid gray;
  background-color: ${({ theme }) => theme.consoleInfoBackground};
  color: ${({ theme }) => theme.consoleInfoForeground};
  font-weight: normal;
`;
const InfoMessage = ({ children }) => {
    return react_1.default.createElement(Wrapper, { role: "status" }, children);
};
exports.default = InfoMessage;


/***/ }),
/* 272 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const styled_1 = tslib_1.__importDefault(__webpack_require__(27));
const Wrapper = styled_1.default.p `
  border-top: 1px solid gray;
  background-color: ${({ theme }) => theme.consoleErrorBackground};
  color: ${({ theme }) => theme.consoleErrorForeground};
  font-weight: bold;
`;
const ErrorMessage = ({ children }) => {
    return react_1.default.createElement(Wrapper, { role: "alert" }, children);
};
exports.default = ErrorMessage;


/***/ }),
/* 273 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.useColorSchemeRefresh = void 0;
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const contexts_1 = __webpack_require__(63);
const SettingClient_1 = tslib_1.__importDefault(__webpack_require__(274));
const useColorSchemeRefresh = () => {
    const update = react_1.default.useContext(contexts_1.ColorSchemeUpdateContext);
    const settingClient = new SettingClient_1.default();
    const refresh = react_1.default.useCallback(() => {
        settingClient.getColorScheme().then((newScheme) => {
            update(newScheme);
        });
    }, []);
    return refresh;
};
exports.useColorSchemeRefresh = useColorSchemeRefresh;


/***/ }),
/* 274 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = __webpack_require__(0);
const Settings_1 = tslib_1.__importDefault(__webpack_require__(10));
const messages = tslib_1.__importStar(__webpack_require__(4));
class SettingClient {
    async getColorScheme() {
        const json = await browser.runtime.sendMessage({
            type: messages.SETTINGS_QUERY,
        });
        const settings = Settings_1.default.fromJSON(json);
        return settings.properties.colorscheme;
    }
}
exports.default = SettingClient;


/***/ }),
/* 275 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(65);
/* harmony import */ var _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _node_modules_css_loader_dist_cjs_js_index_css__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(45);

            

var options = {};

options.insert = "head";
options.singleton = false;

var update = _node_modules_style_loader_dist_runtime_injectStylesIntoStyleTag_js__WEBPACK_IMPORTED_MODULE_0___default()(_node_modules_css_loader_dist_cjs_js_index_css__WEBPACK_IMPORTED_MODULE_1__[/* default */ "a"], options);



/* harmony default export */ __webpack_exports__["default"] = (_node_modules_css_loader_dist_cjs_js_index_css__WEBPACK_IMPORTED_MODULE_1__[/* default */ "a"].locals || {});

/***/ }),
/* 276 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.ColorSchemeProvider = void 0;
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const ColorScheme_1 = tslib_1.__importDefault(__webpack_require__(11));
const theme_1 = __webpack_require__(277);
const contexts_1 = __webpack_require__(63);
const styled_components_1 = __webpack_require__(5);
const ColorSchemeProvider = ({ children }) => {
    const [colorscheme, setColorScheme] = react_1.default.useState(ColorScheme_1.default.System);
    const theme = react_1.default.useMemo(() => {
        if (colorscheme === ColorScheme_1.default.System) {
            if (window.matchMedia &&
                window.matchMedia("(prefers-color-scheme: dark)").matches) {
                return theme_1.DarkTheme;
            }
        }
        else if (colorscheme === ColorScheme_1.default.Dark) {
            return theme_1.DarkTheme;
        }
        return theme_1.LightTheme;
    }, [colorscheme]);
    return (react_1.default.createElement(contexts_1.ColorSchemeContext.Provider, { value: colorscheme },
        react_1.default.createElement(contexts_1.ColorSchemeUpdateContext.Provider, { value: setColorScheme },
            react_1.default.createElement(styled_components_1.ThemeProvider, { theme: theme }, children))));
};
exports.ColorSchemeProvider = ColorSchemeProvider;
exports.default = exports.ColorSchemeProvider;


/***/ }),
/* 277 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.DarkTheme = exports.LightTheme = void 0;
exports.LightTheme = {
    completionTitleBackground: "lightgray",
    completionTitleForeground: "#000000",
    completionItemBackground: "#ffffff",
    completionItemForeground: "#000000",
    completionItemDescriptionForeground: "#008000",
    completionSelectedBackground: "#ffff00",
    completionSelectedForeground: "#000000",
    commandBackground: "#ffffff",
    commandForeground: "#000000",
    consoleErrorBackground: "#ff0000",
    consoleErrorForeground: "#ffffff",
    consoleInfoBackground: "#ffffff",
    consoleInfoForeground: "#018786",
};
exports.DarkTheme = {
    completionTitleBackground: "#052027",
    completionTitleForeground: "white",
    completionItemBackground: "#2f474f",
    completionItemForeground: "white",
    completionItemDescriptionForeground: "#86fab0",
    completionSelectedBackground: "#eeff41",
    completionSelectedForeground: "#000000",
    commandBackground: "#052027",
    commandForeground: "white",
    consoleErrorBackground: "red",
    consoleErrorForeground: "white",
    consoleInfoBackground: "#052027",
    consoleInfoForeground: "#ffffff",
};


/***/ }),
/* 278 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
exports.AppProvider = void 0;
const tslib_1 = __webpack_require__(0);
const react_1 = tslib_1.__importDefault(__webpack_require__(1));
const recuer_1 = tslib_1.__importStar(__webpack_require__(57));
const contexts_1 = __webpack_require__(56);
const AppProvider = ({ children }) => {
    const [state, dispatch] = react_1.default.useReducer(recuer_1.default, recuer_1.defaultState);
    return (react_1.default.createElement(contexts_1.AppStateContext.Provider, { value: state },
        react_1.default.createElement(contexts_1.AppDispatchContext.Provider, { value: dispatch }, children)));
};
exports.AppProvider = AppProvider;


/***/ })
/******/ ]);
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly8vd2VicGFjay9ib290c3RyYXAiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL3RzbGliL3RzbGliLmVzNi5qcyIsIndlYnBhY2s6Ly8vLi9ub2RlX21vZHVsZXMvcmVhY3QvaW5kZXguanMiLCJ3ZWJwYWNrOi8vLy4vc3JjL3NoYXJlZC9vcGVyYXRpb25zLnRzIiwid2VicGFjazovLy8uL3NyYy9zaGFyZWQvbWVzc2FnZXMudHMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL3N0eWxlZC1jb21wb25lbnRzL2Rpc3Qvc3R5bGVkLWNvbXBvbmVudHMuYnJvd3Nlci5lc20uanMiLCJ3ZWJwYWNrOi8vLy4vc3JjL3NoYXJlZC9zZXR0aW5ncy9Qcm9wZXJ0aWVzLnRzIiwid2VicGFjazovLy8uL3NyYy9zaGFyZWQvc2V0dGluZ3MvQmxhY2tsaXN0LnRzIiwid2VicGFjazovLy8uL25vZGVfbW9kdWxlcy9yZWFjdC1pcy9pbmRleC5qcyIsIndlYnBhY2s6Ly8vLi9zcmMvc2hhcmVkL3NldHRpbmdzL0tleW1hcHMudHMiLCJ3ZWJwYWNrOi8vLy4vc3JjL3NoYXJlZC9zZXR0aW5ncy9TZXR0aW5ncy50cyIsIndlYnBhY2s6Ly8vLi9zcmMvc2hhcmVkL0NvbG9yU2NoZW1lLnRzIiwid2VicGFjazovLy8uL25vZGVfbW9kdWxlcy9ob2lzdC1ub24tcmVhY3Qtc3RhdGljcy9kaXN0L2hvaXN0LW5vbi1yZWFjdC1zdGF0aWNzLmNqcy5qcyIsIndlYnBhY2s6Ly8vLi9zcmMvc2hhcmVkL3NldHRpbmdzL0tleS50cyIsIndlYnBhY2s6Ly8vLi9zcmMvc2hhcmVkL3NldHRpbmdzL1NlYXJjaC50cyIsIndlYnBhY2s6Ly8vLi9ub2RlX21vZHVsZXMvcHJvY2Vzcy9icm93c2VyLmpzIiwid2VicGFjazovLy8uL3NyYy9zaGFyZWQvc2V0dGluZ3MvdmFsaWRhdGUuanMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL2Fqdi9saWIvY29tcGlsZS9lcXVhbC5qcyIsIndlYnBhY2s6Ly8vLi9ub2RlX21vZHVsZXMvZmFzdC1kZWVwLWVxdWFsL2luZGV4LmpzIiwid2VicGFjazovLy8uL25vZGVfbW9kdWxlcy9AZW1vdGlvbi9tZW1vaXplL2Rpc3QvbWVtb2l6ZS5icm93c2VyLmVzbS5qcyIsIndlYnBhY2s6Ly8vLi9ub2RlX21vZHVsZXMvQGVtb3Rpb24vaXMtcHJvcC12YWxpZC9kaXN0L2lzLXByb3AtdmFsaWQuYnJvd3Nlci5lc20uanMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL29iamVjdC1hc3NpZ24vaW5kZXguanMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL3JlYWN0LWRvbS9pbmRleC5qcyIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9jb2xvcnNjaGVtZS9zdHlsZWQudHN4Iiwid2VicGFjazovLy8uL25vZGVfbW9kdWxlcy9zaGFsbG93ZXF1YWwvaW5kZXguanMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL0BlbW90aW9uL3N0eWxpcy9kaXN0L3N0eWxpcy5icm93c2VyLmVzbS5qcyIsIndlYnBhY2s6Ly8vLi9ub2RlX21vZHVsZXMvQGVtb3Rpb24vdW5pdGxlc3MvZGlzdC91bml0bGVzcy5icm93c2VyLmVzbS5qcyIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9hcHAvaG9va3MudHMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL3JlYWN0L2Nqcy9yZWFjdC5wcm9kdWN0aW9uLm1pbi5qcyIsIndlYnBhY2s6Ly8vLi9ub2RlX21vZHVsZXMvcmVhY3QtZG9tL2Nqcy9yZWFjdC1kb20ucHJvZHVjdGlvbi5taW4uanMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL3NjaGVkdWxlci9pbmRleC5qcyIsIndlYnBhY2s6Ly8vLi9ub2RlX21vZHVsZXMvc2NoZWR1bGVyL2Nqcy9zY2hlZHVsZXIucHJvZHVjdGlvbi5taW4uanMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL3JlYWN0LWlzL2Nqcy9yZWFjdC1pcy5wcm9kdWN0aW9uLm1pbi5qcyIsIndlYnBhY2s6Ly8vLi9zcmMvc2hhcmVkL0NvbXBsZXRpb25UeXBlLnRzIiwid2VicGFjazovLy8uL3NyYy9zaGFyZWQvVGFiRmxhZy50cyIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9pbmRleC5jc3MiLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcG9uZW50cy9jb25zb2xlL0lucHV0LnRzeCIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9ob29rcy91c2VBdXRvUmVzaXplLnRzIiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2FwcC9hY3Rpb25zLnRzIiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2FwcC9jb250ZXh0cy50cyIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9hcHAvcmVjdWVyLnRzIiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NvbXBsZXRpb24vYWN0aW9ucy50cyIsIndlYnBhY2s6Ly8vLi9zcmMvc2hhcmVkL0NvbW1hbmQudHMiLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcGxldGlvbi9jb250ZXh0LnRzIiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NvbXBsZXRpb24vcmVkdWNlci50cyIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9jb21tYW5kbGluZS9Db21tYW5kUGFyc2VyLnRzIiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NvbG9yc2NoZW1lL2NvbnRleHRzLnRzeCIsIndlYnBhY2s6Ly8vLi9ub2RlX21vZHVsZXMvc3R5bGUtbG9hZGVyL2Rpc3QvcnVudGltZS9pbmplY3RTdHlsZXNJbnRvU3R5bGVUYWcuanMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL2Nzcy1sb2FkZXIvZGlzdC9ydW50aW1lL2Nzc1dpdGhNYXBwaW5nVG9TdHJpbmcuanMiLCJ3ZWJwYWNrOi8vLy4vbm9kZV9tb2R1bGVzL2Nzcy1sb2FkZXIvZGlzdC9ydW50aW1lL2FwaS5qcyIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9pbmRleC50c3giLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcG9uZW50cy9Db25zb2xlLnRzeCIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9jb21wb25lbnRzL0ZpbmRQcm9tcHQudHN4Iiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NsaWVudHMvQ29uc29sZUZyYW1lQ2xpZW50LnRzIiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NvbXBvbmVudHMvQ29tbWFuZFByb21wdC50c3giLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcG9uZW50cy9jb25zb2xlL0NvbXBsZXRpb24udHN4Iiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NvbXBvbmVudHMvY29uc29sZS9Db21wbGV0aW9uSXRlbS50c3giLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcG9uZW50cy9jb25zb2xlL0NvbXBsZXRpb25UaXRsZS50c3giLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcGxldGlvbi9ob29rcy50cyIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9jbGllbnRzL0NvbXBsZXRpb25DbGllbnQudHMiLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tbWFuZGxpbmUvQ29tbWFuZExpbmVQYXJzZXIudHMiLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcGxldGlvbi9wcm92aWRlci50c3giLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcG9uZW50cy9JbmZvTWVzc2FnZS50c3giLCJ3ZWJwYWNrOi8vLy4vc3JjL2NvbnNvbGUvY29tcG9uZW50cy9FcnJvck1lc3NhZ2UudHN4Iiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NvbG9yc2NoZW1lL2hvb2tzLnRzIiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NsaWVudHMvU2V0dGluZ0NsaWVudC50cyIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9pbmRleC5jc3M/M2UyNCIsIndlYnBhY2s6Ly8vLi9zcmMvY29uc29sZS9jb2xvcnNjaGVtZS9wcm92aWRlcnMudHN4Iiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2NvbG9yc2NoZW1lL3RoZW1lLnRzIiwid2VicGFjazovLy8uL3NyYy9jb25zb2xlL2FwcC9wcm92aWRlci50c3giXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtRQUFBO1FBQ0E7O1FBRUE7UUFDQTs7UUFFQTtRQUNBO1FBQ0E7UUFDQTtRQUNBO1FBQ0E7UUFDQTtRQUNBO1FBQ0E7UUFDQTs7UUFFQTtRQUNBOztRQUVBO1FBQ0E7O1FBRUE7UUFDQTtRQUNBOzs7UUFHQTtRQUNBOztRQUVBO1FBQ0E7O1FBRUE7UUFDQTtRQUNBO1FBQ0EsMENBQTBDLGdDQUFnQztRQUMxRTtRQUNBOztRQUVBO1FBQ0E7UUFDQTtRQUNBLHdEQUF3RCxrQkFBa0I7UUFDMUU7UUFDQSxpREFBaUQsY0FBYztRQUMvRDs7UUFFQTtRQUNBO1FBQ0E7UUFDQTtRQUNBO1FBQ0E7UUFDQTtRQUNBO1FBQ0E7UUFDQTtRQUNBO1FBQ0EseUNBQXlDLGlDQUFpQztRQUMxRSxnSEFBZ0gsbUJBQW1CLEVBQUU7UUFDckk7UUFDQTs7UUFFQTtRQUNBO1FBQ0E7UUFDQSwyQkFBMkIsMEJBQTBCLEVBQUU7UUFDdkQsaUNBQWlDLGVBQWU7UUFDaEQ7UUFDQTtRQUNBOztRQUVBO1FBQ0Esc0RBQXNELCtEQUErRDs7UUFFckg7UUFDQTs7O1FBR0E7UUFDQTs7Ozs7Ozs7QUNsRkE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFDQTs7QUFFQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0EsVUFBVSxnQkFBZ0Isc0NBQXNDLGlCQUFpQixFQUFFO0FBQ25GLHlCQUF5Qix1REFBdUQ7QUFD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Q0EsS0FBSztBQUNMO0FBQ0E7QUFDQSxDQUFDO0FBQ0Q7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxLQUFLO0FBQ0w7QUFDQTtBQUNBO0FBQ0EsU0FBUztBQUNUO0FBQ0E7QUFDQTtBQUNBOzs7QUFHQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsS0FBSztBQUNMO0FBQ0E7QUFDQTtBQUNBLFNBQVM7QUFDVDtBQUNBO0FBQ0E7QUFDQTtBQUNBOzs7O0FBSUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLEtBQUs7QUFDTDtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBLHVCQUF1QixzQkFBc0I7QUFDN0M7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSxxQkFBcUI7QUFDckI7O0FBRUE7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBLHFDQUFxQzs7QUFFckM7QUFDQTtBQUNBOztBQUVBLDJCQUEyQjtBQUMzQjtBQUNBO0FBQ0E7QUFDQSw0QkFBNEIsVUFBVTs7Ozs7Ozs7QUN2THpCO0FBQ2IsWUFBWSxtQkFBTyxDQUFDLEVBQXVCO0FBQzNDO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSw4QkFBOEIsTUFBSztBQUNuQztB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O0FBQ0E7QUFDQSx3QkFBd0Isa0NBQWtDO0FBQzFEOztBQUVBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0EsOEJBQThCLFVBQVU7QUFDeEM7O0FBRUE7QUFDQTtBQUNBLDhCQUE4QixVQUFVO0FBQ3hDO0FBQ0E7O0FBRUE7QUFDQTtBQUNBLGlCQUFpQjtBQUNqQjs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7O0FBRUE7QUFDQTtBQUNBOztBQUVBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7O0FB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Y2hlXG4gXHR2YXIgaW5zdGFsbGVkTW9kdWxlcyA9IHt9O1xuXG4gXHQvLyBUaGUgcmVxdWlyZSBmdW5jdGlvblxuIFx0ZnVuY3Rpb24gX193ZWJwYWNrX3JlcXVpcmVfXyhtb2R1bGVJZCkge1xuXG4gXHRcdC8vIENoZWNrIGlmIG1vZHVsZSBpcyBpbiBjYWNoZVxuIFx0XHRpZihpbnN0YWxsZWRNb2R1bGVzW21vZHVsZUlkXSkge1xuIFx0XHRcdHJldHVybiBpbnN0YWxsZWRNb2R1bGVzW21vZHVsZUlkXS5leHBvcnRzO1xuIFx0XHR9XG4gXHRcdC8vIENyZWF0ZSBhIG5ldyBtb2R1bGUgKGFuZCBwdXQgaXQgaW50byB0aGUgY2FjaGUpXG4gXHRcdHZhciBtb2R1bGUgPSBpbnN0YWxsZWRNb2R1bGVzW21vZHVsZUlkXSA9IHtcbiBcdFx0XHRpOiBtb2R1bGVJZCxcbiBcdFx0XHRsOiBmYWxzZSxcbiBcdFx0XHRleHBvcnRzOiB7fVxuIFx0XHR9O1xuXG4gXHRcdC8vIEV4ZWN1dGUgdGhlIG1vZHVsZSBmdW5jdGlvblxuIFx0XHRtb2R1bGVzW21vZHVsZUlkXS5jYWxsKG1vZHVsZS5leHBvcnRzLCBtb2R1bGUsIG1vZHVsZS5leHBvcnRzLCBfX3dlYnBhY2tfcmVxdWlyZV9fKTtcblxuIFx0XHQvLyBGbGFnIHRoZSBtb2R1bGUgYXMgbG9hZGVkXG4gXHRcdG1vZHVsZS5sID0gdHJ1ZTtcblxuIFx0XHQvLyBSZXR1cm4gdGhlIGV4cG9ydHMgb2YgdGhlIG1vZHVsZVxuIFx0XHRyZXR1cm4gbW9kdWxlLmV4cG9ydHM7XG4gXHR9XG5cblxuIFx0Ly8gZXhwb3NlIHRoZSBtb2R1bGVzIG9iamVjdCAoX193ZWJwYWNrX21vZHVsZXNfXylcbiBcdF9fd2VicGFja19yZXF1aXJlX18ubSA9IG1vZHVsZXM7XG5cbiBcdC8vIGV4cG9zZSB0aGUgbW9kdWxlIGNhY2hlXG4gXHRfX3dlYnBhY2tfcmVxdWlyZV9fLmMgPSBpbnN0YWxsZWRNb2R1bGVzO1xuXG4gXHQvLyBkZWZpbmUgZ2V0dGVyIGZ1bmN0aW9uIGZvciBoYXJtb255IGV4cG9ydHNcbiBcdF9fd2VicGFja19yZXF1aXJlX18uZCA9IGZ1bmN0aW9uKGV4cG9ydHMsIG5hbWUsIGdldHRlcikge1xuIFx0XHRpZighX193ZWJwYWNrX3JlcXVpcmVfXy5vKGV4cG9ydHMsIG5hbWUpKSB7XG4gXHRcdFx0T2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIG5hbWUsIHsgZW51bWVyYWJsZTogdHJ1ZSwgZ2V0OiBnZXR0ZXIgfSk7XG4gXHRcdH1cbiBcdH07XG5cbiBcdC8vIGRlZmluZSBfX2VzTW9kdWxlIG9uIGV4cG9ydHNcbiBcdF9fd2VicGFja19yZXF1aXJlX18uciA9IGZ1bmN0aW9uKGV4cG9ydHMpIHtcbiBcdFx0aWYodHlwZW9mIFN5bWJvbCAhPT0gJ3VuZGVmaW5lZCcgJiYgU3ltYm9sLnRvU3RyaW5nVGFnKSB7XG4gXHRcdFx0T2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIFN5bWJvbC50b1N0cmluZ1RhZywgeyB2YWx1ZTogJ01vZHVsZScgfSk7XG4gXHRcdH1cbiBcdFx0T2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsICdfX2VzTW9kdWxlJywgeyB2YWx1ZTogdHJ1ZSB9KTtcbiBcdH07XG5cbiBcdC8vIGNyZWF0ZSBhIGZha2UgbmFtZXNwYWNlIG9iamVjdFxuIFx0Ly8gbW9kZSAmIDE6IHZhbHVlIGlzIGEgbW9kdWxlIGlkLCByZXF1aXJlIGl0XG4gXHQvLyBtb2RlICYgMjogbWVyZ2UgYWxsIHByb3BlcnRpZXMgb2YgdmFsdWUgaW50byB0aGUgbnNcbiBcdC8vIG1vZGUgJiA0OiByZXR1cm4gdmFsdWUgd2hlbiBhbHJlYWR5IG5zIG9iamVjdFxuIFx0Ly8gbW9kZSAmIDh8MTogYmVoYXZlIGxpa2UgcmVxdWlyZVxuIFx0X193ZWJwYWNrX3JlcXVpcmVfXy50ID0gZnVuY3Rpb24odmFsdWUsIG1vZGUpIHtcbiBcdFx0aWYobW9kZSAmIDEpIHZhbHVlID0gX193ZWJwYWNrX3JlcXVpcmVfXyh2YWx1ZSk7XG4gXHRcdGlmKG1vZGUgJiA4KSByZXR1cm4gdmFsdWU7XG4gXHRcdGlmKChtb2RlICYgNCkgJiYgdHlwZW9mIHZhbHVlID09PSAnb2JqZWN0JyAmJiB2YWx1ZSAmJiB2YWx1ZS5fX2VzTW9kdWxlKSByZXR1cm4gdmFsdWU7XG4gXHRcdHZhciBucyA9IE9iamVjdC5jcmVhdGUobnVsbCk7XG4gXHRcdF9fd2VicGFja19yZXF1aXJlX18ucihucyk7XG4gXHRcdE9iamVjdC5kZWZpbmVQcm9wZXJ0eShucywgJ2RlZmF1bHQnLCB7IGVudW1lcmFibGU6IHRydWUsIHZhbHVlOiB2YWx1ZSB9KTtcbiBcdFx0aWYobW9kZSAmIDIgJiYgdHlwZW9mIHZhbHVlICE9ICdzdHJpbmcnKSBmb3IodmFyIGtleSBpbiB2YWx1ZSkgX193ZWJwYWNrX3JlcXVpcmVfXy5kKG5zLCBrZXksIGZ1bmN0aW9uKGtleSkgeyByZXR1cm4gdmFsdWVba2V5XTsgfS5iaW5kKG51bGwsIGtleSkpO1xuIFx0XHRyZXR1cm4gbnM7XG4gXHR9O1xuXG4gXHQvLyBnZXREZWZhdWx0RXhwb3J0IGZ1bmN0aW9uIGZvciBjb21wYXRpYmlsaXR5IHdpdGggbm9uLWhhcm1vbnkgbW9kdWxlc1xuIFx0X193ZWJwYWNrX3JlcXVpcmVfXy5uID0gZnVuY3Rpb24obW9kdWxlKSB7XG4gXHRcdHZhciBnZXR0ZXIgPSBtb2R1bGUgJiYgbW9kdWxlLl9fZXNNb2R1bGUgP1xuIFx0XHRcdGZ1bmN0aW9uIGdldERlZmF1bHQoKSB7IHJldHVybiBtb2R1bGVbJ2RlZmF1bHQnXTsgfSA6XG4gXHRcdFx0ZnVuY3Rpb24gZ2V0TW9kdWxlRXhwb3J0cygpIHsgcmV0dXJuIG1vZHVsZTsgfTtcbiBcdFx0X193ZWJwYWNrX3JlcXVpcmVfXy5kKGdldHRlciwgJ2EnLCBnZXR0ZXIpO1xuIFx0XHRyZXR1cm4gZ2V0dGVyO1xuIFx0fTtcblxuIFx0Ly8gT2JqZWN0LnByb3RvdHlwZS5oYXNPd25Qcm9wZXJ0eS5jYWxsXG4gXHRfX3dlYnBhY2tfcmVxdWlyZV9fLm8gPSBmdW5jdGlvbihvYmplY3QsIHByb3BlcnR5KSB7IHJldHVybiBPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwob2JqZWN0LCBwcm9wZXJ0eSk7IH07XG5cbiBcdC8vIF9fd2VicGFja19wdWJsaWNfcGF0aF9fXG4gXHRfX3dlYnBhY2tfcmVxdWlyZV9fLnAgPSBcIlwiO1xuXG5cbiBcdC8vIExvYWQgZW50cnkgbW9kdWxlIGFuZCByZXR1cm4gZXhwb3J0c1xuIFx0cmV0dXJuIF9fd2VicGFja19yZXF1aXJlX18oX193ZWJwYWNrX3JlcXVpcmVfXy5zID0gMjU5KTtcbiIsIi8qISAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKlxyXG5Db3B5cmlnaHQgKGMpIE1pY3Jvc29mdCBDb3Jwb3JhdGlvbi5cclxuXHJcblBlcm1pc3Npb24gdG8gdXNlLCBjb3B5LCBtb2RpZnksIGFuZC9vciBkaXN0cmlidXRlIHRoaXMgc29mdHdhcmUgZm9yIGFueVxyXG5wdXJwb3NlIHdpdGggb3Igd2l0aG91dCBmZWUgaXMgaGVyZWJ5IGdyYW50ZWQuXHJcblxyXG5USEUgU09GVFdBUkUgSVMgUFJPVklERUQgXCJBUyBJU1wiIEFORCBUSEUgQVVUSE9SIERJU0NMQUlNUyBBTEwgV0FSUkFOVElFUyBXSVRIXHJcblJFR0FSRCBUTyBUSElTIFNPRlRXQVJFIElOQ0xVRElORyBBTEwgSU1QTElFRCBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElUWVxyXG5BTkQgRklUTkVTUy4gSU4gTk8gRVZFTlQgU0hBTEwgVEhFIEFVVEhPUiBCRSBMSUFCTEUgRk9SIEFOWSBTUEVDSUFMLCBESVJFQ1QsXHJcbklORElSRUNULCBPUiBDT05TRVFVRU5USUFMIERBTUFHRVMgT1IgQU5ZIERBTUFHRVMgV0hBVFNPRVZFUiBSRVNVTFRJTkcgRlJPTVxyXG5MT1NTIE9GIFVTRSwgREFUQSBPUiBQUk9GSVRTLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgTkVHTElHRU5DRSBPUlxyXG5PVEhFUiBUT1JUSU9VUyBBQ1RJT04sIEFSSVNJTkcgT1VUIE9GIE9SIElOIENPTk5FQ1RJT04gV0lUSCBUSEUgVVNFIE9SXHJcblBFUkZPUk1BTkNFIE9GIFRISVMgU09GVFdBUkUuXHJcbioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqICovXHJcbi8qIGdsb2JhbCBSZWZsZWN0LCBQcm9taXNlICovXHJcblxyXG52YXIgZXh0ZW5kU3RhdGljcyA9IGZ1bmN0aW9uKGQsIGIpIHtcclxuICAgIGV4dGVuZFN0YXRpY3MgPSBPYmplY3Quc2V0UHJvdG90eXBlT2YgfHxcclxuICAgICAgICAoeyBfX3Byb3RvX186IFtdIH0gaW5zdGFuY2VvZiBBcnJheSAmJiBmdW5jdGlvbiAoZCwgYikgeyBkLl9fcHJvdG9fXyA9IGI7IH0pIHx8XHJcbiAgICAgICAgZnVuY3Rpb24gKGQsIGIpIHsgZm9yICh2YXIgcCBpbiBiKSBpZiAoYi5oYXNPd25Qcm9wZXJ0eShwKSkgZFtwXSA9IGJbcF07IH07XHJcbiAgICByZXR1cm4gZXh0ZW5kU3RhdGljcyhkLCBiKTtcclxufTtcclxuXHJcbmV4cG9ydCBmdW5jdGlvbiBfX2V4dGVuZHMoZCwgYikge1xyXG4gICAgZXh0ZW5kU3RhdGljcyhkLCBiKTtcclxuICAgIGZ1bmN0aW9uIF9fKCkgeyB0aGlzLmNvbnN0cnVjdG9yID0gZDsgfVxyXG4gICAgZC5wcm90b3R5cGUgPSBiID09PSBudWxsID8gT2JqZWN0LmNyZWF0ZShiKSA6IChfXy5wcm90b3R5cGUgPSBiLnByb3RvdHlwZSwgbmV3IF9fKCkpO1xyXG59XHJcblxyXG5leHBvcnQgdmFyIF9fYXNzaWduID0gZnVuY3Rpb24oKSB7XHJcbiAgICBfX2Fzc2lnbiA9IE9iamVjdC5hc3NpZ24gfHwgZnVuY3Rpb24gX19hc3NpZ24odCkge1xyXG4gICAgICAgIGZvciAodmFyIHMsIGkgPSAxLCBuID0gYXJndW1lbnRzLmxlbmd0aDsgaSA8IG47IGkrKykge1xyXG4gICAgICAgICAgICBzID0gYXJndW1lbnRzW2ldO1xyXG4gICAgICAgICAgICBmb3IgKHZhciBwIGluIHMpIGlmIChPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwocywgcCkpIHRbcF0gPSBzW3BdO1xyXG4gICAgICAgIH1cclxuICAgICAgICByZXR1cm4gdDtcclxuICAgIH1cclxuICAgIHJldHVybiBfX2Fzc2lnbi5hcHBseSh0aGlzLCBhcmd1bWVudHMpO1xyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX19yZXN0KHMsIGUpIHtcclxuICAgIHZhciB0ID0ge307XHJcbiAgICBmb3IgKHZhciBwIGluIHMpIGlmIChPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwocywgcCkgJiYgZS5pbmRleE9mKHApIDwgMClcclxuICAgICAgICB0W3BdID0gc1twXTtcclxuICAgIGlmIChzICE9IG51bGwgJiYgdHlwZW9mIE9iamVjdC5nZXRPd25Qcm9wZXJ0eVN5bWJvbHMgPT09IFwiZnVuY3Rpb25cIilcclxuICAgICAgICBmb3IgKHZhciBpID0gMCwgcCA9IE9iamVjdC5nZXRPd25Qcm9wZXJ0eVN5bWJvbHMocyk7IGkgPCBwLmxlbmd0aDsgaSsrKSB7XHJcbiAgICAgICAgICAgIGlmIChlLmluZGV4T2YocFtpXSkgPCAwICYmIE9iamVjdC5wcm90b3R5cGUucHJvcGVydHlJc0VudW1lcmFibGUuY2FsbChzLCBwW2ldKSlcclxuICAgICAgICAgICAgICAgIHRbcFtpXV0gPSBzW3BbaV1dO1xyXG4gICAgICAgIH1cclxuICAgIHJldHVybiB0O1xyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX19kZWNvcmF0ZShkZWNvcmF0b3JzLCB0YXJnZXQsIGtleSwgZGVzYykge1xyXG4gICAgdmFyIGMgPSBhcmd1bWVudHMubGVuZ3RoLCByID0gYyA8IDMgPyB0YXJnZXQgOiBkZXNjID09PSBudWxsID8gZGVzYyA9IE9iamVjdC5nZXRPd25Qcm9wZXJ0eURlc2NyaXB0b3IodGFyZ2V0LCBrZXkpIDogZGVzYywgZDtcclxuICAgIGlmICh0eXBlb2YgUmVmbGVjdCA9PT0gXCJvYmplY3RcIiAmJiB0eXBlb2YgUmVmbGVjdC5kZWNvcmF0ZSA9PT0gXCJmdW5jdGlvblwiKSByID0gUmVmbGVjdC5kZWNvcmF0ZShkZWNvcmF0b3JzLCB0YXJnZXQsIGtleSwgZGVzYyk7XHJcbiAgICBlbHNlIGZvciAodmFyIGkgPSBkZWNvcmF0b3JzLmxlbmd0aCAtIDE7IGkgPj0gMDsgaS0tKSBpZiAoZCA9IGRlY29yYXRvcnNbaV0pIHIgPSAoYyA8IDMgPyBkKHIpIDogYyA+IDMgPyBkKHRhcmdldCwga2V5LCByKSA6IGQodGFyZ2V0LCBrZXkpKSB8fCByO1xyXG4gICAgcmV0dXJuIGMgPiAzICYmIHIgJiYgT2JqZWN0LmRlZmluZVByb3BlcnR5KHRhcmdldCwga2V5LCByKSwgcjtcclxufVxyXG5cclxuZXhwb3J0IGZ1bmN0aW9uIF9fcGFyYW0ocGFyYW1JbmRleCwgZGVjb3JhdG9yKSB7XHJcbiAgICByZXR1cm4gZnVuY3Rpb24gKHRhcmdldCwga2V5KSB7IGRlY29yYXRvcih0YXJnZXQsIGtleSwgcGFyYW1JbmRleCk7IH1cclxufVxyXG5cclxuZXhwb3J0IGZ1bmN0aW9uIF9fbWV0YWRhdGEobWV0YWRhdGFLZXksIG1ldGFkYXRhVmFsdWUpIHtcclxuICAgIGlmICh0eXBlb2YgUmVmbGVjdCA9PT0gXCJvYmplY3RcIiAmJiB0eXBlb2YgUmVmbGVjdC5tZXRhZGF0YSA9PT0gXCJmdW5jdGlvblwiKSByZXR1cm4gUmVmbGVjdC5tZXRhZGF0YShtZXRhZGF0YUtleSwgbWV0YWRhdGFWYWx1ZSk7XHJcbn1cclxuXHJcbmV4cG9ydCBmdW5jdGlvbiBfX2F3YWl0ZXIodGhpc0FyZywgX2FyZ3VtZW50cywgUCwgZ2VuZXJhdG9yKSB7XHJcbiAgICBmdW5jdGlvbiBhZG9wdCh2YWx1ZSkgeyByZXR1cm4gdmFsdWUgaW5zdGFuY2VvZiBQID8gdmFsdWUgOiBuZXcgUChmdW5jdGlvbiAocmVzb2x2ZSkgeyByZXNvbHZlKHZhbHVlKTsgfSk7IH1cclxuICAgIHJldHVybiBuZXcgKFAgfHwgKFAgPSBQcm9taXNlKSkoZnVuY3Rpb24gKHJlc29sdmUsIHJlamVjdCkge1xyXG4gICAgICAgIGZ1bmN0aW9uIGZ1bGZpbGxlZCh2YWx1ZSkgeyB0cnkgeyBzdGVwKGdlbmVyYXRvci5uZXh0KHZhbHVlKSk7IH0gY2F0Y2ggKGUpIHsgcmVqZWN0KGUpOyB9IH1cclxuICAgICAgICBmdW5jdGlvbiByZWplY3RlZCh2YWx1ZSkgeyB0cnkgeyBzdGVwKGdlbmVyYXRvcltcInRocm93XCJdKHZhbHVlKSk7IH0gY2F0Y2ggKGUpIHsgcmVqZWN0KGUpOyB9IH1cclxuICAgICAgICBmdW5jdGlvbiBzdGVwKHJlc3VsdCkgeyByZXN1bHQuZG9uZSA/IHJlc29sdmUocmVzdWx0LnZhbHVlKSA6IGFkb3B0KHJlc3VsdC52YWx1ZSkudGhlbihmdWxmaWxsZWQsIHJlamVjdGVkKTsgfVxyXG4gICAgICAgIHN0ZXAoKGdlbmVyYXRvciA9IGdlbmVyYXRvci5hcHBseSh0aGlzQXJnLCBfYXJndW1lbnRzIHx8IFtdKSkubmV4dCgpKTtcclxuICAgIH0pO1xyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX19nZW5lcmF0b3IodGhpc0FyZywgYm9keSkge1xyXG4gICAgdmFyIF8gPSB7IGxhYmVsOiAwLCBzZW50OiBmdW5jdGlvbigpIHsgaWYgKHRbMF0gJiAxKSB0aHJvdyB0WzFdOyByZXR1cm4gdFsxXTsgfSwgdHJ5czogW10sIG9wczogW10gfSwgZiwgeSwgdCwgZztcclxuICAgIHJldHVybiBnID0geyBuZXh0OiB2ZXJiKDApLCBcInRocm93XCI6IHZlcmIoMSksIFwicmV0dXJuXCI6IHZlcmIoMikgfSwgdHlwZW9mIFN5bWJvbCA9PT0gXCJmdW5jdGlvblwiICYmIChnW1N5bWJvbC5pdGVyYXRvcl0gPSBmdW5jdGlvbigpIHsgcmV0dXJuIHRoaXM7IH0pLCBnO1xyXG4gICAgZnVuY3Rpb24gdmVyYihuKSB7IHJldHVybiBmdW5jdGlvbiAodikgeyByZXR1cm4gc3RlcChbbiwgdl0pOyB9OyB9XHJcbiAgICBmdW5jdGlvbiBzdGVwKG9wKSB7XHJcbiAgICAgICAgaWYgKGYpIHRocm93IG5ldyBUeXBlRXJyb3IoXCJHZW5lcmF0b3IgaXMgYWxyZWFkeSBleGVjdXRpbmcuXCIpO1xyXG4gICAgICAgIHdoaWxlIChfKSB0cnkge1xyXG4gICAgICAgICAgICBpZiAoZiA9IDEsIHkgJiYgKHQgPSBvcFswXSAmIDIgPyB5W1wicmV0dXJuXCJdIDogb3BbMF0gPyB5W1widGhyb3dcIl0gfHwgKCh0ID0geVtcInJldHVyblwiXSkgJiYgdC5jYWxsKHkpLCAwKSA6IHkubmV4dCkgJiYgISh0ID0gdC5jYWxsKHksIG9wWzFdKSkuZG9uZSkgcmV0dXJuIHQ7XHJcbiAgICAgICAgICAgIGlmICh5ID0gMCwgdCkgb3AgPSBbb3BbMF0gJiAyLCB0LnZhbHVlXTtcclxuICAgICAgICAgICAgc3dpdGNoIChvcFswXSkge1xyXG4gICAgICAgICAgICAgICAgY2FzZSAwOiBjYXNlIDE6IHQgPSBvcDsgYnJlYWs7XHJcbiAgICAgICAgICAgICAgICBjYXNlIDQ6IF8ubGFiZWwrKzsgcmV0dXJuIHsgdmFsdWU6IG9wWzFdLCBkb25lOiBmYWxzZSB9O1xyXG4gICAgICAgICAgICAgICAgY2FzZSA1OiBfLmxhYmVsKys7IHkgPSBvcFsxXTsgb3AgPSBbMF07IGNvbnRpbnVlO1xyXG4gICAgICAgICAgICAgICAgY2FzZSA3OiBvcCA9IF8ub3BzLnBvcCgpOyBfLnRyeXMucG9wKCk7IGNvbnRpbnVlO1xyXG4gICAgICAgICAgICAgICAgZGVmYXVsdDpcclxuICAgICAgICAgICAgICAgICAgICBpZiAoISh0ID0gXy50cnlzLCB0ID0gdC5sZW5ndGggPiAwICYmIHRbdC5sZW5ndGggLSAxXSkgJiYgKG9wWzBdID09PSA2IHx8IG9wWzBdID09PSAyKSkgeyBfID0gMDsgY29udGludWU7IH1cclxuICAgICAgICAgICAgICAgICAgICBpZiAob3BbMF0gPT09IDMgJiYgKCF0IHx8IChvcFsxXSA+IHRbMF0gJiYgb3BbMV0gPCB0WzNdKSkpIHsgXy5sYWJlbCA9IG9wWzFdOyBicmVhazsgfVxyXG4gICAgICAgICAgICAgICAgICAgIGlmIChvcFswXSA9PT0gNiAmJiBfLmxhYmVsIDwgdFsxXSkgeyBfLmxhYmVsID0gdFsxXTsgdCA9IG9wOyBicmVhazsgfVxyXG4gICAgICAgICAgICAgICAgICAgIGlmICh0ICYmIF8ubGFiZWwgPCB0WzJdKSB7IF8ubGFiZWwgPSB0WzJdOyBfLm9wcy5wdXNoKG9wKTsgYnJlYWs7IH1cclxuICAgICAgICAgICAgICAgICAgICBpZiAodFsyXSkgXy5vcHMucG9wKCk7XHJcbiAgICAgICAgICAgICAgICAgICAgXy50cnlzLnBvcCgpOyBjb250aW51ZTtcclxuICAgICAgICAgICAgfVxyXG4gICAgICAgICAgICBvcCA9IGJvZHkuY2FsbCh0aGlzQXJnLCBfKTtcclxuICAgICAgICB9IGNhdGNoIChlKSB7IG9wID0gWzYsIGVdOyB5ID0gMDsgfSBmaW5hbGx5IHsgZiA9IHQgPSAwOyB9XHJcbiAgICAgICAgaWYgKG9wWzBdICYgNSkgdGhyb3cgb3BbMV07IHJldHVybiB7IHZhbHVlOiBvcFswXSA/IG9wWzFdIDogdm9pZCAwLCBkb25lOiB0cnVlIH07XHJcbiAgICB9XHJcbn1cclxuXHJcbmV4cG9ydCBmdW5jdGlvbiBfX2NyZWF0ZUJpbmRpbmcobywgbSwgaywgazIpIHtcclxuICAgIGlmIChrMiA9PT0gdW5kZWZpbmVkKSBrMiA9IGs7XHJcbiAgICBvW2syXSA9IG1ba107XHJcbn1cclxuXHJcbmV4cG9ydCBmdW5jdGlvbiBfX2V4cG9ydFN0YXIobSwgZXhwb3J0cykge1xyXG4gICAgZm9yICh2YXIgcCBpbiBtKSBpZiAocCAhPT0gXCJkZWZhdWx0XCIgJiYgIWV4cG9ydHMuaGFzT3duUHJvcGVydHkocCkpIGV4cG9ydHNbcF0gPSBtW3BdO1xyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX192YWx1ZXMobykge1xyXG4gICAgdmFyIHMgPSB0eXBlb2YgU3ltYm9sID09PSBcImZ1bmN0aW9uXCIgJiYgU3ltYm9sLml0ZXJhdG9yLCBtID0gcyAmJiBvW3NdLCBpID0gMDtcclxuICAgIGlmIChtKSByZXR1cm4gbS5jYWxsKG8pO1xyXG4gICAgaWYgKG8gJiYgdHlwZW9mIG8ubGVuZ3RoID09PSBcIm51bWJlclwiKSByZXR1cm4ge1xyXG4gICAgICAgIG5leHQ6IGZ1bmN0aW9uICgpIHtcclxuICAgICAgICAgICAgaWYgKG8gJiYgaSA+PSBvLmxlbmd0aCkgbyA9IHZvaWQgMDtcclxuICAgICAgICAgICAgcmV0dXJuIHsgdmFsdWU6IG8gJiYgb1tpKytdLCBkb25lOiAhbyB9O1xyXG4gICAgICAgIH1cclxuICAgIH07XHJcbiAgICB0aHJvdyBuZXcgVHlwZUVycm9yKHMgPyBcIk9iamVjdCBpcyBub3QgaXRlcmFibGUuXCIgOiBcIlN5bWJvbC5pdGVyYXRvciBpcyBub3QgZGVmaW5lZC5cIik7XHJcbn1cclxuXHJcbmV4cG9ydCBmdW5jdGlvbiBfX3JlYWQobywgbikge1xyXG4gICAgdmFyIG0gPSB0eXBlb2YgU3ltYm9sID09PSBcImZ1bmN0aW9uXCIgJiYgb1tTeW1ib2wuaXRlcmF0b3JdO1xyXG4gICAgaWYgKCFtKSByZXR1cm4gbztcclxuICAgIHZhciBpID0gbS5jYWxsKG8pLCByLCBhciA9IFtdLCBlO1xyXG4gICAgdHJ5IHtcclxuICAgICAgICB3aGlsZSAoKG4gPT09IHZvaWQgMCB8fCBuLS0gPiAwKSAmJiAhKHIgPSBpLm5leHQoKSkuZG9uZSkgYXIucHVzaChyLnZhbHVlKTtcclxuICAgIH1cclxuICAgIGNhdGNoIChlcnJvcikgeyBlID0geyBlcnJvcjogZXJyb3IgfTsgfVxyXG4gICAgZmluYWxseSB7XHJcbiAgICAgICAgdHJ5IHtcclxuICAgICAgICAgICAgaWYgKHIgJiYgIXIuZG9uZSAmJiAobSA9IGlbXCJyZXR1cm5cIl0pKSBtLmNhbGwoaSk7XHJcbiAgICAgICAgfVxyXG4gICAgICAgIGZpbmFsbHkgeyBpZiAoZSkgdGhyb3cgZS5lcnJvcjsgfVxyXG4gICAgfVxyXG4gICAgcmV0dXJuIGFyO1xyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX19zcHJlYWQoKSB7XHJcbiAgICBmb3IgKHZhciBhciA9IFtdLCBpID0gMDsgaSA8IGFyZ3VtZW50cy5sZW5ndGg7IGkrKylcclxuICAgICAgICBhciA9IGFyLmNvbmNhdChfX3JlYWQoYXJndW1lbnRzW2ldKSk7XHJcbiAgICByZXR1cm4gYXI7XHJcbn1cclxuXHJcbmV4cG9ydCBmdW5jdGlvbiBfX3NwcmVhZEFycmF5cygpIHtcclxuICAgIGZvciAodmFyIHMgPSAwLCBpID0gMCwgaWwgPSBhcmd1bWVudHMubGVuZ3RoOyBpIDwgaWw7IGkrKykgcyArPSBhcmd1bWVudHNbaV0ubGVuZ3RoO1xyXG4gICAgZm9yICh2YXIgciA9IEFycmF5KHMpLCBrID0gMCwgaSA9IDA7IGkgPCBpbDsgaSsrKVxyXG4gICAgICAgIGZvciAodmFyIGEgPSBhcmd1bWVudHNbaV0sIGogPSAwLCBqbCA9IGEubGVuZ3RoOyBqIDwgamw7IGorKywgaysrKVxyXG4gICAgICAgICAgICByW2tdID0gYVtqXTtcclxuICAgIHJldHVybiByO1xyXG59O1xyXG5cclxuZXhwb3J0IGZ1bmN0aW9uIF9fYXdhaXQodikge1xyXG4gICAgcmV0dXJuIHRoaXMgaW5zdGFuY2VvZiBfX2F3YWl0ID8gKHRoaXMudiA9IHYsIHRoaXMpIDogbmV3IF9fYXdhaXQodik7XHJcbn1cclxuXHJcbmV4cG9ydCBmdW5jdGlvbiBfX2FzeW5jR2VuZXJhdG9yKHRoaXNBcmcsIF9hcmd1bWVudHMsIGdlbmVyYXRvcikge1xyXG4gICAgaWYgKCFTeW1ib2wuYXN5bmNJdGVyYXRvcikgdGhyb3cgbmV3IFR5cGVFcnJvcihcIlN5bWJvbC5hc3luY0l0ZXJhdG9yIGlzIG5vdCBkZWZpbmVkLlwiKTtcclxuICAgIHZhciBnID0gZ2VuZXJhdG9yLmFwcGx5KHRoaXNBcmcsIF9hcmd1bWVudHMgfHwgW10pLCBpLCBxID0gW107XHJcbiAgICByZXR1cm4gaSA9IHt9LCB2ZXJiKFwibmV4dFwiKSwgdmVyYihcInRocm93XCIpLCB2ZXJiKFwicmV0dXJuXCIpLCBpW1N5bWJvbC5hc3luY0l0ZXJhdG9yXSA9IGZ1bmN0aW9uICgpIHsgcmV0dXJuIHRoaXM7IH0sIGk7XHJcbiAgICBmdW5jdGlvbiB2ZXJiKG4pIHsgaWYgKGdbbl0pIGlbbl0gPSBmdW5jdGlvbiAodikgeyByZXR1cm4gbmV3IFByb21pc2UoZnVuY3Rpb24gKGEsIGIpIHsgcS5wdXNoKFtuLCB2LCBhLCBiXSkgPiAxIHx8IHJlc3VtZShuLCB2KTsgfSk7IH07IH1cclxuICAgIGZ1bmN0aW9uIHJlc3VtZShuLCB2KSB7IHRyeSB7IHN0ZXAoZ1tuXSh2KSk7IH0gY2F0Y2ggKGUpIHsgc2V0dGxlKHFbMF1bM10sIGUpOyB9IH1cclxuICAgIGZ1bmN0aW9uIHN0ZXAocikgeyByLnZhbHVlIGluc3RhbmNlb2YgX19hd2FpdCA/IFByb21pc2UucmVzb2x2ZShyLnZhbHVlLnYpLnRoZW4oZnVsZmlsbCwgcmVqZWN0KSA6IHNldHRsZShxWzBdWzJdLCByKTsgfVxyXG4gICAgZnVuY3Rpb24gZnVsZmlsbCh2YWx1ZSkgeyByZXN1bWUoXCJuZXh0XCIsIHZhbHVlKTsgfVxyXG4gICAgZnVuY3Rpb24gcmVqZWN0KHZhbHVlKSB7IHJlc3VtZShcInRocm93XCIsIHZhbHVlKTsgfVxyXG4gICAgZnVuY3Rpb24gc2V0dGxlKGYsIHYpIHsgaWYgKGYodiksIHEuc2hpZnQoKSwgcS5sZW5ndGgpIHJlc3VtZShxWzBdWzBdLCBxWzBdWzFdKTsgfVxyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX19hc3luY0RlbGVnYXRvcihvKSB7XHJcbiAgICB2YXIgaSwgcDtcclxuICAgIHJldHVybiBpID0ge30sIHZlcmIoXCJuZXh0XCIpLCB2ZXJiKFwidGhyb3dcIiwgZnVuY3Rpb24gKGUpIHsgdGhyb3cgZTsgfSksIHZlcmIoXCJyZXR1cm5cIiksIGlbU3ltYm9sLml0ZXJhdG9yXSA9IGZ1bmN0aW9uICgpIHsgcmV0dXJuIHRoaXM7IH0sIGk7XHJcbiAgICBmdW5jdGlvbiB2ZXJiKG4sIGYpIHsgaVtuXSA9IG9bbl0gPyBmdW5jdGlvbiAodikgeyByZXR1cm4gKHAgPSAhcCkgPyB7IHZhbHVlOiBfX2F3YWl0KG9bbl0odikpLCBkb25lOiBuID09PSBcInJldHVyblwiIH0gOiBmID8gZih2KSA6IHY7IH0gOiBmOyB9XHJcbn1cclxuXHJcbmV4cG9ydCBmdW5jdGlvbiBfX2FzeW5jVmFsdWVzKG8pIHtcclxuICAgIGlmICghU3ltYm9sLmFzeW5jSXRlcmF0b3IpIHRocm93IG5ldyBUeXBlRXJyb3IoXCJTeW1ib2wuYXN5bmNJdGVyYXRvciBpcyBub3QgZGVmaW5lZC5cIik7XHJcbiAgICB2YXIgbSA9IG9bU3ltYm9sLmFzeW5jSXRlcmF0b3JdLCBpO1xyXG4gICAgcmV0dXJuIG0gPyBtLmNhbGwobykgOiAobyA9IHR5cGVvZiBfX3ZhbHVlcyA9PT0gXCJmdW5jdGlvblwiID8gX192YWx1ZXMobykgOiBvW1N5bWJvbC5pdGVyYXRvcl0oKSwgaSA9IHt9LCB2ZXJiKFwibmV4dFwiKSwgdmVyYihcInRocm93XCIpLCB2ZXJiKFwicmV0dXJuXCIpLCBpW1N5bWJvbC5hc3luY0l0ZXJhdG9yXSA9IGZ1bmN0aW9uICgpIHsgcmV0dXJuIHRoaXM7IH0sIGkpO1xyXG4gICAgZnVuY3Rpb24gdmVyYihuKSB7IGlbbl0gPSBvW25dICYmIGZ1bmN0aW9uICh2KSB7IHJldHVybiBuZXcgUHJvbWlzZShmdW5jdGlvbiAocmVzb2x2ZSwgcmVqZWN0KSB7IHYgPSBvW25dKHYpLCBzZXR0bGUocmVzb2x2ZSwgcmVqZWN0LCB2LmRvbmUsIHYudmFsdWUpOyB9KTsgfTsgfVxyXG4gICAgZnVuY3Rpb24gc2V0dGxlKHJlc29sdmUsIHJlamVjdCwgZCwgdikgeyBQcm9taXNlLnJlc29sdmUodikudGhlbihmdW5jdGlvbih2KSB7IHJlc29sdmUoeyB2YWx1ZTogdiwgZG9uZTogZCB9KTsgfSwgcmVqZWN0KTsgfVxyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX19tYWtlVGVtcGxhdGVPYmplY3QoY29va2VkLCByYXcpIHtcclxuICAgIGlmIChPYmplY3QuZGVmaW5lUHJvcGVydHkpIHsgT2JqZWN0LmRlZmluZVByb3BlcnR5KGNvb2tlZCwgXCJyYXdcIiwgeyB2YWx1ZTogcmF3IH0pOyB9IGVsc2UgeyBjb29rZWQucmF3ID0gcmF3OyB9XHJcbiAgICByZXR1cm4gY29va2VkO1xyXG59O1xyXG5cclxuZXhwb3J0IGZ1bmN0aW9uIF9faW1wb3J0U3Rhcihtb2QpIHtcclxuICAgIGlmIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpIHJldHVybiBtb2Q7XHJcbiAgICB2YXIgcmVzdWx0ID0ge307XHJcbiAgICBpZiAobW9kICE9IG51bGwpIGZvciAodmFyIGsgaW4gbW9kKSBpZiAoT2JqZWN0Lmhhc093blByb3BlcnR5LmNhbGwobW9kLCBrKSkgcmVzdWx0W2tdID0gbW9kW2tdO1xyXG4gICAgcmVzdWx0LmRlZmF1bHQgPSBtb2Q7XHJcbiAgICByZXR1cm4gcmVzdWx0O1xyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX19pbXBvcnREZWZhdWx0KG1vZCkge1xyXG4gICAgcmV0dXJuIChtb2QgJiYgbW9kLl9fZXNNb2R1bGUpID8gbW9kIDogeyBkZWZhdWx0OiBtb2QgfTtcclxufVxyXG5cclxuZXhwb3J0IGZ1bmN0aW9uIF9fY2xhc3NQcml2YXRlRmllbGRHZXQocmVjZWl2ZXIsIHByaXZhdGVNYXApIHtcclxuICAgIGlmICghcHJpdmF0ZU1hcC5oYXMocmVjZWl2ZXIpKSB7XHJcbiAgICAgICAgdGhyb3cgbmV3IFR5cGVFcnJvcihcImF0dGVtcHRlZCB0byBnZXQgcHJpdmF0ZSBmaWVsZCBvbiBub24taW5zdGFuY2VcIik7XHJcbiAgICB9XHJcbiAgICByZXR1cm4gcHJpdmF0ZU1hcC5nZXQocmVjZWl2ZXIpO1xyXG59XHJcblxyXG5leHBvcnQgZnVuY3Rpb24gX19jbGFzc1ByaXZhdGVGaWVsZFNldChyZWNlaXZlciwgcHJpdmF0ZU1hcCwgdmFsdWUpIHtcclxuICAgIGlmICghcHJpdmF0ZU1hcC5oYXMocmVjZWl2ZXIpKSB7XHJcbiAgICAgICAgdGhyb3cgbmV3IFR5cGVFcnJvcihcImF0dGVtcHRlZCB0byBzZXQgcHJpdmF0ZSBmaWVsZCBvbiBub24taW5zdGFuY2VcIik7XHJcbiAgICB9XHJcbiAgICBwcml2YXRlTWFwLnNldChyZWNlaXZlciwgdmFsdWUpO1xyXG4gICAgcmV0dXJuIHZhbHVlO1xyXG59XHJcbiIsIid1c2Ugc3RyaWN0JztcblxuaWYgKHByb2Nlc3MuZW52Lk5PREVfRU5WID09PSAncHJvZHVjdGlvbicpIHtcbiAgbW9kdWxlLmV4cG9ydHMgPSByZXF1aXJlKCcuL2Nqcy9yZWFjdC5wcm9kdWN0aW9uLm1pbi5qcycpO1xufSBlbHNlIHtcbiAgbW9kdWxlLmV4cG9ydHMgPSByZXF1aXJlKCcuL2Nqcy9yZWFjdC5kZXZlbG9wbWVudC5qcycpO1xufVxuIiwiLy8gSGlkZSBjb25zb2xlOyBvciBjYW5jZWwgc29tZSB1c2VyIGFjdGlvbnNcbmV4cG9ydCBjb25zdCBDQU5DRUwgPSBcImNhbmNlbFwiO1xuXG4vLyBBZGRvbnNcbmV4cG9ydCBjb25zdCBBRERPTl9FTkFCTEUgPSBcImFkZG9uLmVuYWJsZVwiO1xuZXhwb3J0IGNvbnN0IEFERE9OX0RJU0FCTEUgPSBcImFkZG9uLmRpc2FibGVcIjtcbmV4cG9ydCBjb25zdCBBRERPTl9UT0dHTEVfRU5BQkxFRCA9IFwiYWRkb24udG9nZ2xlLmVuYWJsZWRcIjtcblxuLy8gQ29tbWFuZFxuZXhwb3J0IGNvbnN0IENPTU1BTkRfU0hPVyA9IFwiY29tbWFuZC5zaG93XCI7XG5leHBvcnQgY29uc3QgQ09NTUFORF9TSE9XX09QRU4gPSBcImNvbW1hbmQuc2hvdy5vcGVuXCI7XG5leHBvcnQgY29uc3QgQ09NTUFORF9TSE9XX1RBQk9QRU4gPSBcImNvbW1hbmQuc2hvdy50YWJvcGVuXCI7XG5leHBvcnQgY29uc3QgQ09NTUFORF9TSE9XX1dJTk9QRU4gPSBcImNvbW1hbmQuc2hvdy53aW5vcGVuXCI7XG5leHBvcnQgY29uc3QgQ09NTUFORF9TSE9XX0JVRkZFUiA9IFwiY29tbWFuZC5zaG93LmJ1ZmZlclwiO1xuZXhwb3J0IGNvbnN0IENPTU1BTkRfU0hPV19BRERCT09LTUFSSyA9IFwiY29tbWFuZC5zaG93LmFkZGJvb2ttYXJrXCI7XG5cbi8vIFNjcm9sbHNcbmV4cG9ydCBjb25zdCBTQ1JPTExfVkVSVElDQUxMWSA9IFwic2Nyb2xsLnZlcnRpY2FsbHlcIjtcbmV4cG9ydCBjb25zdCBTQ1JPTExfSE9SSVpPTkFMTFkgPSBcInNjcm9sbC5ob3Jpem9uYWxseVwiO1xuZXhwb3J0IGNvbnN0IFNDUk9MTF9QQUdFUyA9IFwic2Nyb2xsLnBhZ2VzXCI7XG5leHBvcnQgY29uc3QgU0NST0xMX1RPUCA9IFwic2Nyb2xsLnRvcFwiO1xuZXhwb3J0IGNvbnN0IFNDUk9MTF9CT1RUT00gPSBcInNjcm9sbC5ib3R0b21cIjtcbmV4cG9ydCBjb25zdCBTQ1JPTExfSE9NRSA9IFwic2Nyb2xsLmhvbWVcIjtcbmV4cG9ydCBjb25zdCBTQ1JPTExfRU5EID0gXCJzY3JvbGwuZW5kXCI7XG5cbi8vIEZvbGxvd3NcbmV4cG9ydCBjb25zdCBGT0xMT1dfU1RBUlQgPSBcImZvbGxvdy5zdGFydFwiO1xuXG4vLyBOYXZpZ2F0aW9uc1xuZXhwb3J0IGNvbnN0IE5BVklHQVRFX0hJU1RPUllfUFJFViA9IFwibmF2aWdhdGUuaGlzdG9yeS5wcmV2XCI7XG5leHBvcnQgY29uc3QgTkFWSUdBVEVfSElTVE9SWV9ORVhUID0gXCJuYXZpZ2F0ZS5oaXN0b3J5Lm5leHRcIjtcbmV4cG9ydCBjb25zdCBOQVZJR0FURV9MSU5LX1BSRVYgPSBcIm5hdmlnYXRlLmxpbmsucHJldlwiO1xuZXhwb3J0IGNvbnN0IE5BVklHQVRFX0xJTktfTkVYVCA9IFwibmF2aWdhdGUubGluay5uZXh0XCI7XG5leHBvcnQgY29uc3QgTkFWSUdBVEVfUEFSRU5UID0gXCJuYXZpZ2F0ZS5wYXJlbnRcIjtcbmV4cG9ydCBjb25zdCBOQVZJR0FURV9ST09UID0gXCJuYXZpZ2F0ZS5yb290XCI7XG5cbi8vIEZvY3VzXG5leHBvcnQgY29uc3QgRk9DVVNfSU5QVVQgPSBcImZvY3VzLmlucHV0XCI7XG5cbi8vIFBhZ2VcbmV4cG9ydCBjb25zdCBQQUdFX1NPVVJDRSA9IFwicGFnZS5zb3VyY2VcIjtcbmV4cG9ydCBjb25zdCBQQUdFX0hPTUUgPSBcInBhZ2UuaG9tZVwiO1xuXG4vLyBUYWJzXG5leHBvcnQgY29uc3QgVEFCX0NMT1NFID0gXCJ0YWJzLmNsb3NlXCI7XG5leHBvcnQgY29uc3QgVEFCX0NMT1NFX0ZPUkNFID0gXCJ0YWJzLmNsb3NlLmZvcmNlXCI7XG5leHBvcnQgY29uc3QgVEFCX0NMT1NFX1JJR0hUID0gXCJ0YWJzLmNsb3NlLnJpZ2h0XCI7XG5leHBvcnQgY29uc3QgVEFCX1JFT1BFTiA9IFwidGFicy5yZW9wZW5cIjtcbmV4cG9ydCBjb25zdCBUQUJfUFJFViA9IFwidGFicy5wcmV2XCI7XG5leHBvcnQgY29uc3QgVEFCX05FWFQgPSBcInRhYnMubmV4dFwiO1xuZXhwb3J0IGNvbnN0IFRBQl9GSVJTVCA9IFwidGFicy5maXJzdFwiO1xuZXhwb3J0IGNvbnN0IFRBQl9MQVNUID0gXCJ0YWJzLmxhc3RcIjtcbmV4cG9ydCBjb25zdCBUQUJfUFJFVl9TRUwgPSBcInRhYnMucHJldnNlbFwiO1xuZXhwb3J0IGNvbnN0IFRBQl9SRUxPQUQgPSBcInRhYnMucmVsb2FkXCI7XG5leHBvcnQgY29uc3QgVEFCX1BJTiA9IFwidGFicy5waW5cIjtcbmV4cG9ydCBjb25zdCBUQUJfVU5QSU4gPSBcInRhYnMudW5waW5cIjtcbmV4cG9ydCBjb25zdCBUQUJfVE9HR0xFX1BJTk5FRCA9IFwidGFicy5waW4udG9nZ2xlXCI7XG5leHBvcnQgY29uc3QgVEFCX0RVUExJQ0FURSA9IFwidGFicy5kdXBsaWNhdGVcIjtcbmV4cG9ydCBjb25zdCBUQUJfVE9HR0xFX1JFQURFUiA9IFwidGFicy5yZWFkZXIudG9nZ2xlXCI7XG5cbi8vIFpvb21zXG5leHBvcnQgY29uc3QgWk9PTV9JTiA9IFwiem9vbS5pblwiO1xuZXhwb3J0IGNvbnN0IFpPT01fT1VUID0gXCJ6b29tLm91dFwiO1xuZXhwb3J0IGNvbnN0IFpPT01fTkVVVFJBTCA9IFwiem9vbS5uZXV0cmFsXCI7XG5cbi8vIFVybCB5YW5rL3Bhc3RlXG5leHBvcnQgY29uc3QgVVJMU19ZQU5LID0gXCJ1cmxzLnlhbmtcIjtcbmV4cG9ydCBjb25zdCBVUkxTX1BBU1RFID0gXCJ1cmxzLnBhc3RlXCI7XG5cbi8vIEZpbmRcbmV4cG9ydCBjb25zdCBGSU5EX1NUQVJUID0gXCJmaW5kLnN0YXJ0XCI7XG5leHBvcnQgY29uc3QgRklORF9ORVhUID0gXCJmaW5kLm5leHRcIjtcbmV4cG9ydCBjb25zdCBGSU5EX1BSRVYgPSBcImZpbmQucHJldlwiO1xuXG4vLyBNYXJrXG5leHBvcnQgY29uc3QgTUFSS19TRVRfUFJFRklYID0gXCJtYXJrLnNldC5wcmVmaXhcIjtcbmV4cG9ydCBjb25zdCBNQVJLX0pVTVBfUFJFRklYID0gXCJtYXJrLmp1bXAucHJlZml4XCI7XG5cbi8vIFJlcGVhdFxuZXhwb3J0IGNvbnN0IFJFUEVBVF9MQVNUID0gXCJyZXBlYXQubGFzdFwiO1xuXG4vLyBJbnRlcm5hbFxuZXhwb3J0IGNvbnN0IElOVEVSTkFMX09QRU5fVVJMID0gXCJpbnRlcm5hbC5vcGVuLnVybFwiO1xuXG5leHBvcnQgaW50ZXJmYWNlIENhbmNlbE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBDQU5DRUw7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQWRkb25FbmFibGVPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgQURET05fRU5BQkxFO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIEFkZG9uRGlzYWJsZU9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBBRERPTl9ESVNBQkxFO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIEFkZG9uVG9nZ2xlRW5hYmxlZE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBBRERPTl9UT0dHTEVfRU5BQkxFRDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb21tYW5kU2hvd09wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBDT01NQU5EX1NIT1c7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29tbWFuZFNob3dPcGVuT3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIENPTU1BTkRfU0hPV19PUEVOO1xuICBhbHRlcjogYm9vbGVhbjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb21tYW5kU2hvd1RhYm9wZW5PcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgQ09NTUFORF9TSE9XX1RBQk9QRU47XG4gIGFsdGVyOiBib29sZWFuO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIENvbW1hbmRTaG93V2lub3Blbk9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBDT01NQU5EX1NIT1dfV0lOT1BFTjtcbiAgYWx0ZXI6IGJvb2xlYW47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29tbWFuZFNob3dCdWZmZXJPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgQ09NTUFORF9TSE9XX0JVRkZFUjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb21tYW5kU2hvd0FkZGJvb2ttYXJrT3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIENPTU1BTkRfU0hPV19BRERCT09LTUFSSztcbiAgYWx0ZXI6IGJvb2xlYW47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgU2Nyb2xsVmVydGljYWxseU9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBTQ1JPTExfVkVSVElDQUxMWTtcbiAgY291bnQ6IG51bWJlcjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBTY3JvbGxIb3Jpem9uYWxseU9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBTQ1JPTExfSE9SSVpPTkFMTFk7XG4gIGNvdW50OiBudW1iZXI7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgU2Nyb2xsUGFnZXNPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgU0NST0xMX1BBR0VTO1xuICBjb3VudDogbnVtYmVyO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFNjcm9sbFRvcE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBTQ1JPTExfVE9QO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFNjcm9sbEJvdHRvbU9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBTQ1JPTExfQk9UVE9NO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFNjcm9sbEhvbWVPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgU0NST0xMX0hPTUU7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgU2Nyb2xsRW5kT3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIFNDUk9MTF9FTkQ7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgRm9sbG93U3RhcnRPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgRk9MTE9XX1NUQVJUO1xuICBuZXdUYWI6IGJvb2xlYW47XG4gIGJhY2tncm91bmQ6IGJvb2xlYW47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgTmF2aWdhdGVIaXN0b3J5UHJldk9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBOQVZJR0FURV9ISVNUT1JZX1BSRVY7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgTmF2aWdhdGVIaXN0b3J5TmV4dE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBOQVZJR0FURV9ISVNUT1JZX05FWFQ7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgTmF2aWdhdGVMaW5rUHJldk9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBOQVZJR0FURV9MSU5LX1BSRVY7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgTmF2aWdhdGVMaW5rTmV4dE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBOQVZJR0FURV9MSU5LX05FWFQ7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgTmF2aWdhdGVQYXJlbnRPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgTkFWSUdBVEVfUEFSRU5UO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIE5hdmlnYXRlUm9vdE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBOQVZJR0FURV9ST09UO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIEZvY3VzSW5wdXRPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgRk9DVVNfSU5QVVQ7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgUGFnZVNvdXJjZU9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBQQUdFX1NPVVJDRTtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBQYWdlSG9tZU9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBQQUdFX0hPTUU7XG4gIG5ld1RhYjogYm9vbGVhbjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBUYWJDbG9zZU9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBUQUJfQ0xPU0U7XG4gIHNlbGVjdD86IFwibGVmdFwiIHwgXCJyaWdodFwiO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFRhYkNsb3NlRm9yY2VPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgVEFCX0NMT1NFX0ZPUkNFO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFRhYkNsb3NlUmlnaHRPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgVEFCX0NMT1NFX1JJR0hUO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFRhYlJlb3Blbk9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBUQUJfUkVPUEVOO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFRhYlByZXZPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgVEFCX1BSRVY7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgVGFiTmV4dE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBUQUJfTkVYVDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBUYWJGaXJzdE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBUQUJfRklSU1Q7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgVGFiTGFzdE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBUQUJfTEFTVDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBUYWJQcmV2U2VsT3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIFRBQl9QUkVWX1NFTDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBUYWJSZWxvYWRPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgVEFCX1JFTE9BRDtcbiAgY2FjaGU6IGJvb2xlYW47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgVGFiUGluT3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIFRBQl9QSU47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgVGFiVW5waW5PcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgVEFCX1VOUElOO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFRhYlRvZ2dsZVBpbm5lZE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBUQUJfVE9HR0xFX1BJTk5FRDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBUYWJEdXBsaWNhdGVPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgVEFCX0RVUExJQ0FURTtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBUYWJUb2dnbGVSZWFkZXJPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgVEFCX1RPR0dMRV9SRUFERVI7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgWm9vbUluT3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIFpPT01fSU47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgWm9vbU91dE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBaT09NX09VVDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBab29tTmV1dHJhbE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBaT09NX05FVVRSQUw7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgVXJsc1lhbmtPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgVVJMU19ZQU5LO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFVybHNQYXN0ZU9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBVUkxTX1BBU1RFO1xuICBuZXdUYWI6IGJvb2xlYW47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgRmluZFN0YXJ0T3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIEZJTkRfU1RBUlQ7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgRmluZE5leHRPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgRklORF9ORVhUO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIEZpbmRQcmV2T3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIEZJTkRfUFJFVjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBNYXJrU2V0UHJlZml4T3BlcmF0aW9uIHtcbiAgdHlwZTogdHlwZW9mIE1BUktfU0VUX1BSRUZJWDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBNYXJrSnVtcFByZWZpeE9wZXJhdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBNQVJLX0pVTVBfUFJFRklYO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFJlcGVhdExhc3RPcGVyYXRpb24ge1xuICB0eXBlOiB0eXBlb2YgUkVQRUFUX0xBU1Q7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgSW50ZXJuYWxPcGVuVXJsIHtcbiAgdHlwZTogdHlwZW9mIElOVEVSTkFMX09QRU5fVVJMO1xuICB1cmw6IHN0cmluZztcbiAgbmV3VGFiPzogYm9vbGVhbjtcbiAgbmV3V2luZG93PzogYm9vbGVhbjtcbiAgYmFja2dyb3VuZD86IGJvb2xlYW47XG59XG5cbmV4cG9ydCB0eXBlIE9wZXJhdGlvbiA9XG4gIHwgQ2FuY2VsT3BlcmF0aW9uXG4gIHwgQWRkb25FbmFibGVPcGVyYXRpb25cbiAgfCBBZGRvbkRpc2FibGVPcGVyYXRpb25cbiAgfCBBZGRvblRvZ2dsZUVuYWJsZWRPcGVyYXRpb25cbiAgfCBDb21tYW5kU2hvd09wZXJhdGlvblxuICB8IENvbW1hbmRTaG93T3Blbk9wZXJhdGlvblxuICB8IENvbW1hbmRTaG93VGFib3Blbk9wZXJhdGlvblxuICB8IENvbW1hbmRTaG93V2lub3Blbk9wZXJhdGlvblxuICB8IENvbW1hbmRTaG93QnVmZmVyT3BlcmF0aW9uXG4gIHwgQ29tbWFuZFNob3dBZGRib29rbWFya09wZXJhdGlvblxuICB8IFNjcm9sbFZlcnRpY2FsbHlPcGVyYXRpb25cbiAgfCBTY3JvbGxIb3Jpem9uYWxseU9wZXJhdGlvblxuICB8IFNjcm9sbFBhZ2VzT3BlcmF0aW9uXG4gIHwgU2Nyb2xsVG9wT3BlcmF0aW9uXG4gIHwgU2Nyb2xsQm90dG9tT3BlcmF0aW9uXG4gIHwgU2Nyb2xsSG9tZU9wZXJhdGlvblxuICB8IFNjcm9sbEVuZE9wZXJhdGlvblxuICB8IEZvbGxvd1N0YXJ0T3BlcmF0aW9uXG4gIHwgTmF2aWdhdGVIaXN0b3J5UHJldk9wZXJhdGlvblxuICB8IE5hdmlnYXRlSGlzdG9yeU5leHRPcGVyYXRpb25cbiAgfCBOYXZpZ2F0ZUxpbmtQcmV2T3BlcmF0aW9uXG4gIHwgTmF2aWdhdGVMaW5rTmV4dE9wZXJhdGlvblxuICB8IE5hdmlnYXRlUGFyZW50T3BlcmF0aW9uXG4gIHwgTmF2aWdhdGVSb290T3BlcmF0aW9uXG4gIHwgRm9jdXNJbnB1dE9wZXJhdGlvblxuICB8IFBhZ2VTb3VyY2VPcGVyYXRpb25cbiAgfCBQYWdlSG9tZU9wZXJhdGlvblxuICB8IFRhYkNsb3NlT3BlcmF0aW9uXG4gIHwgVGFiQ2xvc2VGb3JjZU9wZXJhdGlvblxuICB8IFRhYkNsb3NlUmlnaHRPcGVyYXRpb25cbiAgfCBUYWJSZW9wZW5PcGVyYXRpb25cbiAgfCBUYWJQcmV2T3BlcmF0aW9uXG4gIHwgVGFiTmV4dE9wZXJhdGlvblxuICB8IFRhYkZpcnN0T3BlcmF0aW9uXG4gIHwgVGFiTGFzdE9wZXJhdGlvblxuICB8IFRhYlByZXZTZWxPcGVyYXRpb25cbiAgfCBUYWJSZWxvYWRPcGVyYXRpb25cbiAgfCBUYWJQaW5PcGVyYXRpb25cbiAgfCBUYWJVbnBpbk9wZXJhdGlvblxuICB8IFRhYlRvZ2dsZVBpbm5lZE9wZXJhdGlvblxuICB8IFRhYkR1cGxpY2F0ZU9wZXJhdGlvblxuICB8IFRhYlRvZ2dsZVJlYWRlck9wZXJhdGlvblxuICB8IFpvb21Jbk9wZXJhdGlvblxuICB8IFpvb21PdXRPcGVyYXRpb25cbiAgfCBab29tTmV1dHJhbE9wZXJhdGlvblxuICB8IFVybHNZYW5rT3BlcmF0aW9uXG4gIHwgVXJsc1Bhc3RlT3BlcmF0aW9uXG4gIHwgRmluZFN0YXJ0T3BlcmF0aW9uXG4gIHwgRmluZE5leHRPcGVyYXRpb25cbiAgfCBGaW5kUHJldk9wZXJhdGlvblxuICB8IE1hcmtTZXRQcmVmaXhPcGVyYXRpb25cbiAgfCBNYXJrSnVtcFByZWZpeE9wZXJhdGlvblxuICB8IFJlcGVhdExhc3RPcGVyYXRpb25cbiAgfCBJbnRlcm5hbE9wZW5Vcmw7XG5cbmNvbnN0IGFzc2VydE9wdGlvbmFsQm9vbGVhbiA9IChvYmo6IGFueSwgbmFtZTogc3RyaW5nKSA9PiB7XG4gIGlmIChcbiAgICBPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwob2JqLCBuYW1lKSAmJlxuICAgIHR5cGVvZiBvYmpbbmFtZV0gIT09IFwiYm9vbGVhblwiXG4gICkge1xuICAgIHRocm93IG5ldyBUeXBlRXJyb3IoXG4gICAgICBgTm90IGEgYm9vbGVhbiBwYXJhbWV0ZXI6ICcke25hbWV9ICgke3R5cGVvZiBvYmpbbmFtZV19KSdgXG4gICAgKTtcbiAgfVxufTtcblxuY29uc3QgYXNzZXJ0T3B0aW9uYWxTdHJpbmcgPSAob2JqOiBhbnksIG5hbWU6IHN0cmluZywgdmFsdWVzPzogc3RyaW5nW10pID0+IHtcbiAgaWYgKE9iamVjdC5wcm90b3R5cGUuaGFzT3duUHJvcGVydHkuY2FsbChvYmosIG5hbWUpKSB7XG4gICAgY29uc3QgdmFsdWUgPSBvYmpbbmFtZV07XG4gICAgaWYgKHR5cGVvZiB2YWx1ZSAhPT0gXCJzdHJpbmdcIikge1xuICAgICAgdGhyb3cgbmV3IFR5cGVFcnJvcihcbiAgICAgICAgYE5vdCBhIHN0cmluZyBwYXJhbWV0ZXI6ICcke25hbWV9JyAoJHt0eXBlb2YgdmFsdWV9KWBcbiAgICAgICk7XG4gICAgfVxuICAgIGlmICh2YWx1ZXMgJiYgdmFsdWVzLmxlbmd0aCAmJiB2YWx1ZXMuaW5kZXhPZih2YWx1ZSkgPT09IC0xKSB7XG4gICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbWF4LWxlblxuICAgICAgdGhyb3cgbmV3IFR5cGVFcnJvcihgSW52YWxpZCBwYXJhbWV0ZXIgZm9yICcke25hbWV9JzogJyR7dmFsdWV9J2ApO1xuICAgIH1cbiAgfVxufTtcblxuY29uc3QgYXNzZXJ0UmVxdWlyZWROdW1iZXIgPSAob2JqOiBhbnksIG5hbWU6IHN0cmluZykgPT4ge1xuICBpZiAoXG4gICAgIU9iamVjdC5wcm90b3R5cGUuaGFzT3duUHJvcGVydHkuY2FsbChvYmosIG5hbWUpIHx8XG4gICAgdHlwZW9mIG9ialtuYW1lXSAhPT0gXCJudW1iZXJcIlxuICApIHtcbiAgICB0aHJvdyBuZXcgVHlwZUVycm9yKGBNaXNzaW5nIG51bWJlciBwYXJhbWV0ZXI6ICcke25hbWV9YCk7XG4gIH1cbn07XG5cbmNvbnN0IGFzc2VydFJlcXVpcmVkU3RyaW5nID0gKG9iajogYW55LCBuYW1lOiBzdHJpbmcpID0+IHtcbiAgaWYgKFxuICAgICFPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwob2JqLCBuYW1lKSB8fFxuICAgIHR5cGVvZiBvYmpbbmFtZV0gIT09IFwic3RyaW5nXCJcbiAgKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcihgTWlzc2luZyBzdHJpbmcgcGFyYW1ldGVyOiAnJHtuYW1lfWApO1xuICB9XG59O1xuXG4vLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgY29tcGxleGl0eSwgbWF4LWxpbmVzLXBlci1mdW5jdGlvblxuZXhwb3J0IGNvbnN0IHZhbHVlT2YgPSAobzogYW55KTogT3BlcmF0aW9uID0+IHtcbiAgaWYgKCFPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwobywgXCJ0eXBlXCIpKSB7XG4gICAgdGhyb3cgbmV3IFR5cGVFcnJvcihgTWlzc2luZyAndHlwZScgZmllbGRgKTtcbiAgfVxuICBzd2l0Y2ggKG8udHlwZSkge1xuICAgIGNhc2UgQ09NTUFORF9TSE9XX09QRU46XG4gICAgY2FzZSBDT01NQU5EX1NIT1dfVEFCT1BFTjpcbiAgICBjYXNlIENPTU1BTkRfU0hPV19XSU5PUEVOOlxuICAgIGNhc2UgQ09NTUFORF9TSE9XX0FEREJPT0tNQVJLOlxuICAgICAgYXNzZXJ0T3B0aW9uYWxCb29sZWFuKG8sIFwiYWx0ZXJcIik7XG4gICAgICByZXR1cm4geyB0eXBlOiBvLnR5cGUsIGFsdGVyOiBCb29sZWFuKG8uYWx0ZXIpIH07XG4gICAgY2FzZSBTQ1JPTExfVkVSVElDQUxMWTpcbiAgICBjYXNlIFNDUk9MTF9IT1JJWk9OQUxMWTpcbiAgICBjYXNlIFNDUk9MTF9QQUdFUzpcbiAgICAgIGFzc2VydFJlcXVpcmVkTnVtYmVyKG8sIFwiY291bnRcIik7XG4gICAgICByZXR1cm4geyB0eXBlOiBvLnR5cGUsIGNvdW50OiBOdW1iZXIoby5jb3VudCkgfTtcbiAgICBjYXNlIEZPTExPV19TVEFSVDpcbiAgICAgIGFzc2VydE9wdGlvbmFsQm9vbGVhbihvLCBcIm5ld1RhYlwiKTtcbiAgICAgIGFzc2VydE9wdGlvbmFsQm9vbGVhbihvLCBcImJhY2tncm91bmRcIik7XG4gICAgICByZXR1cm4ge1xuICAgICAgICB0eXBlOiBGT0xMT1dfU1RBUlQsXG4gICAgICAgIG5ld1RhYjogQm9vbGVhbih0eXBlb2Ygby5uZXdUYWIgPT09IFwidW5kZWZpbmVkXCIgPyBmYWxzZSA6IG8ubmV3VGFiKSxcbiAgICAgICAgYmFja2dyb3VuZDogQm9vbGVhbihcbiAgICAgICAgICB0eXBlb2Ygby5iYWNrZ3JvdW5kID09PSBcInVuZGVmaW5lZFwiID8gdHJ1ZSA6IG8uYmFja2dyb3VuZFxuICAgICAgICApLCAvLyBlc2xpbnQtZGlzYWJsZS1saW5lIG1heC1sZW5cbiAgICAgIH07XG4gICAgY2FzZSBQQUdFX0hPTUU6XG4gICAgICBhc3NlcnRPcHRpb25hbEJvb2xlYW4obywgXCJuZXdUYWJcIik7XG4gICAgICByZXR1cm4ge1xuICAgICAgICB0eXBlOiBQQUdFX0hPTUUsXG4gICAgICAgIG5ld1RhYjogQm9vbGVhbih0eXBlb2Ygby5uZXdUYWIgPT09IFwidW5kZWZpbmVkXCIgPyBmYWxzZSA6IG8ubmV3VGFiKSxcbiAgICAgIH07XG4gICAgY2FzZSBUQUJfQ0xPU0U6XG4gICAgICBhc3NlcnRPcHRpb25hbFN0cmluZyhvLCBcInNlbGVjdFwiLCBbXCJsZWZ0XCIsIFwicmlnaHRcIl0pO1xuICAgICAgcmV0dXJuIHtcbiAgICAgICAgdHlwZTogVEFCX0NMT1NFLFxuICAgICAgICBzZWxlY3Q6IHR5cGVvZiBvLnNlbGVjdCA9PT0gXCJ1bmRlZmluZWRcIiA/IFwicmlnaHRcIiA6IG8uc2VsZWN0LFxuICAgICAgfTtcbiAgICBjYXNlIFRBQl9SRUxPQUQ6XG4gICAgICBhc3NlcnRPcHRpb25hbEJvb2xlYW4obywgXCJjYWNoZVwiKTtcbiAgICAgIHJldHVybiB7XG4gICAgICAgIHR5cGU6IFRBQl9SRUxPQUQsXG4gICAgICAgIGNhY2hlOiBCb29sZWFuKHR5cGVvZiBvLmNhY2hlID09PSBcInVuZGVmaW5lZFwiID8gZmFsc2UgOiBvLmNhY2hlKSxcbiAgICAgIH07XG4gICAgY2FzZSBVUkxTX1BBU1RFOlxuICAgICAgYXNzZXJ0T3B0aW9uYWxCb29sZWFuKG8sIFwibmV3VGFiXCIpO1xuICAgICAgcmV0dXJuIHtcbiAgICAgICAgdHlwZTogVVJMU19QQVNURSxcbiAgICAgICAgbmV3VGFiOiBCb29sZWFuKHR5cGVvZiBvLm5ld1RhYiA9PT0gXCJ1bmRlZmluZWRcIiA/IGZhbHNlIDogby5uZXdUYWIpLFxuICAgICAgfTtcbiAgICBjYXNlIElOVEVSTkFMX09QRU5fVVJMOlxuICAgICAgYXNzZXJ0T3B0aW9uYWxCb29sZWFuKG8sIFwibmV3VGFiXCIpO1xuICAgICAgYXNzZXJ0T3B0aW9uYWxCb29sZWFuKG8sIFwibmV3V2luZG93XCIpO1xuICAgICAgYXNzZXJ0T3B0aW9uYWxCb29sZWFuKG8sIFwiYmFja2dyb3VuZFwiKTtcbiAgICAgIGFzc2VydFJlcXVpcmVkU3RyaW5nKG8sIFwidXJsXCIpO1xuICAgICAgcmV0dXJuIHtcbiAgICAgICAgdHlwZTogSU5URVJOQUxfT1BFTl9VUkwsXG4gICAgICAgIHVybDogby51cmwsXG4gICAgICAgIG5ld1RhYjogQm9vbGVhbih0eXBlb2Ygby5uZXdUYWIgPT09IFwidW5kZWZpbmVkXCIgPyBmYWxzZSA6IG8ubmV3VGFiKSxcbiAgICAgICAgbmV3V2luZG93OiBCb29sZWFuKFxuICAgICAgICAgIHR5cGVvZiBvLm5ld1dpbmRvdyA9PT0gXCJ1bmRlZmluZWRcIiA/IGZhbHNlIDogby5uZXdXaW5kb3dcbiAgICAgICAgKSwgLy8gZXNsaW50LWRpc2FibGUtbGluZSBtYXgtbGVuXG4gICAgICAgIGJhY2tncm91bmQ6IEJvb2xlYW4oXG4gICAgICAgICAgdHlwZW9mIG8uYmFja2dyb3VuZCA9PT0gXCJ1bmRlZmluZWRcIiA/IHRydWUgOiBvLmJhY2tncm91bmRcbiAgICAgICAgKSwgLy8gZXNsaW50LWRpc2FibGUtbGluZSBtYXgtbGVuXG4gICAgICB9O1xuICAgIGNhc2UgQ0FOQ0VMOlxuICAgIGNhc2UgQURET05fRU5BQkxFOlxuICAgIGNhc2UgQURET05fRElTQUJMRTpcbiAgICBjYXNlIEFERE9OX1RPR0dMRV9FTkFCTEVEOlxuICAgIGNhc2UgQ09NTUFORF9TSE9XOlxuICAgIGNhc2UgQ09NTUFORF9TSE9XX0JVRkZFUjpcbiAgICBjYXNlIFNDUk9MTF9UT1A6XG4gICAgY2FzZSBTQ1JPTExfQk9UVE9NOlxuICAgIGNhc2UgU0NST0xMX0hPTUU6XG4gICAgY2FzZSBTQ1JPTExfRU5EOlxuICAgIGNhc2UgTkFWSUdBVEVfSElTVE9SWV9QUkVWOlxuICAgIGNhc2UgTkFWSUdBVEVfSElTVE9SWV9ORVhUOlxuICAgIGNhc2UgTkFWSUdBVEVfTElOS19QUkVWOlxuICAgIGNhc2UgTkFWSUdBVEVfTElOS19ORVhUOlxuICAgIGNhc2UgTkFWSUdBVEVfUEFSRU5UOlxuICAgIGNhc2UgTkFWSUdBVEVfUk9PVDpcbiAgICBjYXNlIEZPQ1VTX0lOUFVUOlxuICAgIGNhc2UgUEFHRV9TT1VSQ0U6XG4gICAgY2FzZSBUQUJfQ0xPU0VfRk9SQ0U6XG4gICAgY2FzZSBUQUJfQ0xPU0VfUklHSFQ6XG4gICAgY2FzZSBUQUJfUkVPUEVOOlxuICAgIGNhc2UgVEFCX1BSRVY6XG4gICAgY2FzZSBUQUJfTkVYVDpcbiAgICBjYXNlIFRBQl9GSVJTVDpcbiAgICBjYXNlIFRBQl9MQVNUOlxuICAgIGNhc2UgVEFCX1BSRVZfU0VMOlxuICAgIGNhc2UgVEFCX1BJTjpcbiAgICBjYXNlIFRBQl9VTlBJTjpcbiAgICBjYXNlIFRBQl9UT0dHTEVfUElOTkVEOlxuICAgIGNhc2UgVEFCX0RVUExJQ0FURTpcbiAgICBjYXNlIFRBQl9UT0dHTEVfUkVBREVSOlxuICAgIGNhc2UgWk9PTV9JTjpcbiAgICBjYXNlIFpPT01fT1VUOlxuICAgIGNhc2UgWk9PTV9ORVVUUkFMOlxuICAgIGNhc2UgVVJMU19ZQU5LOlxuICAgIGNhc2UgRklORF9TVEFSVDpcbiAgICBjYXNlIEZJTkRfTkVYVDpcbiAgICBjYXNlIEZJTkRfUFJFVjpcbiAgICBjYXNlIE1BUktfU0VUX1BSRUZJWDpcbiAgICBjYXNlIE1BUktfSlVNUF9QUkVGSVg6XG4gICAgY2FzZSBSRVBFQVRfTEFTVDpcbiAgICAgIHJldHVybiB7IHR5cGU6IG8udHlwZSB9O1xuICB9XG4gIHRocm93IG5ldyBUeXBlRXJyb3IoXCJVbmtub3duIG9wZXJhdGlvbiB0eXBlOiBcIiArIG8udHlwZSk7XG59O1xuXG5leHBvcnQgY29uc3QgaXNOUmVwZWF0YWJsZSA9ICh0eXBlOiBzdHJpbmcpOiBib29sZWFuID0+IHtcbiAgc3dpdGNoICh0eXBlKSB7XG4gICAgY2FzZSBTQ1JPTExfVkVSVElDQUxMWTpcbiAgICBjYXNlIFNDUk9MTF9IT1JJWk9OQUxMWTpcbiAgICBjYXNlIFNDUk9MTF9QQUdFUzpcbiAgICBjYXNlIE5BVklHQVRFX0hJU1RPUllfUFJFVjpcbiAgICBjYXNlIE5BVklHQVRFX0hJU1RPUllfTkVYVDpcbiAgICBjYXNlIE5BVklHQVRFX1BBUkVOVDpcbiAgICBjYXNlIFRBQl9DTE9TRTpcbiAgICBjYXNlIFRBQl9DTE9TRV9GT1JDRTpcbiAgICBjYXNlIFRBQl9DTE9TRV9SSUdIVDpcbiAgICBjYXNlIFRBQl9SRU9QRU46XG4gICAgY2FzZSBUQUJfUFJFVjpcbiAgICBjYXNlIFRBQl9ORVhUOlxuICAgIGNhc2UgVEFCX0RVUExJQ0FURTpcbiAgICBjYXNlIFpPT01fSU46XG4gICAgY2FzZSBaT09NX09VVDpcbiAgICBjYXNlIFVSTFNfUEFTVEU6XG4gICAgY2FzZSBGSU5EX05FWFQ6XG4gICAgY2FzZSBGSU5EX1BSRVY6XG4gICAgY2FzZSBSRVBFQVRfTEFTVDpcbiAgICAgIHJldHVybiB0cnVlO1xuICB9XG4gIHJldHVybiBmYWxzZTtcbn07XG4iLCJpbXBvcnQgKiBhcyBvcGVyYXRpb25zIGZyb20gXCIuL29wZXJhdGlvbnNcIjtcbmltcG9ydCBDb21wbGV0aW9uVHlwZSBmcm9tIFwiLi9Db21wbGV0aW9uVHlwZVwiO1xuaW1wb3J0IFRhYkZsYWcgZnJvbSBcIi4vVGFiRmxhZ1wiO1xuXG5leHBvcnQgY29uc3QgQkFDS0dST1VORF9PUEVSQVRJT04gPSBcImJhY2tncm91bmQub3BlcmF0aW9uXCI7XG5cbmV4cG9ydCBjb25zdCBDT05TT0xFX1VORk9DVVMgPSBcImNvbnNvbGUudW5mb2N1c1wiO1xuZXhwb3J0IGNvbnN0IENPTlNPTEVfRU5URVJfQ09NTUFORCA9IFwiY29uc29sZS5lbnRlci5jb21tYW5kXCI7XG5leHBvcnQgY29uc3QgQ09OU09MRV9FTlRFUl9GSU5EID0gXCJjb25zb2xlLmVudGVyLmZpbmRcIjtcbmV4cG9ydCBjb25zdCBDT05TT0xFX1NIT1dfQ09NTUFORCA9IFwiY29uc29sZS5zaG93LmNvbW1hbmRcIjtcbmV4cG9ydCBjb25zdCBDT05TT0xFX1NIT1dfRVJST1IgPSBcImNvbnNvbGUuc2hvdy5lcnJvclwiO1xuZXhwb3J0IGNvbnN0IENPTlNPTEVfU0hPV19JTkZPID0gXCJjb25zb2xlLnNob3cuaW5mb1wiO1xuZXhwb3J0IGNvbnN0IENPTlNPTEVfU0hPV19GSU5EID0gXCJjb25zb2xlLnNob3cuZmluZFwiO1xuZXhwb3J0IGNvbnN0IENPTlNPTEVfSElERSA9IFwiY29uc29sZS5oaWRlXCI7XG5leHBvcnQgY29uc3QgQ09OU09MRV9HRVRfQ09NUExFVElPTl9UWVBFUyA9IFwiY29uc29sZS5nZXQuY29tcGxldGlvbi50eXBlc1wiO1xuZXhwb3J0IGNvbnN0IENPTlNPTEVfUkVRVUVTVF9TRUFSQ0hfRU5HSU5FU19NRVNTQUdFID1cbiAgXCJjb25zb2xlLnFyZXN1dC5zZWFyY2hFbmdpbmVzXCI7XG5leHBvcnQgY29uc3QgQ09OU09MRV9SRVFVRVNUX0JPT0tNQVJLUyA9IFwiY29uc29sZS5yZXF1ZXN0LmJvb2ttYXJrc1wiO1xuZXhwb3J0IGNvbnN0IENPTlNPTEVfUkVRVUVTVF9ISVNUT1JZID0gXCJjb25zb2xlLnJlcXVlc3QuaGlzdG9yeVwiO1xuZXhwb3J0IGNvbnN0IENPTlNPTEVfUkVRVUVTVF9UQUJTID0gXCJjb25zb2xlLnJlcXVlc3QudGFic1wiO1xuZXhwb3J0IGNvbnN0IENPTlNPTEVfR0VUX1BST1BFUlRJRVMgPSBcImNvbnNvbGUuZ2V0LnByb3BlcnRpZXNcIjtcbmV4cG9ydCBjb25zdCBDT05TT0xFX1JFU0laRSA9IFwiY29uc29sZS5yZXNpemVcIjtcblxuZXhwb3J0IGNvbnN0IEZPTExPV19TVEFSVCA9IFwiZm9sbG93LnN0YXJ0XCI7XG5leHBvcnQgY29uc3QgRk9MTE9XX1JFUVVFU1RfQ09VTlRfVEFSR0VUUyA9IFwiZm9sbG93LnJlcXVlc3QuY291bnQudGFyZ2V0c1wiO1xuZXhwb3J0IGNvbnN0IEZPTExPV19SRVNQT05TRV9DT1VOVF9UQVJHRVRTID0gXCJmb2xsb3cucmVzcG9uc2UuY291bnQudGFyZ2V0c1wiO1xuZXhwb3J0IGNvbnN0IEZPTExPV19DUkVBVEVfSElOVFMgPSBcImZvbGxvdy5jcmVhdGUuaGludHNcIjtcbmV4cG9ydCBjb25zdCBGT0xMT1dfU0hPV19ISU5UUyA9IFwiZm9sbG93LnVwZGF0ZS5oaW50c1wiO1xuZXhwb3J0IGNvbnN0IEZPTExPV19SRU1PVkVfSElOVFMgPSBcImZvbGxvdy5yZW1vdmUuaGludHNcIjtcbmV4cG9ydCBjb25zdCBGT0xMT1dfQUNUSVZBVEUgPSBcImZvbGxvdy5hY3RpdmF0ZVwiO1xuZXhwb3J0IGNvbnN0IEZPTExPV19LRVlfUFJFU1MgPSBcImZvbGxvdy5rZXkucHJlc3NcIjtcblxuZXhwb3J0IGNvbnN0IE1BUktfU0VUX0dMT0JBTCA9IFwibWFyay5zZXQuZ2xvYmFsXCI7XG5leHBvcnQgY29uc3QgTUFSS19KVU1QX0dMT0JBTCA9IFwibWFyay5qdW1wLmdsb2JhbFwiO1xuXG5leHBvcnQgY29uc3QgVEFCX1NDUk9MTF9UTyA9IFwidGFiLnNjcm9sbC50b1wiO1xuXG5leHBvcnQgY29uc3QgRklORF9ORVhUID0gXCJmaW5kLm5leHRcIjtcbmV4cG9ydCBjb25zdCBGSU5EX1BSRVYgPSBcImZpbmQucHJldlwiO1xuZXhwb3J0IGNvbnN0IEZJTkRfQ0xFQVJfU0VMRUNUSU9OID0gXCJmaW5kLmNsZWFyLnNlbGVjdGlvblwiO1xuXG5leHBvcnQgY29uc3QgQURET05fRU5BQkxFRF9RVUVSWSA9IFwiYWRkb24uZW5hYmxlZC5xdWVyeVwiO1xuZXhwb3J0IGNvbnN0IEFERE9OX0VOQUJMRURfUkVTUE9OU0UgPSBcImFkZG9uLmVuYWJsZWQucmVzcG9uc2VcIjtcbmV4cG9ydCBjb25zdCBBRERPTl9UT0dHTEVfRU5BQkxFRCA9IFwiYWRkb24udG9nZ2xlLmVuYWJsZWRcIjtcblxuZXhwb3J0IGNvbnN0IE9QRU5fVVJMID0gXCJvcGVuLnVybFwiO1xuXG5leHBvcnQgY29uc3QgU0VUVElOR1NfQ0hBTkdFRCA9IFwic2V0dGluZ3MuY2hhbmdlZFwiO1xuZXhwb3J0IGNvbnN0IFNFVFRJTkdTX1FVRVJZID0gXCJzZXR0aW5ncy5xdWVyeVwiO1xuXG5leHBvcnQgY29uc3QgQ09OU09MRV9GUkFNRV9NRVNTQUdFID0gXCJjb25zb2xlLmZyYW1lLm1lc3NhZ2VcIjtcblxuZXhwb3J0IGNvbnN0IE5BVklHQVRFX0hJU1RPUllfTkVYVCA9IFwibmF2aWdhdGUuaGlzdG9yeS5uZXh0XCI7XG5leHBvcnQgY29uc3QgTkFWSUdBVEVfSElTVE9SWV9QUkVWID0gXCJuYXZpZ2F0ZS5oaXN0b3J5LnByZXZcIjtcbmV4cG9ydCBjb25zdCBOQVZJR0FURV9MSU5LX05FWFQgPSBcIm5hdmlnYXRlLmxpbmsubmV4dFwiO1xuZXhwb3J0IGNvbnN0IE5BVklHQVRFX0xJTktfUFJFViA9IFwibmF2aWdhdGUubGluay5wcmV2XCI7XG5cbmV4cG9ydCBpbnRlcmZhY2UgQmFja2dyb3VuZE9wZXJhdGlvbk1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQkFDS0dST1VORF9PUEVSQVRJT047XG4gIHJlcGVhdDogbnVtYmVyO1xuICBvcGVyYXRpb246IG9wZXJhdGlvbnMuT3BlcmF0aW9uO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIENvbnNvbGVVbmZvY3VzTWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBDT05TT0xFX1VORk9DVVM7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29uc29sZUVudGVyQ29tbWFuZE1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQ09OU09MRV9FTlRFUl9DT01NQU5EO1xuICB0ZXh0OiBzdHJpbmc7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29uc29sZUVudGVyRmluZE1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQ09OU09MRV9FTlRFUl9GSU5EO1xuICBrZXl3b3JkPzogc3RyaW5nO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIENvbnNvbGVTaG93Q29tbWFuZE1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQ09OU09MRV9TSE9XX0NPTU1BTkQ7XG4gIGNvbW1hbmQ6IHN0cmluZztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb25zb2xlU2hvd0Vycm9yTWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBDT05TT0xFX1NIT1dfRVJST1I7XG4gIHRleHQ6IHN0cmluZztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb25zb2xlU2hvd0luZm9NZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIENPTlNPTEVfU0hPV19JTkZPO1xuICB0ZXh0OiBzdHJpbmc7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29uc29sZVNob3dGaW5kTWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBDT05TT0xFX1NIT1dfRklORDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb25zb2xlSGlkZU1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQ09OU09MRV9ISURFO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIENvbnNvbGVHZXRDb21wbGV0aW9uVHlwZXNNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIENPTlNPTEVfR0VUX0NPTVBMRVRJT05fVFlQRVM7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29uc29sZVJlcXVlc3RTZWFyY2hFbmdpbmVzTWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBDT05TT0xFX1JFUVVFU1RfU0VBUkNIX0VOR0lORVNfTUVTU0FHRTtcbiAgcXVlcnk6IHN0cmluZztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb25zb2xlUmVxdWVzdEJvb2ttYXJrc01lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQ09OU09MRV9SRVFVRVNUX0JPT0tNQVJLUztcbiAgcXVlcnk6IHN0cmluZztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb25zb2xlUmVxdWVzdEhpc3RvcnlNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIENPTlNPTEVfUkVRVUVTVF9ISVNUT1JZO1xuICBxdWVyeTogc3RyaW5nO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIENvbnNvbGVSZXF1ZXN0VGFic01lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQ09OU09MRV9SRVFVRVNUX1RBQlM7XG4gIHF1ZXJ5OiBzdHJpbmc7XG4gIGV4Y2x1ZGVQaW5uZWQ6IGJvb2xlYW47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29uc29sZUdldFByb3BlcnRpZXNNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIENPTlNPTEVfR0VUX1BST1BFUlRJRVM7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29uc29sZVJlc2l6ZU1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQ09OU09MRV9SRVNJWkU7XG4gIHdpZHRoOiBudW1iZXI7XG4gIGhlaWdodDogbnVtYmVyO1xufVxuXG5leHBvcnQgdHlwZSBDb25zb2xlUmVxdWVzdFRhYnNSZXNwb25zZSA9IHtcbiAgaW5kZXg6IG51bWJlcjtcbiAgZmxhZzogVGFiRmxhZztcbiAgdGl0bGU6IHN0cmluZztcbiAgdXJsOiBzdHJpbmc7XG4gIGZhdmljb25Vcmw/OiBzdHJpbmc7XG59W107XG5cbmV4cG9ydCB0eXBlIENvbnNvbGVHZXRDb21wbGV0aW9uVHlwZXNSZXNwb25zZSA9IENvbXBsZXRpb25UeXBlW107XG5cbmV4cG9ydCB0eXBlIENvbnNvbGVSZXF1ZXN0U2VhcmNoRW5naW5lc1Jlc3BvbnNlID0ge1xuICB0aXRsZTogc3RyaW5nO1xufVtdO1xuXG5leHBvcnQgdHlwZSBDb25zb2xlUmVxdWVzdEJvb2ttYXJrc1Jlc3BvbnNlID0ge1xuICB0aXRsZTogc3RyaW5nO1xuICB1cmw6IHN0cmluZztcbn1bXTtcblxuZXhwb3J0IHR5cGUgQ29uc29sZVJlcXVlc3RIaXN0b3J5UmVzcG9uc2UgPSB7XG4gIHRpdGxlOiBzdHJpbmc7XG4gIHVybDogc3RyaW5nO1xufVtdO1xuXG5leHBvcnQgdHlwZSBDb25zb2xlR2V0UHJvcGVydGllc1Jlc3BvbnNlID0ge1xuICBuYW1lOiBzdHJpbmc7XG4gIHR5cGU6IFwic3RyaW5nXCIgfCBcImJvb2xlYW5cIiB8IFwibnVtYmVyXCI7XG59W107XG5cbmV4cG9ydCBpbnRlcmZhY2UgRm9sbG93U3RhcnRNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIEZPTExPV19TVEFSVDtcbiAgbmV3VGFiOiBib29sZWFuO1xuICBiYWNrZ3JvdW5kOiBib29sZWFuO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIEZvbGxvd1JlcXVlc3RDb3VudFRhcmdldHNNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIEZPTExPV19SRVFVRVNUX0NPVU5UX1RBUkdFVFM7XG4gIHZpZXdTaXplOiB7IHdpZHRoOiBudW1iZXI7IGhlaWdodDogbnVtYmVyIH07XG4gIGZyYW1lUG9zaXRpb246IHsgeDogbnVtYmVyOyB5OiBudW1iZXIgfTtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBGb2xsb3dSZXNwb25zZUNvdW50VGFyZ2V0c01lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgRk9MTE9XX1JFU1BPTlNFX0NPVU5UX1RBUkdFVFM7XG4gIGNvdW50OiBudW1iZXI7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgRm9sbG93Q3JlYXRlSGludHNNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIEZPTExPV19DUkVBVEVfSElOVFM7XG4gIHRhZ3M6IHN0cmluZ1tdO1xuICB2aWV3U2l6ZTogeyB3aWR0aDogbnVtYmVyOyBoZWlnaHQ6IG51bWJlciB9O1xuICBmcmFtZVBvc2l0aW9uOiB7IHg6IG51bWJlcjsgeTogbnVtYmVyIH07XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgRm9sbG93U2hvd0hpbnRzTWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBGT0xMT1dfU0hPV19ISU5UUztcbiAgcHJlZml4OiBzdHJpbmc7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgRm9sbG93UmVtb3ZlSGludHNNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIEZPTExPV19SRU1PVkVfSElOVFM7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgRm9sbG93QWN0aXZhdGVNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIEZPTExPV19BQ1RJVkFURTtcbiAgdGFnOiBzdHJpbmc7XG4gIG5ld1RhYjogYm9vbGVhbjtcbiAgYmFja2dyb3VuZDogYm9vbGVhbjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBGb2xsb3dLZXlQcmVzc01lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgRk9MTE9XX0tFWV9QUkVTUztcbiAga2V5OiBzdHJpbmc7XG4gIGN0cmxLZXk6IGJvb2xlYW47XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgTWFya1NldEdsb2JhbE1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgTUFSS19TRVRfR0xPQkFMO1xuICBrZXk6IHN0cmluZztcbiAgeDogbnVtYmVyO1xuICB5OiBudW1iZXI7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgTWFya0p1bXBHbG9iYWxNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIE1BUktfSlVNUF9HTE9CQUw7XG4gIGtleTogc3RyaW5nO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFRhYlNjcm9sbFRvTWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBUQUJfU0NST0xMX1RPO1xuICB4OiBudW1iZXI7XG4gIHk6IG51bWJlcjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBGaW5kTmV4dE1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgRklORF9ORVhUO1xuICBrZXl3b3JkOiBzdHJpbmc7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgRmluZFByZXZNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIEZJTkRfUFJFVjtcbiAga2V5d29yZDogc3RyaW5nO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIEZpbmRDbGVhclNlbGVjdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBGSU5EX0NMRUFSX1NFTEVDVElPTjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBBZGRvbkVuYWJsZWRRdWVyeU1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQURET05fRU5BQkxFRF9RVUVSWTtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBBZGRvbkVuYWJsZWRSZXNwb25zZU1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgQURET05fRU5BQkxFRF9SRVNQT05TRTtcbiAgZW5hYmxlZDogYm9vbGVhbjtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBBZGRvblRvZ2dsZUVuYWJsZWRNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIEFERE9OX1RPR0dMRV9FTkFCTEVEO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIE9wZW5VcmxNZXNzYWdlIHtcbiAgdHlwZTogdHlwZW9mIE9QRU5fVVJMO1xuICB1cmw6IHN0cmluZztcbiAgbmV3VGFiOiBib29sZWFuO1xuICBiYWNrZ3JvdW5kOiBib29sZWFuO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIFNldHRpbmdzQ2hhbmdlZE1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgU0VUVElOR1NfQ0hBTkdFRDtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBTZXR0aW5nc1F1ZXJ5TWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBTRVRUSU5HU19RVUVSWTtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb25zb2xlRnJhbWVNZXNzYWdlTWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBDT05TT0xFX0ZSQU1FX01FU1NBR0U7XG4gIG1lc3NhZ2U6IGFueTtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBOYXZpZ2F0ZUhpc3RvcnlOZXh0TWVzc2FnZSB7XG4gIHR5cGU6IHR5cGVvZiBOQVZJR0FURV9ISVNUT1JZX05FWFQ7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgTmF2aWdhdGVIaXN0b3J5UHJldk1lc3NhZ2Uge1xuICB0eXBlOiB0eXBlb2YgTkFWSUdBVEVfSElTVE9SWV9QUkVWO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIE5hdmlnYXRlTGlua05leHQge1xuICB0eXBlOiB0eXBlb2YgTkFWSUdBVEVfTElOS19ORVhUO1xufVxuXG5leHBvcnQgaW50ZXJmYWNlIE5hdmlnYXRlTGlua1ByZXYge1xuICB0eXBlOiB0eXBlb2YgTkFWSUdBVEVfTElOS19QUkVWO1xufVxuXG5leHBvcnQgdHlwZSBNZXNzYWdlID1cbiAgfCBCYWNrZ3JvdW5kT3BlcmF0aW9uTWVzc2FnZVxuICB8IENvbnNvbGVVbmZvY3VzTWVzc2FnZVxuICB8IENvbnNvbGVFbnRlckNvbW1hbmRNZXNzYWdlXG4gIHwgQ29uc29sZUVudGVyRmluZE1lc3NhZ2VcbiAgfCBDb25zb2xlU2hvd0NvbW1hbmRNZXNzYWdlXG4gIHwgQ29uc29sZVNob3dFcnJvck1lc3NhZ2VcbiAgfCBDb25zb2xlU2hvd0luZm9NZXNzYWdlXG4gIHwgQ29uc29sZVNob3dGaW5kTWVzc2FnZVxuICB8IENvbnNvbGVIaWRlTWVzc2FnZVxuICB8IENvbnNvbGVSZXF1ZXN0Qm9va21hcmtzTWVzc2FnZVxuICB8IENvbnNvbGVSZXF1ZXN0SGlzdG9yeU1lc3NhZ2VcbiAgfCBDb25zb2xlUmVxdWVzdFRhYnNNZXNzYWdlXG4gIHwgQ29uc29sZUdldFByb3BlcnRpZXNNZXNzYWdlXG4gIHwgQ29uc29sZVJlc2l6ZU1lc3NhZ2VcbiAgfCBDb25zb2xlR2V0Q29tcGxldGlvblR5cGVzTWVzc2FnZVxuICB8IENvbnNvbGVSZXF1ZXN0U2VhcmNoRW5naW5lc01lc3NhZ2VcbiAgfCBGb2xsb3dTdGFydE1lc3NhZ2VcbiAgfCBGb2xsb3dSZXF1ZXN0Q291bnRUYXJnZXRzTWVzc2FnZVxuICB8IEZvbGxvd1Jlc3BvbnNlQ291bnRUYXJnZXRzTWVzc2FnZVxuICB8IEZvbGxvd0NyZWF0ZUhpbnRzTWVzc2FnZVxuICB8IEZvbGxvd1Nob3dIaW50c01lc3NhZ2VcbiAgfCBGb2xsb3dSZW1vdmVIaW50c01lc3NhZ2VcbiAgfCBGb2xsb3dBY3RpdmF0ZU1lc3NhZ2VcbiAgfCBGb2xsb3dLZXlQcmVzc01lc3NhZ2VcbiAgfCBNYXJrU2V0R2xvYmFsTWVzc2FnZVxuICB8IE1hcmtKdW1wR2xvYmFsTWVzc2FnZVxuICB8IFRhYlNjcm9sbFRvTWVzc2FnZVxuICB8IEZpbmROZXh0TWVzc2FnZVxuICB8IEZpbmRQcmV2TWVzc2FnZVxuICB8IEZpbmRDbGVhclNlbGVjdGlvblxuICB8IEFkZG9uRW5hYmxlZFF1ZXJ5TWVzc2FnZVxuICB8IEFkZG9uRW5hYmxlZFJlc3BvbnNlTWVzc2FnZVxuICB8IEFkZG9uVG9nZ2xlRW5hYmxlZE1lc3NhZ2VcbiAgfCBPcGVuVXJsTWVzc2FnZVxuICB8IFNldHRpbmdzQ2hhbmdlZE1lc3NhZ2VcbiAgfCBTZXR0aW5nc1F1ZXJ5TWVzc2FnZVxuICB8IENvbnNvbGVGcmFtZU1lc3NhZ2VNZXNzYWdlXG4gIHwgTmF2aWdhdGVIaXN0b3J5TmV4dE1lc3NhZ2VcbiAgfCBOYXZpZ2F0ZUhpc3RvcnlQcmV2TWVzc2FnZVxuICB8IE5hdmlnYXRlTGlua05leHRcbiAgfCBOYXZpZ2F0ZUxpbmtQcmV2O1xuXG4vLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgY29tcGxleGl0eVxuZXhwb3J0IGNvbnN0IHZhbHVlT2YgPSAobzogYW55KTogTWVzc2FnZSA9PiB7XG4gIHN3aXRjaCAoby50eXBlKSB7XG4gICAgY2FzZSBDT05TT0xFX1VORk9DVVM6XG4gICAgY2FzZSBDT05TT0xFX0VOVEVSX0NPTU1BTkQ6XG4gICAgY2FzZSBDT05TT0xFX0VOVEVSX0ZJTkQ6XG4gICAgY2FzZSBDT05TT0xFX1NIT1dfQ09NTUFORDpcbiAgICBjYXNlIENPTlNPTEVfU0hPV19FUlJPUjpcbiAgICBjYXNlIENPTlNPTEVfU0hPV19JTkZPOlxuICAgIGNhc2UgQ09OU09MRV9TSE9XX0ZJTkQ6XG4gICAgY2FzZSBDT05TT0xFX0hJREU6XG4gICAgY2FzZSBGT0xMT1dfU1RBUlQ6XG4gICAgY2FzZSBGT0xMT1dfUkVRVUVTVF9DT1VOVF9UQVJHRVRTOlxuICAgIGNhc2UgRk9MTE9XX1JFU1BPTlNFX0NPVU5UX1RBUkdFVFM6XG4gICAgY2FzZSBGT0xMT1dfQ1JFQVRFX0hJTlRTOlxuICAgIGNhc2UgRk9MTE9XX1NIT1dfSElOVFM6XG4gICAgY2FzZSBGT0xMT1dfUkVNT1ZFX0hJTlRTOlxuICAgIGNhc2UgRk9MTE9XX0FDVElWQVRFOlxuICAgIGNhc2UgRk9MTE9XX0tFWV9QUkVTUzpcbiAgICBjYXNlIE1BUktfU0VUX0dMT0JBTDpcbiAgICBjYXNlIE1BUktfSlVNUF9HTE9CQUw6XG4gICAgY2FzZSBUQUJfU0NST0xMX1RPOlxuICAgIGNhc2UgRklORF9ORVhUOlxuICAgIGNhc2UgRklORF9QUkVWOlxuICAgIGNhc2UgRklORF9DTEVBUl9TRUxFQ1RJT046XG4gICAgY2FzZSBBRERPTl9FTkFCTEVEX1FVRVJZOlxuICAgIGNhc2UgQURET05fRU5BQkxFRF9SRVNQT05TRTpcbiAgICBjYXNlIEFERE9OX1RPR0dMRV9FTkFCTEVEOlxuICAgIGNhc2UgT1BFTl9VUkw6XG4gICAgY2FzZSBTRVRUSU5HU19DSEFOR0VEOlxuICAgIGNhc2UgU0VUVElOR1NfUVVFUlk6XG4gICAgY2FzZSBDT05TT0xFX0ZSQU1FX01FU1NBR0U6XG4gICAgY2FzZSBDT05TT0xFX1JFU0laRTpcbiAgICBjYXNlIE5BVklHQVRFX0hJU1RPUllfTkVYVDpcbiAgICBjYXNlIE5BVklHQVRFX0hJU1RPUllfUFJFVjpcbiAgICBjYXNlIE5BVklHQVRFX0xJTktfTkVYVDpcbiAgICBjYXNlIE5BVklHQVRFX0xJTktfUFJFVjpcbiAgICAgIHJldHVybiBvO1xuICB9XG4gIHRocm93IG5ldyBFcnJvcihcInVua25vd24gbWVzc2FnZSB0eXBlOiBcIiArIG8udHlwZSk7XG59O1xuIiwiaW1wb3J0e3R5cGVPZiBhcyBlLGlzRWxlbWVudCBhcyB0LGlzVmFsaWRFbGVtZW50VHlwZSBhcyBufWZyb21cInJlYWN0LWlzXCI7aW1wb3J0IHIse3VzZVN0YXRlIGFzIG8sdXNlQ29udGV4dCBhcyBpLHVzZU1lbW8gYXMgcyx1c2VFZmZlY3QgYXMgYSx1c2VSZWYgYXMgYyxjcmVhdGVFbGVtZW50IGFzIHUsdXNlRGVidWdWYWx1ZSBhcyBsLHVzZUxheW91dEVmZmVjdCBhcyBkfWZyb21cInJlYWN0XCI7aW1wb3J0IGggZnJvbVwic2hhbGxvd2VxdWFsXCI7aW1wb3J0IHAgZnJvbVwiQGVtb3Rpb24vc3R5bGlzXCI7aW1wb3J0IGYgZnJvbVwiQGVtb3Rpb24vdW5pdGxlc3NcIjtpbXBvcnQgbSBmcm9tXCJAZW1vdGlvbi9pcy1wcm9wLXZhbGlkXCI7aW1wb3J0IHkgZnJvbVwiaG9pc3Qtbm9uLXJlYWN0LXN0YXRpY3NcIjtmdW5jdGlvbiB2KCl7cmV0dXJuKHY9T2JqZWN0LmFzc2lnbnx8ZnVuY3Rpb24oZSl7Zm9yKHZhciB0PTE7dDxhcmd1bWVudHMubGVuZ3RoO3QrKyl7dmFyIG49YXJndW1lbnRzW3RdO2Zvcih2YXIgciBpbiBuKU9iamVjdC5wcm90b3R5cGUuaGFzT3duUHJvcGVydHkuY2FsbChuLHIpJiYoZVtyXT1uW3JdKX1yZXR1cm4gZX0pLmFwcGx5KHRoaXMsYXJndW1lbnRzKX12YXIgZz1mdW5jdGlvbihlLHQpe2Zvcih2YXIgbj1bZVswXV0scj0wLG89dC5sZW5ndGg7cjxvO3IrPTEpbi5wdXNoKHRbcl0sZVtyKzFdKTtyZXR1cm4gbn0sUz1mdW5jdGlvbih0KXtyZXR1cm4gbnVsbCE9PXQmJlwib2JqZWN0XCI9PXR5cGVvZiB0JiZcIltvYmplY3QgT2JqZWN0XVwiPT09KHQudG9TdHJpbmc/dC50b1N0cmluZygpOk9iamVjdC5wcm90b3R5cGUudG9TdHJpbmcuY2FsbCh0KSkmJiFlKHQpfSx3PU9iamVjdC5mcmVlemUoW10pLEU9T2JqZWN0LmZyZWV6ZSh7fSk7ZnVuY3Rpb24gYihlKXtyZXR1cm5cImZ1bmN0aW9uXCI9PXR5cGVvZiBlfWZ1bmN0aW9uIF8oZSl7cmV0dXJuXCJwcm9kdWN0aW9uXCIhPT1wcm9jZXNzLmVudi5OT0RFX0VOViYmXCJzdHJpbmdcIj09dHlwZW9mIGUmJmV8fGUuZGlzcGxheU5hbWV8fGUubmFtZXx8XCJDb21wb25lbnRcIn1mdW5jdGlvbiBOKGUpe3JldHVybiBlJiZcInN0cmluZ1wiPT10eXBlb2YgZS5zdHlsZWRDb21wb25lbnRJZH12YXIgQT1cInVuZGVmaW5lZFwiIT10eXBlb2YgcHJvY2VzcyYmKHByb2Nlc3MuZW52LlJFQUNUX0FQUF9TQ19BVFRSfHxwcm9jZXNzLmVudi5TQ19BVFRSKXx8XCJkYXRhLXN0eWxlZFwiLEM9XCI1LjMuMFwiLEk9XCJ1bmRlZmluZWRcIiE9dHlwZW9mIHdpbmRvdyYmXCJIVE1MRWxlbWVudFwiaW4gd2luZG93LFA9Qm9vbGVhbihcImJvb2xlYW5cIj09dHlwZW9mIFNDX0RJU0FCTEVfU1BFRURZP1NDX0RJU0FCTEVfU1BFRURZOlwidW5kZWZpbmVkXCIhPXR5cGVvZiBwcm9jZXNzJiZ2b2lkIDAhPT1wcm9jZXNzLmVudi5SRUFDVF9BUFBfU0NfRElTQUJMRV9TUEVFRFkmJlwiXCIhPT1wcm9jZXNzLmVudi5SRUFDVF9BUFBfU0NfRElTQUJMRV9TUEVFRFk/XCJmYWxzZVwiIT09cHJvY2Vzcy5lbnYuUkVBQ1RfQVBQX1NDX0RJU0FCTEVfU1BFRURZJiZwcm9jZXNzLmVudi5SRUFDVF9BUFBfU0NfRElTQUJMRV9TUEVFRFk6XCJ1bmRlZmluZWRcIiE9dHlwZW9mIHByb2Nlc3MmJnZvaWQgMCE9PXByb2Nlc3MuZW52LlNDX0RJU0FCTEVfU1BFRURZJiZcIlwiIT09cHJvY2Vzcy5lbnYuU0NfRElTQUJMRV9TUEVFRFk/XCJmYWxzZVwiIT09cHJvY2Vzcy5lbnYuU0NfRElTQUJMRV9TUEVFRFkmJnByb2Nlc3MuZW52LlNDX0RJU0FCTEVfU1BFRURZOlwicHJvZHVjdGlvblwiIT09cHJvY2Vzcy5lbnYuTk9ERV9FTlYpLE89e30sUj1cInByb2R1Y3Rpb25cIiE9PXByb2Nlc3MuZW52Lk5PREVfRU5WP3sxOlwiQ2Fubm90IGNyZWF0ZSBzdHlsZWQtY29tcG9uZW50IGZvciBjb21wb25lbnQ6ICVzLlxcblxcblwiLDI6XCJDYW4ndCBjb2xsZWN0IHN0eWxlcyBvbmNlIHlvdSd2ZSBjb25zdW1lZCBhIGBTZXJ2ZXJTdHlsZVNoZWV0YCdzIHN0eWxlcyEgYFNlcnZlclN0eWxlU2hlZXRgIGlzIGEgb25lIG9mZiBpbnN0YW5jZSBmb3IgZWFjaCBzZXJ2ZXItc2lkZSByZW5kZXIgY3ljbGUuXFxuXFxuLSBBcmUgeW91IHRyeWluZyB0byByZXVzZSBpdCBhY3Jvc3MgcmVuZGVycz9cXG4tIEFyZSB5b3UgYWNjaWRlbnRhbGx5IGNhbGxpbmcgY29sbGVjdFN0eWxlcyB0d2ljZT9cXG5cXG5cIiwzOlwiU3RyZWFtaW5nIFNTUiBpcyBvbmx5IHN1cHBvcnRlZCBpbiBhIE5vZGUuanMgZW52aXJvbm1lbnQ7IFBsZWFzZSBkbyBub3QgdHJ5IHRvIGNhbGwgdGhpcyBtZXRob2QgaW4gdGhlIGJyb3dzZXIuXFxuXFxuXCIsNDpcIlRoZSBgU3R5bGVTaGVldE1hbmFnZXJgIGV4cGVjdHMgYSB2YWxpZCB0YXJnZXQgb3Igc2hlZXQgcHJvcCFcXG5cXG4tIERvZXMgdGhpcyBlcnJvciBvY2N1ciBvbiB0aGUgY2xpZW50IGFuZCBpcyB5b3VyIHRhcmdldCBmYWxzeT9cXG4tIERvZXMgdGhpcyBlcnJvciBvY2N1ciBvbiB0aGUgc2VydmVyIGFuZCBpcyB0aGUgc2hlZXQgZmFsc3k/XFxuXFxuXCIsNTpcIlRoZSBjbG9uZSBtZXRob2QgY2Fubm90IGJlIHVzZWQgb24gdGhlIGNsaWVudCFcXG5cXG4tIEFyZSB5b3UgcnVubmluZyBpbiBhIGNsaWVudC1saWtlIGVudmlyb25tZW50IG9uIHRoZSBzZXJ2ZXI/XFxuLSBBcmUgeW91IHRyeWluZyB0byBydW4gU1NSIG9uIHRoZSBjbGllbnQ/XFxuXFxuXCIsNjpcIlRyeWluZyB0byBpbnNlcnQgYSBuZXcgc3R5bGUgdGFnLCBidXQgdGhlIGdpdmVuIE5vZGUgaXMgdW5tb3VudGVkIVxcblxcbi0gQXJlIHlvdSB1c2luZyBhIGN1c3RvbSB0YXJnZXQgdGhhdCBpc24ndCBtb3VudGVkP1xcbi0gRG9lcyB5b3VyIGRvY3VtZW50IG5vdCBoYXZlIGEgdmFsaWQgaGVhZCBlbGVtZW50P1xcbi0gSGF2ZSB5b3UgYWNjaWRlbnRhbGx5IHJlbW92ZWQgYSBzdHlsZSB0YWcgbWFudWFsbHk/XFxuXFxuXCIsNzonVGhlbWVQcm92aWRlcjogUGxlYXNlIHJldHVybiBhbiBvYmplY3QgZnJvbSB5b3VyIFwidGhlbWVcIiBwcm9wIGZ1bmN0aW9uLCBlLmcuXFxuXFxuYGBganNcXG50aGVtZT17KCkgPT4gKHt9KX1cXG5gYGBcXG5cXG4nLDg6J1RoZW1lUHJvdmlkZXI6IFBsZWFzZSBtYWtlIHlvdXIgXCJ0aGVtZVwiIHByb3AgYW4gb2JqZWN0LlxcblxcbicsOTpcIk1pc3NpbmcgZG9jdW1lbnQgYDxoZWFkPmBcXG5cXG5cIiwxMDpcIkNhbm5vdCBmaW5kIGEgU3R5bGVTaGVldCBpbnN0YW5jZS4gVXN1YWxseSB0aGlzIGhhcHBlbnMgaWYgdGhlcmUgYXJlIG11bHRpcGxlIGNvcGllcyBvZiBzdHlsZWQtY29tcG9uZW50cyBsb2FkZWQgYXQgb25jZS4gQ2hlY2sgb3V0IHRoaXMgaXNzdWUgZm9yIGhvdyB0byB0cm91Ymxlc2hvb3QgYW5kIGZpeCB0aGUgY29tbW9uIGNhc2VzIHdoZXJlIHRoaXMgc2l0dWF0aW9uIGNhbiBoYXBwZW46IGh0dHBzOi8vZ2l0aHViLmNvbS9zdHlsZWQtY29tcG9uZW50cy9zdHlsZWQtY29tcG9uZW50cy9pc3N1ZXMvMTk0MSNpc3N1ZWNvbW1lbnQtNDE3ODYyMDIxXFxuXFxuXCIsMTE6XCJfVGhpcyBlcnJvciB3YXMgcmVwbGFjZWQgd2l0aCBhIGRldi10aW1lIHdhcm5pbmcsIGl0IHdpbGwgYmUgZGVsZXRlZCBmb3IgdjQgZmluYWwuXyBbY3JlYXRlR2xvYmFsU3R5bGVdIHJlY2VpdmVkIGNoaWxkcmVuIHdoaWNoIHdpbGwgbm90IGJlIHJlbmRlcmVkLiBQbGVhc2UgdXNlIHRoZSBjb21wb25lbnQgd2l0aG91dCBwYXNzaW5nIGNoaWxkcmVuIGVsZW1lbnRzLlxcblxcblwiLDEyOlwiSXQgc2VlbXMgeW91IGFyZSBpbnRlcnBvbGF0aW5nIGEga2V5ZnJhbWUgZGVjbGFyYXRpb24gKCVzKSBpbnRvIGFuIHVudGFnZ2VkIHN0cmluZy4gVGhpcyB3YXMgc3VwcG9ydGVkIGluIHN0eWxlZC1jb21wb25lbnRzIHYzLCBidXQgaXMgbm90IGxvbmdlciBzdXBwb3J0ZWQgaW4gdjQgYXMga2V5ZnJhbWVzIGFyZSBub3cgaW5qZWN0ZWQgb24tZGVtYW5kLiBQbGVhc2Ugd3JhcCB5b3VyIHN0cmluZyBpbiB0aGUgY3NzXFxcXGBcXFxcYCBoZWxwZXIgd2hpY2ggZW5zdXJlcyB0aGUgc3R5bGVzIGFyZSBpbmplY3RlZCBjb3JyZWN0bHkuIFNlZSBodHRwczovL3d3dy5zdHlsZWQtY29tcG9uZW50cy5jb20vZG9jcy9hcGkjY3NzXFxuXFxuXCIsMTM6XCIlcyBpcyBub3QgYSBzdHlsZWQgY29tcG9uZW50IGFuZCBjYW5ub3QgYmUgcmVmZXJyZWQgdG8gdmlhIGNvbXBvbmVudCBzZWxlY3Rvci4gU2VlIGh0dHBzOi8vd3d3LnN0eWxlZC1jb21wb25lbnRzLmNvbS9kb2NzL2FkdmFuY2VkI3JlZmVycmluZy10by1vdGhlci1jb21wb25lbnRzIGZvciBtb3JlIGRldGFpbHMuXFxuXFxuXCIsMTQ6J1RoZW1lUHJvdmlkZXI6IFwidGhlbWVcIiBwcm9wIGlzIHJlcXVpcmVkLlxcblxcbicsMTU6XCJBIHN0eWxpcyBwbHVnaW4gaGFzIGJlZW4gc3VwcGxpZWQgdGhhdCBpcyBub3QgbmFtZWQuIFdlIG5lZWQgYSBuYW1lIGZvciBlYWNoIHBsdWdpbiB0byBiZSBhYmxlIHRvIHByZXZlbnQgc3R5bGluZyBjb2xsaXNpb25zIGJldHdlZW4gZGlmZmVyZW50IHN0eWxpcyBjb25maWd1cmF0aW9ucyB3aXRoaW4gdGhlIHNhbWUgYXBwLiBCZWZvcmUgeW91IHBhc3MgeW91ciBwbHVnaW4gdG8gYDxTdHlsZVNoZWV0TWFuYWdlciBzdHlsaXNQbHVnaW5zPXtbXX0+YCwgcGxlYXNlIG1ha2Ugc3VyZSBlYWNoIHBsdWdpbiBpcyB1bmlxdWVseS1uYW1lZCwgZS5nLlxcblxcbmBgYGpzXFxuT2JqZWN0LmRlZmluZVByb3BlcnR5KGltcG9ydGVkUGx1Z2luLCAnbmFtZScsIHsgdmFsdWU6ICdzb21lLXVuaXF1ZS1uYW1lJyB9KTtcXG5gYGBcXG5cXG5cIiwxNjpcIlJlYWNoZWQgdGhlIGxpbWl0IG9mIGhvdyBtYW55IHN0eWxlZCBjb21wb25lbnRzIG1heSBiZSBjcmVhdGVkIGF0IGdyb3VwICVzLlxcbllvdSBtYXkgb25seSBjcmVhdGUgdXAgdG8gMSwwNzMsNzQxLDgyNCBjb21wb25lbnRzLiBJZiB5b3UncmUgY3JlYXRpbmcgY29tcG9uZW50cyBkeW5hbWljYWxseSxcXG5hcyBmb3IgaW5zdGFuY2UgaW4geW91ciByZW5kZXIgbWV0aG9kIHRoZW4geW91IG1heSBiZSBydW5uaW5nIGludG8gdGhpcyBsaW1pdGF0aW9uLlxcblxcblwiLDE3OlwiQ1NTU3R5bGVTaGVldCBjb3VsZCBub3QgYmUgZm91bmQgb24gSFRNTFN0eWxlRWxlbWVudC5cXG5IYXMgc3R5bGVkLWNvbXBvbmVudHMnIHN0eWxlIHRhZyBiZWVuIHVubW91bnRlZCBvciBhbHRlcmVkIGJ5IGFub3RoZXIgc2NyaXB0P1xcblwifTp7fTtmdW5jdGlvbiBEKCl7Zm9yKHZhciBlPWFyZ3VtZW50cy5sZW5ndGg8PTA/dm9pZCAwOmFyZ3VtZW50c1swXSx0PVtdLG49MSxyPWFyZ3VtZW50cy5sZW5ndGg7bjxyO24rPTEpdC5wdXNoKG48MHx8YXJndW1lbnRzLmxlbmd0aDw9bj92b2lkIDA6YXJndW1lbnRzW25dKTtyZXR1cm4gdC5mb3JFYWNoKChmdW5jdGlvbih0KXtlPWUucmVwbGFjZSgvJVthLXpdLyx0KX0pKSxlfWZ1bmN0aW9uIGooZSl7Zm9yKHZhciB0PWFyZ3VtZW50cy5sZW5ndGgsbj1uZXcgQXJyYXkodD4xP3QtMTowKSxyPTE7cjx0O3IrKyluW3ItMV09YXJndW1lbnRzW3JdO3Rocm93XCJwcm9kdWN0aW9uXCI9PT1wcm9jZXNzLmVudi5OT0RFX0VOVj9uZXcgRXJyb3IoXCJBbiBlcnJvciBvY2N1cnJlZC4gU2VlIGh0dHBzOi8vZ2l0LmlvL0pVSWFFI1wiK2UrXCIgZm9yIG1vcmUgaW5mb3JtYXRpb24uXCIrKG4ubGVuZ3RoPjA/XCIgQXJnczogXCIrbi5qb2luKFwiLCBcIik6XCJcIikpOm5ldyBFcnJvcihELmFwcGx5KHZvaWQgMCxbUltlXV0uY29uY2F0KG4pKS50cmltKCkpfXZhciBUPWZ1bmN0aW9uKCl7ZnVuY3Rpb24gZShlKXt0aGlzLmdyb3VwU2l6ZXM9bmV3IFVpbnQzMkFycmF5KDUxMiksdGhpcy5sZW5ndGg9NTEyLHRoaXMudGFnPWV9dmFyIHQ9ZS5wcm90b3R5cGU7cmV0dXJuIHQuaW5kZXhPZkdyb3VwPWZ1bmN0aW9uKGUpe2Zvcih2YXIgdD0wLG49MDtuPGU7bisrKXQrPXRoaXMuZ3JvdXBTaXplc1tuXTtyZXR1cm4gdH0sdC5pbnNlcnRSdWxlcz1mdW5jdGlvbihlLHQpe2lmKGU+PXRoaXMuZ3JvdXBTaXplcy5sZW5ndGgpe2Zvcih2YXIgbj10aGlzLmdyb3VwU2l6ZXMscj1uLmxlbmd0aCxvPXI7ZT49bzspKG88PD0xKTwwJiZqKDE2LFwiXCIrZSk7dGhpcy5ncm91cFNpemVzPW5ldyBVaW50MzJBcnJheShvKSx0aGlzLmdyb3VwU2l6ZXMuc2V0KG4pLHRoaXMubGVuZ3RoPW87Zm9yKHZhciBpPXI7aTxvO2krKyl0aGlzLmdyb3VwU2l6ZXNbaV09MH1mb3IodmFyIHM9dGhpcy5pbmRleE9mR3JvdXAoZSsxKSxhPTAsYz10Lmxlbmd0aDthPGM7YSsrKXRoaXMudGFnLmluc2VydFJ1bGUocyx0W2FdKSYmKHRoaXMuZ3JvdXBTaXplc1tlXSsrLHMrKyl9LHQuY2xlYXJHcm91cD1mdW5jdGlvbihlKXtpZihlPHRoaXMubGVuZ3RoKXt2YXIgdD10aGlzLmdyb3VwU2l6ZXNbZV0sbj10aGlzLmluZGV4T2ZHcm91cChlKSxyPW4rdDt0aGlzLmdyb3VwU2l6ZXNbZV09MDtmb3IodmFyIG89bjtvPHI7bysrKXRoaXMudGFnLmRlbGV0ZVJ1bGUobil9fSx0LmdldEdyb3VwPWZ1bmN0aW9uKGUpe3ZhciB0PVwiXCI7aWYoZT49dGhpcy5sZW5ndGh8fDA9PT10aGlzLmdyb3VwU2l6ZXNbZV0pcmV0dXJuIHQ7Zm9yKHZhciBuPXRoaXMuZ3JvdXBTaXplc1tlXSxyPXRoaXMuaW5kZXhPZkdyb3VwKGUpLG89cituLGk9cjtpPG87aSsrKXQrPXRoaXMudGFnLmdldFJ1bGUoaSkrXCIvKiFzYyovXFxuXCI7cmV0dXJuIHR9LGV9KCksaz1uZXcgTWFwLHg9bmV3IE1hcCxWPTEsQj1mdW5jdGlvbihlKXtpZihrLmhhcyhlKSlyZXR1cm4gay5nZXQoZSk7Zm9yKDt4LmhhcyhWKTspVisrO3ZhciB0PVYrKztyZXR1cm5cInByb2R1Y3Rpb25cIiE9PXByb2Nlc3MuZW52Lk5PREVfRU5WJiYoKDB8dCk8MHx8dD4xPDwzMCkmJmooMTYsXCJcIit0KSxrLnNldChlLHQpLHguc2V0KHQsZSksdH0sTT1mdW5jdGlvbihlKXtyZXR1cm4geC5nZXQoZSl9LHo9ZnVuY3Rpb24oZSx0KXtrLnNldChlLHQpLHguc2V0KHQsZSl9LEw9XCJzdHlsZVtcIitBKyddW2RhdGEtc3R5bGVkLXZlcnNpb249XCI1LjMuMFwiXScsRz1uZXcgUmVnRXhwKFwiXlwiK0ErJ1xcXFwuZyhcXFxcZCspXFxcXFtpZD1cIihbXFxcXHdcXFxcZC1dKylcIlxcXFxdLio/XCIoW15cIl0qKScpLEY9ZnVuY3Rpb24oZSx0LG4pe2Zvcih2YXIgcixvPW4uc3BsaXQoXCIsXCIpLGk9MCxzPW8ubGVuZ3RoO2k8cztpKyspKHI9b1tpXSkmJmUucmVnaXN0ZXJOYW1lKHQscil9LFk9ZnVuY3Rpb24oZSx0KXtmb3IodmFyIG49dC5pbm5lckhUTUwuc3BsaXQoXCIvKiFzYyovXFxuXCIpLHI9W10sbz0wLGk9bi5sZW5ndGg7bzxpO28rKyl7dmFyIHM9bltvXS50cmltKCk7aWYocyl7dmFyIGE9cy5tYXRjaChHKTtpZihhKXt2YXIgYz0wfHBhcnNlSW50KGFbMV0sMTApLHU9YVsyXTswIT09YyYmKHoodSxjKSxGKGUsdSxhWzNdKSxlLmdldFRhZygpLmluc2VydFJ1bGVzKGMscikpLHIubGVuZ3RoPTB9ZWxzZSByLnB1c2gocyl9fX0scT1mdW5jdGlvbigpe3JldHVyblwidW5kZWZpbmVkXCIhPXR5cGVvZiB3aW5kb3cmJnZvaWQgMCE9PXdpbmRvdy5fX3dlYnBhY2tfbm9uY2VfXz93aW5kb3cuX193ZWJwYWNrX25vbmNlX186bnVsbH0sSD1mdW5jdGlvbihlKXt2YXIgdD1kb2N1bWVudC5oZWFkLG49ZXx8dCxyPWRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoXCJzdHlsZVwiKSxvPWZ1bmN0aW9uKGUpe2Zvcih2YXIgdD1lLmNoaWxkTm9kZXMsbj10Lmxlbmd0aDtuPj0wO24tLSl7dmFyIHI9dFtuXTtpZihyJiYxPT09ci5ub2RlVHlwZSYmci5oYXNBdHRyaWJ1dGUoQSkpcmV0dXJuIHJ9fShuKSxpPXZvaWQgMCE9PW8/by5uZXh0U2libGluZzpudWxsO3Iuc2V0QXR0cmlidXRlKEEsXCJhY3RpdmVcIiksci5zZXRBdHRyaWJ1dGUoXCJkYXRhLXN0eWxlZC12ZXJzaW9uXCIsXCI1LjMuMFwiKTt2YXIgcz1xKCk7cmV0dXJuIHMmJnIuc2V0QXR0cmlidXRlKFwibm9uY2VcIixzKSxuLmluc2VydEJlZm9yZShyLGkpLHJ9LCQ9ZnVuY3Rpb24oKXtmdW5jdGlvbiBlKGUpe3ZhciB0PXRoaXMuZWxlbWVudD1IKGUpO3QuYXBwZW5kQ2hpbGQoZG9jdW1lbnQuY3JlYXRlVGV4dE5vZGUoXCJcIikpLHRoaXMuc2hlZXQ9ZnVuY3Rpb24oZSl7aWYoZS5zaGVldClyZXR1cm4gZS5zaGVldDtmb3IodmFyIHQ9ZG9jdW1lbnQuc3R5bGVTaGVldHMsbj0wLHI9dC5sZW5ndGg7bjxyO24rKyl7dmFyIG89dFtuXTtpZihvLm93bmVyTm9kZT09PWUpcmV0dXJuIG99aigxNyl9KHQpLHRoaXMubGVuZ3RoPTB9dmFyIHQ9ZS5wcm90b3R5cGU7cmV0dXJuIHQuaW5zZXJ0UnVsZT1mdW5jdGlvbihlLHQpe3RyeXtyZXR1cm4gdGhpcy5zaGVldC5pbnNlcnRSdWxlKHQsZSksdGhpcy5sZW5ndGgrKywhMH1jYXRjaChlKXtyZXR1cm4hMX19LHQuZGVsZXRlUnVsZT1mdW5jdGlvbihlKXt0aGlzLnNoZWV0LmRlbGV0ZVJ1bGUoZSksdGhpcy5sZW5ndGgtLX0sdC5nZXRSdWxlPWZ1bmN0aW9uKGUpe3ZhciB0PXRoaXMuc2hlZXQuY3NzUnVsZXNbZV07cmV0dXJuIHZvaWQgMCE9PXQmJlwic3RyaW5nXCI9PXR5cGVvZiB0LmNzc1RleHQ/dC5jc3NUZXh0OlwiXCJ9LGV9KCksVz1mdW5jdGlvbigpe2Z1bmN0aW9uIGUoZSl7dmFyIHQ9dGhpcy5lbGVtZW50PUgoZSk7dGhpcy5ub2Rlcz10LmNoaWxkTm9kZXMsdGhpcy5sZW5ndGg9MH12YXIgdD1lLnByb3RvdHlwZTtyZXR1cm4gdC5pbnNlcnRSdWxlPWZ1bmN0aW9uKGUsdCl7aWYoZTw9dGhpcy5sZW5ndGgmJmU+PTApe3ZhciBuPWRvY3VtZW50LmNyZWF0ZVRleHROb2RlKHQpLHI9dGhpcy5ub2Rlc1tlXTtyZXR1cm4gdGhpcy5lbGVtZW50Lmluc2VydEJlZm9yZShuLHJ8fG51bGwpLHRoaXMubGVuZ3RoKyssITB9cmV0dXJuITF9LHQuZGVsZXRlUnVsZT1mdW5jdGlvbihlKXt0aGlzLmVsZW1lbnQucmVtb3ZlQ2hpbGQodGhpcy5ub2Rlc1tlXSksdGhpcy5sZW5ndGgtLX0sdC5nZXRSdWxlPWZ1bmN0aW9uKGUpe3JldHVybiBlPHRoaXMubGVuZ3RoP3RoaXMubm9kZXNbZV0udGV4dENvbnRlbnQ6XCJcIn0sZX0oKSxVPWZ1bmN0aW9uKCl7ZnVuY3Rpb24gZShlKXt0aGlzLnJ1bGVzPVtdLHRoaXMubGVuZ3RoPTB9dmFyIHQ9ZS5wcm90b3R5cGU7cmV0dXJuIHQuaW5zZXJ0UnVsZT1mdW5jdGlvbihlLHQpe3JldHVybiBlPD10aGlzLmxlbmd0aCYmKHRoaXMucnVsZXMuc3BsaWNlKGUsMCx0KSx0aGlzLmxlbmd0aCsrLCEwKX0sdC5kZWxldGVSdWxlPWZ1bmN0aW9uKGUpe3RoaXMucnVsZXMuc3BsaWNlKGUsMSksdGhpcy5sZW5ndGgtLX0sdC5nZXRSdWxlPWZ1bmN0aW9uKGUpe3JldHVybiBlPHRoaXMubGVuZ3RoP3RoaXMucnVsZXNbZV06XCJcIn0sZX0oKSxKPUksWD17aXNTZXJ2ZXI6IUksdXNlQ1NTT01JbmplY3Rpb246IVB9LFo9ZnVuY3Rpb24oKXtmdW5jdGlvbiBlKGUsdCxuKXt2b2lkIDA9PT1lJiYoZT1FKSx2b2lkIDA9PT10JiYodD17fSksdGhpcy5vcHRpb25zPXYoe30sWCx7fSxlKSx0aGlzLmdzPXQsdGhpcy5uYW1lcz1uZXcgTWFwKG4pLCF0aGlzLm9wdGlvbnMuaXNTZXJ2ZXImJkkmJkomJihKPSExLGZ1bmN0aW9uKGUpe2Zvcih2YXIgdD1kb2N1bWVudC5xdWVyeVNlbGVjdG9yQWxsKEwpLG49MCxyPXQubGVuZ3RoO248cjtuKyspe3ZhciBvPXRbbl07byYmXCJhY3RpdmVcIiE9PW8uZ2V0QXR0cmlidXRlKEEpJiYoWShlLG8pLG8ucGFyZW50Tm9kZSYmby5wYXJlbnROb2RlLnJlbW92ZUNoaWxkKG8pKX19KHRoaXMpKX1lLnJlZ2lzdGVySWQ9ZnVuY3Rpb24oZSl7cmV0dXJuIEIoZSl9O3ZhciB0PWUucHJvdG90eXBlO3JldHVybiB0LnJlY29uc3RydWN0V2l0aE9wdGlvbnM9ZnVuY3Rpb24odCxuKXtyZXR1cm4gdm9pZCAwPT09biYmKG49ITApLG5ldyBlKHYoe30sdGhpcy5vcHRpb25zLHt9LHQpLHRoaXMuZ3MsbiYmdGhpcy5uYW1lc3x8dm9pZCAwKX0sdC5hbGxvY2F0ZUdTSW5zdGFuY2U9ZnVuY3Rpb24oZSl7cmV0dXJuIHRoaXMuZ3NbZV09KHRoaXMuZ3NbZV18fDApKzF9LHQuZ2V0VGFnPWZ1bmN0aW9uKCl7cmV0dXJuIHRoaXMudGFnfHwodGhpcy50YWc9KG49KHQ9dGhpcy5vcHRpb25zKS5pc1NlcnZlcixyPXQudXNlQ1NTT01JbmplY3Rpb24sbz10LnRhcmdldCxlPW4/bmV3IFUobyk6cj9uZXcgJChvKTpuZXcgVyhvKSxuZXcgVChlKSkpO3ZhciBlLHQsbixyLG99LHQuaGFzTmFtZUZvcklkPWZ1bmN0aW9uKGUsdCl7cmV0dXJuIHRoaXMubmFtZXMuaGFzKGUpJiZ0aGlzLm5hbWVzLmdldChlKS5oYXModCl9LHQucmVnaXN0ZXJOYW1lPWZ1bmN0aW9uKGUsdCl7aWYoQihlKSx0aGlzLm5hbWVzLmhhcyhlKSl0aGlzLm5hbWVzLmdldChlKS5hZGQodCk7ZWxzZXt2YXIgbj1uZXcgU2V0O24uYWRkKHQpLHRoaXMubmFtZXMuc2V0KGUsbil9fSx0Lmluc2VydFJ1bGVzPWZ1bmN0aW9uKGUsdCxuKXt0aGlzLnJlZ2lzdGVyTmFtZShlLHQpLHRoaXMuZ2V0VGFnKCkuaW5zZXJ0UnVsZXMoQihlKSxuKX0sdC5jbGVhck5hbWVzPWZ1bmN0aW9uKGUpe3RoaXMubmFtZXMuaGFzKGUpJiZ0aGlzLm5hbWVzLmdldChlKS5jbGVhcigpfSx0LmNsZWFyUnVsZXM9ZnVuY3Rpb24oZSl7dGhpcy5nZXRUYWcoKS5jbGVhckdyb3VwKEIoZSkpLHRoaXMuY2xlYXJOYW1lcyhlKX0sdC5jbGVhclRhZz1mdW5jdGlvbigpe3RoaXMudGFnPXZvaWQgMH0sdC50b1N0cmluZz1mdW5jdGlvbigpe3JldHVybiBmdW5jdGlvbihlKXtmb3IodmFyIHQ9ZS5nZXRUYWcoKSxuPXQubGVuZ3RoLHI9XCJcIixvPTA7bzxuO28rKyl7dmFyIGk9TShvKTtpZih2b2lkIDAhPT1pKXt2YXIgcz1lLm5hbWVzLmdldChpKSxhPXQuZ2V0R3JvdXAobyk7aWYodm9pZCAwIT09cyYmMCE9PWEubGVuZ3RoKXt2YXIgYz1BK1wiLmdcIitvKydbaWQ9XCInK2krJ1wiXScsdT1cIlwiO3ZvaWQgMCE9PXMmJnMuZm9yRWFjaCgoZnVuY3Rpb24oZSl7ZS5sZW5ndGg+MCYmKHUrPWUrXCIsXCIpfSkpLHIrPVwiXCIrYStjKyd7Y29udGVudDpcIicrdSsnXCJ9Lyohc2MqL1xcbid9fX1yZXR1cm4gcn0odGhpcyl9LGV9KCksSz0vKGEpKGQpL2dpLFE9ZnVuY3Rpb24oZSl7cmV0dXJuIFN0cmluZy5mcm9tQ2hhckNvZGUoZSsoZT4yNT8zOTo5NykpfTtmdW5jdGlvbiBlZShlKXt2YXIgdCxuPVwiXCI7Zm9yKHQ9TWF0aC5hYnMoZSk7dD41Mjt0PXQvNTJ8MCluPVEodCU1MikrbjtyZXR1cm4oUSh0JTUyKStuKS5yZXBsYWNlKEssXCIkMS0kMlwiKX12YXIgdGU9ZnVuY3Rpb24oZSx0KXtmb3IodmFyIG49dC5sZW5ndGg7bjspZT0zMyplXnQuY2hhckNvZGVBdCgtLW4pO3JldHVybiBlfSxuZT1mdW5jdGlvbihlKXtyZXR1cm4gdGUoNTM4MSxlKX07ZnVuY3Rpb24gcmUoZSl7Zm9yKHZhciB0PTA7dDxlLmxlbmd0aDt0Kz0xKXt2YXIgbj1lW3RdO2lmKGIobikmJiFOKG4pKXJldHVybiExfXJldHVybiEwfXZhciBvZT1uZShcIjUuMy4wXCIpLGllPWZ1bmN0aW9uKCl7ZnVuY3Rpb24gZShlLHQsbil7dGhpcy5ydWxlcz1lLHRoaXMuc3RhdGljUnVsZXNJZD1cIlwiLHRoaXMuaXNTdGF0aWM9XCJwcm9kdWN0aW9uXCI9PT1wcm9jZXNzLmVudi5OT0RFX0VOViYmKHZvaWQgMD09PW58fG4uaXNTdGF0aWMpJiZyZShlKSx0aGlzLmNvbXBvbmVudElkPXQsdGhpcy5iYXNlSGFzaD10ZShvZSx0KSx0aGlzLmJhc2VTdHlsZT1uLFoucmVnaXN0ZXJJZCh0KX1yZXR1cm4gZS5wcm90b3R5cGUuZ2VuZXJhdGVBbmRJbmplY3RTdHlsZXM9ZnVuY3Rpb24oZSx0LG4pe3ZhciByPXRoaXMuY29tcG9uZW50SWQsbz1bXTtpZih0aGlzLmJhc2VTdHlsZSYmby5wdXNoKHRoaXMuYmFzZVN0eWxlLmdlbmVyYXRlQW5kSW5qZWN0U3R5bGVzKGUsdCxuKSksdGhpcy5pc1N0YXRpYyYmIW4uaGFzaClpZih0aGlzLnN0YXRpY1J1bGVzSWQmJnQuaGFzTmFtZUZvcklkKHIsdGhpcy5zdGF0aWNSdWxlc0lkKSlvLnB1c2godGhpcy5zdGF0aWNSdWxlc0lkKTtlbHNle3ZhciBpPU5lKHRoaXMucnVsZXMsZSx0LG4pLmpvaW4oXCJcIikscz1lZSh0ZSh0aGlzLmJhc2VIYXNoLGkubGVuZ3RoKT4+PjApO2lmKCF0Lmhhc05hbWVGb3JJZChyLHMpKXt2YXIgYT1uKGksXCIuXCIrcyx2b2lkIDAscik7dC5pbnNlcnRSdWxlcyhyLHMsYSl9by5wdXNoKHMpLHRoaXMuc3RhdGljUnVsZXNJZD1zfWVsc2V7Zm9yKHZhciBjPXRoaXMucnVsZXMubGVuZ3RoLHU9dGUodGhpcy5iYXNlSGFzaCxuLmhhc2gpLGw9XCJcIixkPTA7ZDxjO2QrKyl7dmFyIGg9dGhpcy5ydWxlc1tkXTtpZihcInN0cmluZ1wiPT10eXBlb2YgaClsKz1oLFwicHJvZHVjdGlvblwiIT09cHJvY2Vzcy5lbnYuTk9ERV9FTlYmJih1PXRlKHUsaCtkKSk7ZWxzZSBpZihoKXt2YXIgcD1OZShoLGUsdCxuKSxmPUFycmF5LmlzQXJyYXkocCk/cC5qb2luKFwiXCIpOnA7dT10ZSh1LGYrZCksbCs9Zn19aWYobCl7dmFyIG09ZWUodT4+PjApO2lmKCF0Lmhhc05hbWVGb3JJZChyLG0pKXt2YXIgeT1uKGwsXCIuXCIrbSx2b2lkIDAscik7dC5pbnNlcnRSdWxlcyhyLG0seSl9by5wdXNoKG0pfX1yZXR1cm4gby5qb2luKFwiIFwiKX0sZX0oKSxzZT0vXlxccypcXC9cXC8uKiQvZ20sYWU9W1wiOlwiLFwiW1wiLFwiLlwiLFwiI1wiXTtmdW5jdGlvbiBjZShlKXt2YXIgdCxuLHIsbyxpPXZvaWQgMD09PWU/RTplLHM9aS5vcHRpb25zLGE9dm9pZCAwPT09cz9FOnMsYz1pLnBsdWdpbnMsdT12b2lkIDA9PT1jP3c6YyxsPW5ldyBwKGEpLGQ9W10saD1mdW5jdGlvbihlKXtmdW5jdGlvbiB0KHQpe2lmKHQpdHJ5e2UodCtcIn1cIil9Y2F0Y2goZSl7fX1yZXR1cm4gZnVuY3Rpb24obixyLG8saSxzLGEsYyx1LGwsZCl7c3dpdGNoKG4pe2Nhc2UgMTppZigwPT09bCYmNjQ9PT1yLmNoYXJDb2RlQXQoMCkpcmV0dXJuIGUocitcIjtcIiksXCJcIjticmVhaztjYXNlIDI6aWYoMD09PXUpcmV0dXJuIHIrXCIvKnwqL1wiO2JyZWFrO2Nhc2UgMzpzd2l0Y2godSl7Y2FzZSAxMDI6Y2FzZSAxMTI6cmV0dXJuIGUob1swXStyKSxcIlwiO2RlZmF1bHQ6cmV0dXJuIHIrKDA9PT1kP1wiLyp8Ki9cIjpcIlwiKX1jYXNlLTI6ci5zcGxpdChcIi8qfCovfVwiKS5mb3JFYWNoKHQpfX19KChmdW5jdGlvbihlKXtkLnB1c2goZSl9KSksZj1mdW5jdGlvbihlLHIsaSl7cmV0dXJuIDA9PT1yJiYtMSE9PWFlLmluZGV4T2YoaVtuLmxlbmd0aF0pfHxpLm1hdGNoKG8pP2U6XCIuXCIrdH07ZnVuY3Rpb24gbShlLGkscyxhKXt2b2lkIDA9PT1hJiYoYT1cIiZcIik7dmFyIGM9ZS5yZXBsYWNlKHNlLFwiXCIpLHU9aSYmcz9zK1wiIFwiK2krXCIgeyBcIitjK1wiIH1cIjpjO3JldHVybiB0PWEsbj1pLHI9bmV3IFJlZ0V4cChcIlxcXFxcIituK1wiXFxcXGJcIixcImdcIiksbz1uZXcgUmVnRXhwKFwiKFxcXFxcIituK1wiXFxcXGIpezIsfVwiKSxsKHN8fCFpP1wiXCI6aSx1KX1yZXR1cm4gbC51c2UoW10uY29uY2F0KHUsW2Z1bmN0aW9uKGUsdCxvKXsyPT09ZSYmby5sZW5ndGgmJm9bMF0ubGFzdEluZGV4T2Yobik+MCYmKG9bMF09b1swXS5yZXBsYWNlKHIsZikpfSxoLGZ1bmN0aW9uKGUpe2lmKC0yPT09ZSl7dmFyIHQ9ZDtyZXR1cm4gZD1bXSx0fX1dKSksbS5oYXNoPXUubGVuZ3RoP3UucmVkdWNlKChmdW5jdGlvbihlLHQpe3JldHVybiB0Lm5hbWV8fGooMTUpLHRlKGUsdC5uYW1lKX0pLDUzODEpLnRvU3RyaW5nKCk6XCJcIixtfXZhciB1ZT1yLmNyZWF0ZUNvbnRleHQoKSxsZT11ZS5Db25zdW1lcixkZT1yLmNyZWF0ZUNvbnRleHQoKSxoZT0oZGUuQ29uc3VtZXIsbmV3IFopLHBlPWNlKCk7ZnVuY3Rpb24gZmUoKXtyZXR1cm4gaSh1ZSl8fGhlfWZ1bmN0aW9uIG1lKCl7cmV0dXJuIGkoZGUpfHxwZX1mdW5jdGlvbiB5ZShlKXt2YXIgdD1vKGUuc3R5bGlzUGx1Z2lucyksbj10WzBdLGk9dFsxXSxjPWZlKCksdT1zKChmdW5jdGlvbigpe3ZhciB0PWM7cmV0dXJuIGUuc2hlZXQ/dD1lLnNoZWV0OmUudGFyZ2V0JiYodD10LnJlY29uc3RydWN0V2l0aE9wdGlvbnMoe3RhcmdldDplLnRhcmdldH0sITEpKSxlLmRpc2FibGVDU1NPTUluamVjdGlvbiYmKHQ9dC5yZWNvbnN0cnVjdFdpdGhPcHRpb25zKHt1c2VDU1NPTUluamVjdGlvbjohMX0pKSx0fSksW2UuZGlzYWJsZUNTU09NSW5qZWN0aW9uLGUuc2hlZXQsZS50YXJnZXRdKSxsPXMoKGZ1bmN0aW9uKCl7cmV0dXJuIGNlKHtvcHRpb25zOntwcmVmaXg6IWUuZGlzYWJsZVZlbmRvclByZWZpeGVzfSxwbHVnaW5zOm59KX0pLFtlLmRpc2FibGVWZW5kb3JQcmVmaXhlcyxuXSk7cmV0dXJuIGEoKGZ1bmN0aW9uKCl7aChuLGUuc3R5bGlzUGx1Z2lucyl8fGkoZS5zdHlsaXNQbHVnaW5zKX0pLFtlLnN0eWxpc1BsdWdpbnNdKSxyLmNyZWF0ZUVsZW1lbnQodWUuUHJvdmlkZXIse3ZhbHVlOnV9LHIuY3JlYXRlRWxlbWVudChkZS5Qcm92aWRlcix7dmFsdWU6bH0sXCJwcm9kdWN0aW9uXCIhPT1wcm9jZXNzLmVudi5OT0RFX0VOVj9yLkNoaWxkcmVuLm9ubHkoZS5jaGlsZHJlbik6ZS5jaGlsZHJlbikpfXZhciB2ZT1mdW5jdGlvbigpe2Z1bmN0aW9uIGUoZSx0KXt2YXIgbj10aGlzO3RoaXMuaW5qZWN0PWZ1bmN0aW9uKGUsdCl7dm9pZCAwPT09dCYmKHQ9cGUpO3ZhciByPW4ubmFtZSt0Lmhhc2g7ZS5oYXNOYW1lRm9ySWQobi5pZCxyKXx8ZS5pbnNlcnRSdWxlcyhuLmlkLHIsdChuLnJ1bGVzLHIsXCJAa2V5ZnJhbWVzXCIpKX0sdGhpcy50b1N0cmluZz1mdW5jdGlvbigpe3JldHVybiBqKDEyLFN0cmluZyhuLm5hbWUpKX0sdGhpcy5uYW1lPWUsdGhpcy5pZD1cInNjLWtleWZyYW1lcy1cIitlLHRoaXMucnVsZXM9dH1yZXR1cm4gZS5wcm90b3R5cGUuZ2V0TmFtZT1mdW5jdGlvbihlKXtyZXR1cm4gdm9pZCAwPT09ZSYmKGU9cGUpLHRoaXMubmFtZStlLmhhc2h9LGV9KCksZ2U9LyhbQS1aXSkvLFNlPS8oW0EtWl0pL2csd2U9L15tcy0vLEVlPWZ1bmN0aW9uKGUpe3JldHVyblwiLVwiK2UudG9Mb3dlckNhc2UoKX07ZnVuY3Rpb24gYmUoZSl7cmV0dXJuIGdlLnRlc3QoZSk/ZS5yZXBsYWNlKFNlLEVlKS5yZXBsYWNlKHdlLFwiLW1zLVwiKTplfXZhciBfZT1mdW5jdGlvbihlKXtyZXR1cm4gbnVsbD09ZXx8ITE9PT1lfHxcIlwiPT09ZX07ZnVuY3Rpb24gTmUoZSxuLHIsbyl7aWYoQXJyYXkuaXNBcnJheShlKSl7Zm9yKHZhciBpLHM9W10sYT0wLGM9ZS5sZW5ndGg7YTxjO2ErPTEpXCJcIiE9PShpPU5lKGVbYV0sbixyLG8pKSYmKEFycmF5LmlzQXJyYXkoaSk/cy5wdXNoLmFwcGx5KHMsaSk6cy5wdXNoKGkpKTtyZXR1cm4gc31pZihfZShlKSlyZXR1cm5cIlwiO2lmKE4oZSkpcmV0dXJuXCIuXCIrZS5zdHlsZWRDb21wb25lbnRJZDtpZihiKGUpKXtpZihcImZ1bmN0aW9uXCIhPXR5cGVvZihsPWUpfHxsLnByb3RvdHlwZSYmbC5wcm90b3R5cGUuaXNSZWFjdENvbXBvbmVudHx8IW4pcmV0dXJuIGU7dmFyIHU9ZShuKTtyZXR1cm5cInByb2R1Y3Rpb25cIiE9PXByb2Nlc3MuZW52Lk5PREVfRU5WJiZ0KHUpJiZjb25zb2xlLndhcm4oXyhlKStcIiBpcyBub3QgYSBzdHlsZWQgY29tcG9uZW50IGFuZCBjYW5ub3QgYmUgcmVmZXJyZWQgdG8gdmlhIGNvbXBvbmVudCBzZWxlY3Rvci4gU2VlIGh0dHBzOi8vd3d3LnN0eWxlZC1jb21wb25lbnRzLmNvbS9kb2NzL2FkdmFuY2VkI3JlZmVycmluZy10by1vdGhlci1jb21wb25lbnRzIGZvciBtb3JlIGRldGFpbHMuXCIpLE5lKHUsbixyLG8pfXZhciBsO3JldHVybiBlIGluc3RhbmNlb2YgdmU/cj8oZS5pbmplY3QocixvKSxlLmdldE5hbWUobykpOmU6UyhlKT9mdW5jdGlvbiBlKHQsbil7dmFyIHIsbyxpPVtdO2Zvcih2YXIgcyBpbiB0KXQuaGFzT3duUHJvcGVydHkocykmJiFfZSh0W3NdKSYmKFModFtzXSk/aS5wdXNoLmFwcGx5KGksZSh0W3NdLHMpKTpiKHRbc10pP2kucHVzaChiZShzKStcIjpcIix0W3NdLFwiO1wiKTppLnB1c2goYmUocykrXCI6IFwiKyhyPXMsbnVsbD09KG89dFtzXSl8fFwiYm9vbGVhblwiPT10eXBlb2Ygb3x8XCJcIj09PW8/XCJcIjpcIm51bWJlclwiIT10eXBlb2Ygb3x8MD09PW98fHIgaW4gZj9TdHJpbmcobykudHJpbSgpOm8rXCJweFwiKStcIjtcIikpO3JldHVybiBuP1tuK1wiIHtcIl0uY29uY2F0KGksW1wifVwiXSk6aX0oZSk6ZS50b1N0cmluZygpfWZ1bmN0aW9uIEFlKGUpe2Zvcih2YXIgdD1hcmd1bWVudHMubGVuZ3RoLG49bmV3IEFycmF5KHQ+MT90LTE6MCkscj0xO3I8dDtyKyspbltyLTFdPWFyZ3VtZW50c1tyXTtyZXR1cm4gYihlKXx8UyhlKT9OZShnKHcsW2VdLmNvbmNhdChuKSkpOjA9PT1uLmxlbmd0aCYmMT09PWUubGVuZ3RoJiZcInN0cmluZ1wiPT10eXBlb2YgZVswXT9lOk5lKGcoZSxuKSl9dmFyIENlPS9pbnZhbGlkIGhvb2sgY2FsbC9pLEllPW5ldyBTZXQsUGU9ZnVuY3Rpb24oZSx0KXtpZihcInByb2R1Y3Rpb25cIiE9PXByb2Nlc3MuZW52Lk5PREVfRU5WKXt2YXIgbj1cIlRoZSBjb21wb25lbnQgXCIrZSsodD8nIHdpdGggdGhlIGlkIG9mIFwiJyt0KydcIic6XCJcIikrXCIgaGFzIGJlZW4gY3JlYXRlZCBkeW5hbWljYWxseS5cXG5Zb3UgbWF5IHNlZSB0aGlzIHdhcm5pbmcgYmVjYXVzZSB5b3UndmUgY2FsbGVkIHN0eWxlZCBpbnNpZGUgYW5vdGhlciBjb21wb25lbnQuXFxuVG8gcmVzb2x2ZSB0aGlzIG9ubHkgY3JlYXRlIG5ldyBTdHlsZWRDb21wb25lbnRzIG91dHNpZGUgb2YgYW55IHJlbmRlciBtZXRob2QgYW5kIGZ1bmN0aW9uIGNvbXBvbmVudC5cIjt0cnl7YygpLEllLmhhcyhuKXx8KGNvbnNvbGUud2FybihuKSxJZS5hZGQobikpfWNhdGNoKGUpe0NlLnRlc3QoZS5tZXNzYWdlKSYmSWUuZGVsZXRlKG4pfX19LE9lPWZ1bmN0aW9uKGUsdCxuKXtyZXR1cm4gdm9pZCAwPT09biYmKG49RSksZS50aGVtZSE9PW4udGhlbWUmJmUudGhlbWV8fHR8fG4udGhlbWV9LFJlPS9bIVwiIyQlJicoKSorLC4vOjs8PT4/QFtcXFxcXFxdXmB7fH1+LV0rL2csRGU9LyheLXwtJCkvZztmdW5jdGlvbiBqZShlKXtyZXR1cm4gZS5yZXBsYWNlKFJlLFwiLVwiKS5yZXBsYWNlKERlLFwiXCIpfXZhciBUZT1mdW5jdGlvbihlKXtyZXR1cm4gZWUobmUoZSk+Pj4wKX07ZnVuY3Rpb24ga2UoZSl7cmV0dXJuXCJzdHJpbmdcIj09dHlwZW9mIGUmJihcInByb2R1Y3Rpb25cIj09PXByb2Nlc3MuZW52Lk5PREVfRU5WfHxlLmNoYXJBdCgwKT09PWUuY2hhckF0KDApLnRvTG93ZXJDYXNlKCkpfXZhciB4ZT1mdW5jdGlvbihlKXtyZXR1cm5cImZ1bmN0aW9uXCI9PXR5cGVvZiBlfHxcIm9iamVjdFwiPT10eXBlb2YgZSYmbnVsbCE9PWUmJiFBcnJheS5pc0FycmF5KGUpfSxWZT1mdW5jdGlvbihlKXtyZXR1cm5cIl9fcHJvdG9fX1wiIT09ZSYmXCJjb25zdHJ1Y3RvclwiIT09ZSYmXCJwcm90b3R5cGVcIiE9PWV9O2Z1bmN0aW9uIEJlKGUsdCxuKXt2YXIgcj1lW25dO3hlKHQpJiZ4ZShyKT9NZShyLHQpOmVbbl09dH1mdW5jdGlvbiBNZShlKXtmb3IodmFyIHQ9YXJndW1lbnRzLmxlbmd0aCxuPW5ldyBBcnJheSh0PjE/dC0xOjApLHI9MTtyPHQ7cisrKW5bci0xXT1hcmd1bWVudHNbcl07Zm9yKHZhciBvPTAsaT1uO288aS5sZW5ndGg7bysrKXt2YXIgcz1pW29dO2lmKHhlKHMpKWZvcih2YXIgYSBpbiBzKVZlKGEpJiZCZShlLHNbYV0sYSl9cmV0dXJuIGV9dmFyIHplPXIuY3JlYXRlQ29udGV4dCgpLExlPXplLkNvbnN1bWVyO2Z1bmN0aW9uIEdlKGUpe3ZhciB0PWkoemUpLG49cygoZnVuY3Rpb24oKXtyZXR1cm4gZnVuY3Rpb24oZSx0KXtpZighZSlyZXR1cm4gaigxNCk7aWYoYihlKSl7dmFyIG49ZSh0KTtyZXR1cm5cInByb2R1Y3Rpb25cIj09PXByb2Nlc3MuZW52Lk5PREVfRU5WfHxudWxsIT09biYmIUFycmF5LmlzQXJyYXkobikmJlwib2JqZWN0XCI9PXR5cGVvZiBuP246aig3KX1yZXR1cm4gQXJyYXkuaXNBcnJheShlKXx8XCJvYmplY3RcIiE9dHlwZW9mIGU/aig4KTp0P3Yoe30sdCx7fSxlKTplfShlLnRoZW1lLHQpfSksW2UudGhlbWUsdF0pO3JldHVybiBlLmNoaWxkcmVuP3IuY3JlYXRlRWxlbWVudCh6ZS5Qcm92aWRlcix7dmFsdWU6bn0sZS5jaGlsZHJlbik6bnVsbH12YXIgRmU9e307ZnVuY3Rpb24gWWUoZSx0LG4pe3ZhciBvPU4oZSkscz0ha2UoZSksYT10LmF0dHJzLGM9dm9pZCAwPT09YT93OmEsZD10LmNvbXBvbmVudElkLGg9dm9pZCAwPT09ZD9mdW5jdGlvbihlLHQpe3ZhciBuPVwic3RyaW5nXCIhPXR5cGVvZiBlP1wic2NcIjpqZShlKTtGZVtuXT0oRmVbbl18fDApKzE7dmFyIHI9bitcIi1cIitUZShcIjUuMy4wXCIrbitGZVtuXSk7cmV0dXJuIHQ/dCtcIi1cIityOnJ9KHQuZGlzcGxheU5hbWUsdC5wYXJlbnRDb21wb25lbnRJZCk6ZCxwPXQuZGlzcGxheU5hbWUsZj12b2lkIDA9PT1wP2Z1bmN0aW9uKGUpe3JldHVybiBrZShlKT9cInN0eWxlZC5cIitlOlwiU3R5bGVkKFwiK18oZSkrXCIpXCJ9KGUpOnAsZz10LmRpc3BsYXlOYW1lJiZ0LmNvbXBvbmVudElkP2plKHQuZGlzcGxheU5hbWUpK1wiLVwiK3QuY29tcG9uZW50SWQ6dC5jb21wb25lbnRJZHx8aCxTPW8mJmUuYXR0cnM/QXJyYXkucHJvdG90eXBlLmNvbmNhdChlLmF0dHJzLGMpLmZpbHRlcihCb29sZWFuKTpjLEE9dC5zaG91bGRGb3J3YXJkUHJvcDtvJiZlLnNob3VsZEZvcndhcmRQcm9wJiYoQT10LnNob3VsZEZvcndhcmRQcm9wP2Z1bmN0aW9uKG4scixvKXtyZXR1cm4gZS5zaG91bGRGb3J3YXJkUHJvcChuLHIsbykmJnQuc2hvdWxkRm9yd2FyZFByb3AobixyLG8pfTplLnNob3VsZEZvcndhcmRQcm9wKTt2YXIgQyxJPW5ldyBpZShuLGcsbz9lLmNvbXBvbmVudFN0eWxlOnZvaWQgMCksUD1JLmlzU3RhdGljJiYwPT09Yy5sZW5ndGgsTz1mdW5jdGlvbihlLHQpe3JldHVybiBmdW5jdGlvbihlLHQsbixyKXt2YXIgbz1lLmF0dHJzLHM9ZS5jb21wb25lbnRTdHlsZSxhPWUuZGVmYXVsdFByb3BzLGM9ZS5mb2xkZWRDb21wb25lbnRJZHMsZD1lLnNob3VsZEZvcndhcmRQcm9wLGg9ZS5zdHlsZWRDb21wb25lbnRJZCxwPWUudGFyZ2V0O1wicHJvZHVjdGlvblwiIT09cHJvY2Vzcy5lbnYuTk9ERV9FTlYmJmwoaCk7dmFyIGY9ZnVuY3Rpb24oZSx0LG4pe3ZvaWQgMD09PWUmJihlPUUpO3ZhciByPXYoe30sdCx7dGhlbWU6ZX0pLG89e307cmV0dXJuIG4uZm9yRWFjaCgoZnVuY3Rpb24oZSl7dmFyIHQsbixpLHM9ZTtmb3IodCBpbiBiKHMpJiYocz1zKHIpKSxzKXJbdF09b1t0XT1cImNsYXNzTmFtZVwiPT09dD8obj1vW3RdLGk9c1t0XSxuJiZpP24rXCIgXCIraTpufHxpKTpzW3RdfSkpLFtyLG9dfShPZSh0LGkoemUpLGEpfHxFLHQsbykseT1mWzBdLGc9ZlsxXSxTPWZ1bmN0aW9uKGUsdCxuLHIpe3ZhciBvPWZlKCksaT1tZSgpLHM9dD9lLmdlbmVyYXRlQW5kSW5qZWN0U3R5bGVzKEUsbyxpKTplLmdlbmVyYXRlQW5kSW5qZWN0U3R5bGVzKG4sbyxpKTtyZXR1cm5cInByb2R1Y3Rpb25cIiE9PXByb2Nlc3MuZW52Lk5PREVfRU5WJiZsKHMpLFwicHJvZHVjdGlvblwiIT09cHJvY2Vzcy5lbnYuTk9ERV9FTlYmJiF0JiZyJiZyKHMpLHN9KHMscix5LFwicHJvZHVjdGlvblwiIT09cHJvY2Vzcy5lbnYuTk9ERV9FTlY/ZS53YXJuVG9vTWFueUNsYXNzZXM6dm9pZCAwKSx3PW4sXz1nLiRhc3x8dC4kYXN8fGcuYXN8fHQuYXN8fHAsTj1rZShfKSxBPWchPT10P3Yoe30sdCx7fSxnKTp0LEM9e307Zm9yKHZhciBJIGluIEEpXCIkXCIhPT1JWzBdJiZcImFzXCIhPT1JJiYoXCJmb3J3YXJkZWRBc1wiPT09ST9DLmFzPUFbSV06KGQ/ZChJLG0sXyk6IU58fG0oSSkpJiYoQ1tJXT1BW0ldKSk7cmV0dXJuIHQuc3R5bGUmJmcuc3R5bGUhPT10LnN0eWxlJiYoQy5zdHlsZT12KHt9LHQuc3R5bGUse30sZy5zdHlsZSkpLEMuY2xhc3NOYW1lPUFycmF5LnByb3RvdHlwZS5jb25jYXQoYyxoLFMhPT1oP1M6bnVsbCx0LmNsYXNzTmFtZSxnLmNsYXNzTmFtZSkuZmlsdGVyKEJvb2xlYW4pLmpvaW4oXCIgXCIpLEMucmVmPXcsdShfLEMpfShDLGUsdCxQKX07cmV0dXJuIE8uZGlzcGxheU5hbWU9ZiwoQz1yLmZvcndhcmRSZWYoTykpLmF0dHJzPVMsQy5jb21wb25lbnRTdHlsZT1JLEMuZGlzcGxheU5hbWU9ZixDLnNob3VsZEZvcndhcmRQcm9wPUEsQy5mb2xkZWRDb21wb25lbnRJZHM9bz9BcnJheS5wcm90b3R5cGUuY29uY2F0KGUuZm9sZGVkQ29tcG9uZW50SWRzLGUuc3R5bGVkQ29tcG9uZW50SWQpOncsQy5zdHlsZWRDb21wb25lbnRJZD1nLEMudGFyZ2V0PW8/ZS50YXJnZXQ6ZSxDLndpdGhDb21wb25lbnQ9ZnVuY3Rpb24oZSl7dmFyIHI9dC5jb21wb25lbnRJZCxvPWZ1bmN0aW9uKGUsdCl7aWYobnVsbD09ZSlyZXR1cm57fTt2YXIgbixyLG89e30saT1PYmplY3Qua2V5cyhlKTtmb3Iocj0wO3I8aS5sZW5ndGg7cisrKW49aVtyXSx0LmluZGV4T2Yobik+PTB8fChvW25dPWVbbl0pO3JldHVybiBvfSh0LFtcImNvbXBvbmVudElkXCJdKSxpPXImJnIrXCItXCIrKGtlKGUpP2U6amUoXyhlKSkpO3JldHVybiBZZShlLHYoe30sbyx7YXR0cnM6Uyxjb21wb25lbnRJZDppfSksbil9LE9iamVjdC5kZWZpbmVQcm9wZXJ0eShDLFwiZGVmYXVsdFByb3BzXCIse2dldDpmdW5jdGlvbigpe3JldHVybiB0aGlzLl9mb2xkZWREZWZhdWx0UHJvcHN9LHNldDpmdW5jdGlvbih0KXt0aGlzLl9mb2xkZWREZWZhdWx0UHJvcHM9bz9NZSh7fSxlLmRlZmF1bHRQcm9wcyx0KTp0fX0pLFwicHJvZHVjdGlvblwiIT09cHJvY2Vzcy5lbnYuTk9ERV9FTlYmJihQZShmLGcpLEMud2FyblRvb01hbnlDbGFzc2VzPWZ1bmN0aW9uKGUsdCl7dmFyIG49e30scj0hMTtyZXR1cm4gZnVuY3Rpb24obyl7aWYoIXImJihuW29dPSEwLE9iamVjdC5rZXlzKG4pLmxlbmd0aD49MjAwKSl7dmFyIGk9dD8nIHdpdGggdGhlIGlkIG9mIFwiJyt0KydcIic6XCJcIjtjb25zb2xlLndhcm4oXCJPdmVyIDIwMCBjbGFzc2VzIHdlcmUgZ2VuZXJhdGVkIGZvciBjb21wb25lbnQgXCIrZStpK1wiLlxcbkNvbnNpZGVyIHVzaW5nIHRoZSBhdHRycyBtZXRob2QsIHRvZ2V0aGVyIHdpdGggYSBzdHlsZSBvYmplY3QgZm9yIGZyZXF1ZW50bHkgY2hhbmdlZCBzdHlsZXMuXFxuRXhhbXBsZTpcXG4gIGNvbnN0IENvbXBvbmVudCA9IHN0eWxlZC5kaXYuYXR0cnMocHJvcHMgPT4gKHtcXG4gICAgc3R5bGU6IHtcXG4gICAgICBiYWNrZ3JvdW5kOiBwcm9wcy5iYWNrZ3JvdW5kLFxcbiAgICB9LFxcbiAgfSkpYHdpZHRoOiAxMDAlO2BcXG5cXG4gIDxDb21wb25lbnQgLz5cIikscj0hMCxuPXt9fX19KGYsZykpLEMudG9TdHJpbmc9ZnVuY3Rpb24oKXtyZXR1cm5cIi5cIitDLnN0eWxlZENvbXBvbmVudElkfSxzJiZ5KEMsZSx7YXR0cnM6ITAsY29tcG9uZW50U3R5bGU6ITAsZGlzcGxheU5hbWU6ITAsZm9sZGVkQ29tcG9uZW50SWRzOiEwLHNob3VsZEZvcndhcmRQcm9wOiEwLHN0eWxlZENvbXBvbmVudElkOiEwLHRhcmdldDohMCx3aXRoQ29tcG9uZW50OiEwfSksQ312YXIgcWU9ZnVuY3Rpb24oZSl7cmV0dXJuIGZ1bmN0aW9uIGUodCxyLG8pe2lmKHZvaWQgMD09PW8mJihvPUUpLCFuKHIpKXJldHVybiBqKDEsU3RyaW5nKHIpKTt2YXIgaT1mdW5jdGlvbigpe3JldHVybiB0KHIsbyxBZS5hcHBseSh2b2lkIDAsYXJndW1lbnRzKSl9O3JldHVybiBpLndpdGhDb25maWc9ZnVuY3Rpb24obil7cmV0dXJuIGUodCxyLHYoe30sbyx7fSxuKSl9LGkuYXR0cnM9ZnVuY3Rpb24obil7cmV0dXJuIGUodCxyLHYoe30sbyx7YXR0cnM6QXJyYXkucHJvdG90eXBlLmNvbmNhdChvLmF0dHJzLG4pLmZpbHRlcihCb29sZWFuKX0pKX0saX0oWWUsZSl9O1tcImFcIixcImFiYnJcIixcImFkZHJlc3NcIixcImFyZWFcIixcImFydGljbGVcIixcImFzaWRlXCIsXCJhdWRpb1wiLFwiYlwiLFwiYmFzZVwiLFwiYmRpXCIsXCJiZG9cIixcImJpZ1wiLFwiYmxvY2txdW90ZVwiLFwiYm9keVwiLFwiYnJcIixcImJ1dHRvblwiLFwiY2FudmFzXCIsXCJjYXB0aW9uXCIsXCJjaXRlXCIsXCJjb2RlXCIsXCJjb2xcIixcImNvbGdyb3VwXCIsXCJkYXRhXCIsXCJkYXRhbGlzdFwiLFwiZGRcIixcImRlbFwiLFwiZGV0YWlsc1wiLFwiZGZuXCIsXCJkaWFsb2dcIixcImRpdlwiLFwiZGxcIixcImR0XCIsXCJlbVwiLFwiZW1iZWRcIixcImZpZWxkc2V0XCIsXCJmaWdjYXB0aW9uXCIsXCJmaWd1cmVcIixcImZvb3RlclwiLFwiZm9ybVwiLFwiaDFcIixcImgyXCIsXCJoM1wiLFwiaDRcIixcImg1XCIsXCJoNlwiLFwiaGVhZFwiLFwiaGVhZGVyXCIsXCJoZ3JvdXBcIixcImhyXCIsXCJodG1sXCIsXCJpXCIsXCJpZnJhbWVcIixcImltZ1wiLFwiaW5wdXRcIixcImluc1wiLFwia2JkXCIsXCJrZXlnZW5cIixcImxhYmVsXCIsXCJsZWdlbmRcIixcImxpXCIsXCJsaW5rXCIsXCJtYWluXCIsXCJtYXBcIixcIm1hcmtcIixcIm1hcnF1ZWVcIixcIm1lbnVcIixcIm1lbnVpdGVtXCIsXCJtZXRhXCIsXCJtZXRlclwiLFwibmF2XCIsXCJub3NjcmlwdFwiLFwib2JqZWN0XCIsXCJvbFwiLFwib3B0Z3JvdXBcIixcIm9wdGlvblwiLFwib3V0cHV0XCIsXCJwXCIsXCJwYXJhbVwiLFwicGljdHVyZVwiLFwicHJlXCIsXCJwcm9ncmVzc1wiLFwicVwiLFwicnBcIixcInJ0XCIsXCJydWJ5XCIsXCJzXCIsXCJzYW1wXCIsXCJzY3JpcHRcIixcInNlY3Rpb25cIixcInNlbGVjdFwiLFwic21hbGxcIixcInNvdXJjZVwiLFwic3BhblwiLFwic3Ryb25nXCIsXCJzdHlsZVwiLFwic3ViXCIsXCJzdW1tYXJ5XCIsXCJzdXBcIixcInRhYmxlXCIsXCJ0Ym9keVwiLFwidGRcIixcInRleHRhcmVhXCIsXCJ0Zm9vdFwiLFwidGhcIixcInRoZWFkXCIsXCJ0aW1lXCIsXCJ0aXRsZVwiLFwidHJcIixcInRyYWNrXCIsXCJ1XCIsXCJ1bFwiLFwidmFyXCIsXCJ2aWRlb1wiLFwid2JyXCIsXCJjaXJjbGVcIixcImNsaXBQYXRoXCIsXCJkZWZzXCIsXCJlbGxpcHNlXCIsXCJmb3JlaWduT2JqZWN0XCIsXCJnXCIsXCJpbWFnZVwiLFwibGluZVwiLFwibGluZWFyR3JhZGllbnRcIixcIm1hcmtlclwiLFwibWFza1wiLFwicGF0aFwiLFwicGF0dGVyblwiLFwicG9seWdvblwiLFwicG9seWxpbmVcIixcInJhZGlhbEdyYWRpZW50XCIsXCJyZWN0XCIsXCJzdG9wXCIsXCJzdmdcIixcInRleHRcIixcInRleHRQYXRoXCIsXCJ0c3BhblwiXS5mb3JFYWNoKChmdW5jdGlvbihlKXtxZVtlXT1xZShlKX0pKTt2YXIgSGU9ZnVuY3Rpb24oKXtmdW5jdGlvbiBlKGUsdCl7dGhpcy5ydWxlcz1lLHRoaXMuY29tcG9uZW50SWQ9dCx0aGlzLmlzU3RhdGljPXJlKGUpLFoucmVnaXN0ZXJJZCh0aGlzLmNvbXBvbmVudElkKzEpfXZhciB0PWUucHJvdG90eXBlO3JldHVybiB0LmNyZWF0ZVN0eWxlcz1mdW5jdGlvbihlLHQsbixyKXt2YXIgbz1yKE5lKHRoaXMucnVsZXMsdCxuLHIpLmpvaW4oXCJcIiksXCJcIiksaT10aGlzLmNvbXBvbmVudElkK2U7bi5pbnNlcnRSdWxlcyhpLGksbyl9LHQucmVtb3ZlU3R5bGVzPWZ1bmN0aW9uKGUsdCl7dC5jbGVhclJ1bGVzKHRoaXMuY29tcG9uZW50SWQrZSl9LHQucmVuZGVyU3R5bGVzPWZ1bmN0aW9uKGUsdCxuLHIpe2U+MiYmWi5yZWdpc3RlcklkKHRoaXMuY29tcG9uZW50SWQrZSksdGhpcy5yZW1vdmVTdHlsZXMoZSxuKSx0aGlzLmNyZWF0ZVN0eWxlcyhlLHQsbixyKX0sZX0oKTtmdW5jdGlvbiAkZShlKXtmb3IodmFyIHQ9YXJndW1lbnRzLmxlbmd0aCxuPW5ldyBBcnJheSh0PjE/dC0xOjApLG89MTtvPHQ7bysrKW5bby0xXT1hcmd1bWVudHNbb107dmFyIHM9QWUuYXBwbHkodm9pZCAwLFtlXS5jb25jYXQobikpLGE9XCJzYy1nbG9iYWwtXCIrVGUoSlNPTi5zdHJpbmdpZnkocykpLHU9bmV3IEhlKHMsYSk7ZnVuY3Rpb24gbChlKXt2YXIgdD1mZSgpLG49bWUoKSxvPWkoemUpLGw9Yyh0LmFsbG9jYXRlR1NJbnN0YW5jZShhKSkuY3VycmVudDtyZXR1cm5cInByb2R1Y3Rpb25cIiE9PXByb2Nlc3MuZW52Lk5PREVfRU5WJiZyLkNoaWxkcmVuLmNvdW50KGUuY2hpbGRyZW4pJiZjb25zb2xlLndhcm4oXCJUaGUgZ2xvYmFsIHN0eWxlIGNvbXBvbmVudCBcIithK1wiIHdhcyBnaXZlbiBjaGlsZCBKU1guIGNyZWF0ZUdsb2JhbFN0eWxlIGRvZXMgbm90IHJlbmRlciBjaGlsZHJlbi5cIiksXCJwcm9kdWN0aW9uXCIhPT1wcm9jZXNzLmVudi5OT0RFX0VOViYmcy5zb21lKChmdW5jdGlvbihlKXtyZXR1cm5cInN0cmluZ1wiPT10eXBlb2YgZSYmLTEhPT1lLmluZGV4T2YoXCJAaW1wb3J0XCIpfSkpJiZjb25zb2xlLndhcm4oXCJQbGVhc2UgZG8gbm90IHVzZSBAaW1wb3J0IENTUyBzeW50YXggaW4gY3JlYXRlR2xvYmFsU3R5bGUgYXQgdGhpcyB0aW1lLCBhcyB0aGUgQ1NTT00gQVBJcyB3ZSB1c2UgaW4gcHJvZHVjdGlvbiBkbyBub3QgaGFuZGxlIGl0IHdlbGwuIEluc3RlYWQsIHdlIHJlY29tbWVuZCB1c2luZyBhIGxpYnJhcnkgc3VjaCBhcyByZWFjdC1oZWxtZXQgdG8gaW5qZWN0IGEgdHlwaWNhbCA8bGluaz4gbWV0YSB0YWcgdG8gdGhlIHN0eWxlc2hlZXQsIG9yIHNpbXBseSBlbWJlZGRpbmcgaXQgbWFudWFsbHkgaW4geW91ciBpbmRleC5odG1sIDxoZWFkPiBzZWN0aW9uIGZvciBhIHNpbXBsZXIgYXBwLlwiKSxkKChmdW5jdGlvbigpe3JldHVybiBoKGwsZSx0LG8sbiksZnVuY3Rpb24oKXtyZXR1cm4gdS5yZW1vdmVTdHlsZXMobCx0KX19KSxbbCxlLHQsbyxuXSksbnVsbH1mdW5jdGlvbiBoKGUsdCxuLHIsbyl7aWYodS5pc1N0YXRpYyl1LnJlbmRlclN0eWxlcyhlLE8sbixvKTtlbHNle3ZhciBpPXYoe30sdCx7dGhlbWU6T2UodCxyLGwuZGVmYXVsdFByb3BzKX0pO3UucmVuZGVyU3R5bGVzKGUsaSxuLG8pfX1yZXR1cm5cInByb2R1Y3Rpb25cIiE9PXByb2Nlc3MuZW52Lk5PREVfRU5WJiZQZShhKSxyLm1lbW8obCl9ZnVuY3Rpb24gV2UoZSl7XCJwcm9kdWN0aW9uXCIhPT1wcm9jZXNzLmVudi5OT0RFX0VOViYmXCJ1bmRlZmluZWRcIiE9dHlwZW9mIG5hdmlnYXRvciYmXCJSZWFjdE5hdGl2ZVwiPT09bmF2aWdhdG9yLnByb2R1Y3QmJmNvbnNvbGUud2FybihcImBrZXlmcmFtZXNgIGNhbm5vdCBiZSB1c2VkIG9uIFJlYWN0TmF0aXZlLCBvbmx5IG9uIHRoZSB3ZWIuIFRvIGRvIGFuaW1hdGlvbiBpbiBSZWFjdE5hdGl2ZSBwbGVhc2UgdXNlIEFuaW1hdGVkLlwiKTtmb3IodmFyIHQ9YXJndW1lbnRzLmxlbmd0aCxuPW5ldyBBcnJheSh0PjE/dC0xOjApLHI9MTtyPHQ7cisrKW5bci0xXT1hcmd1bWVudHNbcl07dmFyIG89QWUuYXBwbHkodm9pZCAwLFtlXS5jb25jYXQobikpLmpvaW4oXCJcIiksaT1UZShvKTtyZXR1cm4gbmV3IHZlKGksbyl9dmFyIFVlPWZ1bmN0aW9uKCl7ZnVuY3Rpb24gZSgpe3ZhciBlPXRoaXM7dGhpcy5fZW1pdFNoZWV0Q1NTPWZ1bmN0aW9uKCl7dmFyIHQ9ZS5pbnN0YW5jZS50b1N0cmluZygpLG49cSgpO3JldHVyblwiPHN0eWxlIFwiK1tuJiYnbm9uY2U9XCInK24rJ1wiJyxBKyc9XCJ0cnVlXCInLCdkYXRhLXN0eWxlZC12ZXJzaW9uPVwiNS4zLjBcIiddLmZpbHRlcihCb29sZWFuKS5qb2luKFwiIFwiKStcIj5cIit0K1wiPC9zdHlsZT5cIn0sdGhpcy5nZXRTdHlsZVRhZ3M9ZnVuY3Rpb24oKXtyZXR1cm4gZS5zZWFsZWQ/aigyKTplLl9lbWl0U2hlZXRDU1MoKX0sdGhpcy5nZXRTdHlsZUVsZW1lbnQ9ZnVuY3Rpb24oKXt2YXIgdDtpZihlLnNlYWxlZClyZXR1cm4gaigyKTt2YXIgbj0oKHQ9e30pW0FdPVwiXCIsdFtcImRhdGEtc3R5bGVkLXZlcnNpb25cIl09XCI1LjMuMFwiLHQuZGFuZ2Vyb3VzbHlTZXRJbm5lckhUTUw9e19faHRtbDplLmluc3RhbmNlLnRvU3RyaW5nKCl9LHQpLG89cSgpO3JldHVybiBvJiYobi5ub25jZT1vKSxbci5jcmVhdGVFbGVtZW50KFwic3R5bGVcIix2KHt9LG4se2tleTpcInNjLTAtMFwifSkpXX0sdGhpcy5zZWFsPWZ1bmN0aW9uKCl7ZS5zZWFsZWQ9ITB9LHRoaXMuaW5zdGFuY2U9bmV3IFooe2lzU2VydmVyOiEwfSksdGhpcy5zZWFsZWQ9ITF9dmFyIHQ9ZS5wcm90b3R5cGU7cmV0dXJuIHQuY29sbGVjdFN0eWxlcz1mdW5jdGlvbihlKXtyZXR1cm4gdGhpcy5zZWFsZWQ/aigyKTpyLmNyZWF0ZUVsZW1lbnQoeWUse3NoZWV0OnRoaXMuaW5zdGFuY2V9LGUpfSx0LmludGVybGVhdmVXaXRoTm9kZVN0cmVhbT1mdW5jdGlvbihlKXtyZXR1cm4gaigzKX0sZX0oKSxKZT1mdW5jdGlvbihlKXt2YXIgdD1yLmZvcndhcmRSZWYoKGZ1bmN0aW9uKHQsbil7dmFyIG89aSh6ZSkscz1lLmRlZmF1bHRQcm9wcyxhPU9lKHQsbyxzKTtyZXR1cm5cInByb2R1Y3Rpb25cIiE9PXByb2Nlc3MuZW52Lk5PREVfRU5WJiZ2b2lkIDA9PT1hJiZjb25zb2xlLndhcm4oJ1t3aXRoVGhlbWVdIFlvdSBhcmUgbm90IHVzaW5nIGEgVGhlbWVQcm92aWRlciBub3IgcGFzc2luZyBhIHRoZW1lIHByb3Agb3IgYSB0aGVtZSBpbiBkZWZhdWx0UHJvcHMgaW4gY29tcG9uZW50IGNsYXNzIFwiJytfKGUpKydcIicpLHIuY3JlYXRlRWxlbWVudChlLHYoe30sdCx7dGhlbWU6YSxyZWY6bn0pKX0pKTtyZXR1cm4geSh0LGUpLHQuZGlzcGxheU5hbWU9XCJXaXRoVGhlbWUoXCIrXyhlKStcIilcIix0fSxYZT1mdW5jdGlvbigpe3JldHVybiBpKHplKX0sWmU9e1N0eWxlU2hlZXQ6WixtYXN0ZXJTaGVldDpoZX07XCJwcm9kdWN0aW9uXCIhPT1wcm9jZXNzLmVudi5OT0RFX0VOViYmXCJ1bmRlZmluZWRcIiE9dHlwZW9mIG5hdmlnYXRvciYmXCJSZWFjdE5hdGl2ZVwiPT09bmF2aWdhdG9yLnByb2R1Y3QmJmNvbnNvbGUud2FybihcIkl0IGxvb2tzIGxpa2UgeW91J3ZlIGltcG9ydGVkICdzdHlsZWQtY29tcG9uZW50cycgb24gUmVhY3QgTmF0aXZlLlxcblBlcmhhcHMgeW91J3JlIGxvb2tpbmcgdG8gaW1wb3J0ICdzdHlsZWQtY29tcG9uZW50cy9uYXRpdmUnP1xcblJlYWQgbW9yZSBhYm91dCB0aGlzIGF0IGh0dHBzOi8vd3d3LnN0eWxlZC1jb21wb25lbnRzLmNvbS9kb2NzL2Jhc2ljcyNyZWFjdC1uYXRpdmVcIiksXCJwcm9kdWN0aW9uXCIhPT1wcm9jZXNzLmVudi5OT0RFX0VOViYmXCJ0ZXN0XCIhPT1wcm9jZXNzLmVudi5OT0RFX0VOViYmKHdpbmRvd1tcIl9fc3R5bGVkLWNvbXBvbmVudHMtaW5pdF9fXCJdPXdpbmRvd1tcIl9fc3R5bGVkLWNvbXBvbmVudHMtaW5pdF9fXCJdfHwwLDE9PT13aW5kb3dbXCJfX3N0eWxlZC1jb21wb25lbnRzLWluaXRfX1wiXSYmY29uc29sZS53YXJuKFwiSXQgbG9va3MgbGlrZSB0aGVyZSBhcmUgc2V2ZXJhbCBpbnN0YW5jZXMgb2YgJ3N0eWxlZC1jb21wb25lbnRzJyBpbml0aWFsaXplZCBpbiB0aGlzIGFwcGxpY2F0aW9uLiBUaGlzIG1heSBjYXVzZSBkeW5hbWljIHN0eWxlcyB0byBub3QgcmVuZGVyIHByb3Blcmx5LCBlcnJvcnMgZHVyaW5nIHRoZSByZWh5ZHJhdGlvbiBwcm9jZXNzLCBhIG1pc3NpbmcgdGhlbWUgcHJvcCwgYW5kIG1ha2VzIHlvdXIgYXBwbGljYXRpb24gYmlnZ2VyIHdpdGhvdXQgZ29vZCByZWFzb24uXFxuXFxuU2VlIGh0dHBzOi8vcy1jLnNoLzJCQVh6ZWQgZm9yIG1vcmUgaW5mby5cIiksd2luZG93W1wiX19zdHlsZWQtY29tcG9uZW50cy1pbml0X19cIl0rPTEpO2V4cG9ydCBkZWZhdWx0IHFlO2V4cG9ydHtVZSBhcyBTZXJ2ZXJTdHlsZVNoZWV0LGxlIGFzIFN0eWxlU2hlZXRDb25zdW1lcix1ZSBhcyBTdHlsZVNoZWV0Q29udGV4dCx5ZSBhcyBTdHlsZVNoZWV0TWFuYWdlcixMZSBhcyBUaGVtZUNvbnN1bWVyLHplIGFzIFRoZW1lQ29udGV4dCxHZSBhcyBUaGVtZVByb3ZpZGVyLFplIGFzIF9fUFJJVkFURV9fLCRlIGFzIGNyZWF0ZUdsb2JhbFN0eWxlLEFlIGFzIGNzcyxOIGFzIGlzU3R5bGVkQ29tcG9uZW50LFdlIGFzIGtleWZyYW1lcyxYZSBhcyB1c2VUaGVtZSxDIGFzIHZlcnNpb24sSmUgYXMgd2l0aFRoZW1lfTtcbi8vIyBzb3VyY2VNYXBwaW5nVVJMPXN0eWxlZC1jb21wb25lbnRzLmJyb3dzZXIuZXNtLmpzLm1hcFxuIiwiaW1wb3J0IENvbG9yU2NoZW1lIGZyb20gXCIuLi9Db2xvclNjaGVtZVwiO1xuXG5leHBvcnQgdHlwZSBQcm9wZXJ0aWVzSlNPTiA9IHtcbiAgaGludGNoYXJzPzogc3RyaW5nO1xuICBzbW9vdGhzY3JvbGw/OiBib29sZWFuO1xuICBjb21wbGV0ZT86IHN0cmluZztcbiAgY29sb3JzY2hlbWU/OiBDb2xvclNjaGVtZTtcbn07XG5cbmV4cG9ydCB0eXBlIFByb3BlcnR5VHlwZXMgPSB7XG4gIGhpbnRjaGFyczogc3RyaW5nO1xuICBzbW9vdGhzY3JvbGw6IHN0cmluZztcbiAgY29tcGxldGU6IHN0cmluZztcbiAgY29sb3JzY2hlbWU6IHN0cmluZztcbn07XG5cbnR5cGUgUHJvcGVydHlOYW1lID0gXCJoaW50Y2hhcnNcIiB8IFwic21vb3Roc2Nyb2xsXCIgfCBcImNvbXBsZXRlXCIgfCBcImNvbG9yc2NoZW1lXCI7XG5cbnR5cGUgUHJvcGVydHlEZWYgPSB7XG4gIG5hbWU6IFByb3BlcnR5TmFtZTtcbiAgZGVmYXVsdFZhbHVlOiBzdHJpbmcgfCBudW1iZXIgfCBib29sZWFuO1xuICB0eXBlOiBcInN0cmluZ1wiIHwgXCJudW1iZXJcIiB8IFwiYm9vbGVhblwiO1xufTtcblxuY29uc3QgZGVmczogUHJvcGVydHlEZWZbXSA9IFtcbiAge1xuICAgIG5hbWU6IFwiaGludGNoYXJzXCIsXG4gICAgZGVmYXVsdFZhbHVlOiBcImFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6XCIsXG4gICAgdHlwZTogXCJzdHJpbmdcIixcbiAgfSxcbiAge1xuICAgIG5hbWU6IFwic21vb3Roc2Nyb2xsXCIsXG4gICAgZGVmYXVsdFZhbHVlOiBmYWxzZSxcbiAgICB0eXBlOiBcImJvb2xlYW5cIixcbiAgfSxcbiAge1xuICAgIG5hbWU6IFwiY29tcGxldGVcIixcbiAgICBkZWZhdWx0VmFsdWU6IFwic2JoXCIsXG4gICAgdHlwZTogXCJzdHJpbmdcIixcbiAgfSxcbiAge1xuICAgIG5hbWU6IFwiY29sb3JzY2hlbWVcIixcbiAgICBkZWZhdWx0VmFsdWU6IENvbG9yU2NoZW1lLlN5c3RlbSxcbiAgICB0eXBlOiBcInN0cmluZ1wiLFxuICB9LFxuXTtcblxuY29uc3QgZGVmYXVsdFZhbHVlcyA9IHtcbiAgaGludGNoYXJzOiBcImFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6XCIsXG4gIHNtb290aHNjcm9sbDogZmFsc2UsXG4gIGNvbXBsZXRlOiBcInNiaFwiLFxuICBjb2xvcnNjaGVtZTogQ29sb3JTY2hlbWUuU3lzdGVtLFxufTtcblxuZXhwb3J0IGRlZmF1bHQgY2xhc3MgUHJvcGVydGllcyB7XG4gIHB1YmxpYyBoaW50Y2hhcnM6IHN0cmluZztcblxuICBwdWJsaWMgc21vb3Roc2Nyb2xsOiBib29sZWFuO1xuXG4gIHB1YmxpYyBjb21wbGV0ZTogc3RyaW5nO1xuXG4gIHB1YmxpYyBjb2xvcnNjaGVtZTogQ29sb3JTY2hlbWU7XG5cbiAgY29uc3RydWN0b3Ioe1xuICAgIGhpbnRjaGFycyxcbiAgICBzbW9vdGhzY3JvbGwsXG4gICAgY29tcGxldGUsXG4gICAgY29sb3JzY2hlbWUsXG4gIH06IHtcbiAgICBoaW50Y2hhcnM/OiBzdHJpbmc7XG4gICAgc21vb3Roc2Nyb2xsPzogYm9vbGVhbjtcbiAgICBjb21wbGV0ZT86IHN0cmluZztcbiAgICBjb2xvcnNjaGVtZT86IENvbG9yU2NoZW1lO1xuICB9ID0ge30pIHtcbiAgICB0aGlzLmhpbnRjaGFycyA9IGhpbnRjaGFycyB8fCBkZWZhdWx0VmFsdWVzLmhpbnRjaGFycztcbiAgICB0aGlzLnNtb290aHNjcm9sbCA9IHNtb290aHNjcm9sbCB8fCBkZWZhdWx0VmFsdWVzLnNtb290aHNjcm9sbDtcbiAgICB0aGlzLmNvbXBsZXRlID0gY29tcGxldGUgfHwgZGVmYXVsdFZhbHVlcy5jb21wbGV0ZTtcbiAgICB0aGlzLmNvbG9yc2NoZW1lID0gY29sb3JzY2hlbWUgfHwgZGVmYXVsdFZhbHVlcy5jb2xvcnNjaGVtZTtcbiAgfVxuXG4gIHN0YXRpYyBmcm9tSlNPTihqc29uOiBQcm9wZXJ0aWVzSlNPTik6IFByb3BlcnRpZXMge1xuICAgIHJldHVybiBuZXcgUHJvcGVydGllcyhqc29uKTtcbiAgfVxuXG4gIHN0YXRpYyB0eXBlcygpOiBQcm9wZXJ0eVR5cGVzIHtcbiAgICByZXR1cm4ge1xuICAgICAgaGludGNoYXJzOiBcInN0cmluZ1wiLFxuICAgICAgc21vb3Roc2Nyb2xsOiBcImJvb2xlYW5cIixcbiAgICAgIGNvbXBsZXRlOiBcInN0cmluZ1wiLFxuICAgICAgY29sb3JzY2hlbWU6IFwic3RyaW5nXCIsXG4gICAgfTtcbiAgfVxuXG4gIHN0YXRpYyBkZWYobmFtZTogc3RyaW5nKTogUHJvcGVydHlEZWYgfCB1bmRlZmluZWQge1xuICAgIHJldHVybiBkZWZzLmZpbmQoKHApID0+IHAubmFtZSA9PT0gbmFtZSk7XG4gIH1cblxuICBzdGF0aWMgZGVmcygpOiBQcm9wZXJ0eURlZltdIHtcbiAgICByZXR1cm4gZGVmcztcbiAgfVxuXG4gIHRvSlNPTigpOiBQcm9wZXJ0aWVzSlNPTiB7XG4gICAgcmV0dXJuIHtcbiAgICAgIGhpbnRjaGFyczogdGhpcy5oaW50Y2hhcnMsXG4gICAgICBzbW9vdGhzY3JvbGw6IHRoaXMuc21vb3Roc2Nyb2xsLFxuICAgICAgY29tcGxldGU6IHRoaXMuY29tcGxldGUsXG4gICAgICBjb2xvcnNjaGVtZTogdGhpcy5jb2xvcnNjaGVtZSxcbiAgICB9O1xuICB9XG59XG4iLCJpbXBvcnQgS2V5IGZyb20gXCIuL0tleVwiO1xuXG5leHBvcnQgdHlwZSBCbGFja2xpc3RJdGVtSlNPTiA9XG4gIHwgc3RyaW5nXG4gIHwge1xuICAgICAgdXJsOiBzdHJpbmc7XG4gICAgICBrZXlzOiBzdHJpbmdbXTtcbiAgICB9O1xuXG5leHBvcnQgdHlwZSBCbGFja2xpc3RKU09OID0gQmxhY2tsaXN0SXRlbUpTT05bXTtcblxuY29uc3QgcmVnZXhGcm9tV2lsZGNhcmQgPSAocGF0dGVybjogc3RyaW5nKTogUmVnRXhwID0+IHtcbiAgY29uc3QgcmVnZXhTdHIgPSBcIl5cIiArIHBhdHRlcm4ucmVwbGFjZSgvXFwqL2csIFwiLipcIikgKyBcIiRcIjtcbiAgcmV0dXJuIG5ldyBSZWdFeHAocmVnZXhTdHIpO1xufTtcblxuZXhwb3J0IGNsYXNzIEJsYWNrbGlzdEl0ZW0ge1xuICBwdWJsaWMgcmVhZG9ubHkgcGF0dGVybjogc3RyaW5nO1xuXG4gIHByaXZhdGUgcmVnZXg6IFJlZ0V4cDtcblxuICBwdWJsaWMgcmVhZG9ubHkgcGFydGlhbDogYm9vbGVhbjtcblxuICBwdWJsaWMgcmVhZG9ubHkga2V5czogc3RyaW5nW107XG5cbiAgcHJpdmF0ZSByZWFkb25seSBrZXlFbnRpdGllczogS2V5W107XG5cbiAgY29uc3RydWN0b3IocGF0dGVybjogc3RyaW5nLCBwYXJ0aWFsOiBib29sZWFuLCBrZXlzOiBzdHJpbmdbXSkge1xuICAgIHRoaXMucGF0dGVybiA9IHBhdHRlcm47XG4gICAgdGhpcy5yZWdleCA9IHJlZ2V4RnJvbVdpbGRjYXJkKHBhdHRlcm4pO1xuICAgIHRoaXMucGFydGlhbCA9IHBhcnRpYWw7XG4gICAgdGhpcy5rZXlzID0ga2V5cztcbiAgICB0aGlzLmtleUVudGl0aWVzID0gdGhpcy5rZXlzLm1hcChLZXkuZnJvbU1hcEtleSk7XG4gIH1cblxuICBzdGF0aWMgZnJvbUpTT04oanNvbjogQmxhY2tsaXN0SXRlbUpTT04pOiBCbGFja2xpc3RJdGVtIHtcbiAgICByZXR1cm4gdHlwZW9mIGpzb24gPT09IFwic3RyaW5nXCJcbiAgICAgID8gbmV3IEJsYWNrbGlzdEl0ZW0oanNvbiwgZmFsc2UsIFtdKVxuICAgICAgOiBuZXcgQmxhY2tsaXN0SXRlbShqc29uLnVybCwgdHJ1ZSwganNvbi5rZXlzKTtcbiAgfVxuXG4gIHRvSlNPTigpOiBCbGFja2xpc3RJdGVtSlNPTiB7XG4gICAgaWYgKCF0aGlzLnBhcnRpYWwpIHtcbiAgICAgIHJldHVybiB0aGlzLnBhdHRlcm47XG4gICAgfVxuICAgIHJldHVybiB7IHVybDogdGhpcy5wYXR0ZXJuLCBrZXlzOiB0aGlzLmtleXMgfTtcbiAgfVxuXG4gIG1hdGNoZXModXJsOiBVUkwpOiBib29sZWFuIHtcbiAgICByZXR1cm4gdGhpcy5wYXR0ZXJuLmluY2x1ZGVzKFwiL1wiKVxuICAgICAgPyB0aGlzLnJlZ2V4LnRlc3QodXJsLmhvc3QgKyB1cmwucGF0aG5hbWUpXG4gICAgICA6IHRoaXMucmVnZXgudGVzdCh1cmwuaG9zdCk7XG4gIH1cblxuICBpbmNsdWRlS2V5KHVybDogVVJMLCBrZXk6IEtleSk6IGJvb2xlYW4ge1xuICAgIGlmICghdGhpcy5tYXRjaGVzKHVybCkgfHwgIXRoaXMucGFydGlhbCkge1xuICAgICAgcmV0dXJuIGZhbHNlO1xuICAgIH1cbiAgICByZXR1cm4gdGhpcy5rZXlFbnRpdGllcy5zb21lKChrKSA9PiBrLmVxdWFscyhrZXkpKTtcbiAgfVxufVxuXG5leHBvcnQgZGVmYXVsdCBjbGFzcyBCbGFja2xpc3Qge1xuICBjb25zdHJ1Y3RvcihwdWJsaWMgcmVhZG9ubHkgaXRlbXM6IEJsYWNrbGlzdEl0ZW1bXSkge31cblxuICBzdGF0aWMgZnJvbUpTT04oanNvbjogQmxhY2tsaXN0SlNPTik6IEJsYWNrbGlzdCB7XG4gICAgY29uc3QgaXRlbXMgPSBqc29uLm1hcCgobykgPT4gQmxhY2tsaXN0SXRlbS5mcm9tSlNPTihvKSk7XG4gICAgcmV0dXJuIG5ldyBCbGFja2xpc3QoaXRlbXMpO1xuICB9XG5cbiAgdG9KU09OKCk6IEJsYWNrbGlzdEpTT04ge1xuICAgIHJldHVybiB0aGlzLml0ZW1zLm1hcCgoaXRlbSkgPT4gaXRlbS50b0pTT04oKSk7XG4gIH1cblxuICBpbmNsdWRlc0VudGlyZUJsYWNrbGlzdCh1cmw6IFVSTCk6IGJvb2xlYW4ge1xuICAgIHJldHVybiB0aGlzLml0ZW1zLnNvbWUoKGl0ZW0pID0+ICFpdGVtLnBhcnRpYWwgJiYgaXRlbS5tYXRjaGVzKHVybCkpO1xuICB9XG5cbiAgaW5jbHVkZUtleSh1cmw6IFVSTCwga2V5OiBLZXkpIHtcbiAgICByZXR1cm4gdGhpcy5pdGVtcy5zb21lKChpdGVtKSA9PiBpdGVtLmluY2x1ZGVLZXkodXJsLCBrZXkpKTtcbiAgfVxufVxuIiwiJ3VzZSBzdHJpY3QnO1xuXG5pZiAocHJvY2Vzcy5lbnYuTk9ERV9FTlYgPT09ICdwcm9kdWN0aW9uJykge1xuICBtb2R1bGUuZXhwb3J0cyA9IHJlcXVpcmUoJy4vY2pzL3JlYWN0LWlzLnByb2R1Y3Rpb24ubWluLmpzJyk7XG59IGVsc2Uge1xuICBtb2R1bGUuZXhwb3J0cyA9IHJlcXVpcmUoJy4vY2pzL3JlYWN0LWlzLmRldmVsb3BtZW50LmpzJyk7XG59XG4iLCJpbXBvcnQgKiBhcyBvcGVyYXRpb25zIGZyb20gXCIuLi9vcGVyYXRpb25zXCI7XG5cbnR5cGUgT3BlcmF0aW9uSnNvbiA9XG4gIHwge1xuICAgICAgdHlwZTogc3RyaW5nO1xuICAgIH1cbiAgfCB7XG4gICAgICB0eXBlOiBzdHJpbmc7XG4gICAgICBbcHJvcDogc3RyaW5nXTogc3RyaW5nIHwgbnVtYmVyIHwgYm9vbGVhbjtcbiAgICB9O1xuZXhwb3J0IHR5cGUgS2V5bWFwc0pTT04gPSB7IFtrZXk6IHN0cmluZ106IE9wZXJhdGlvbkpzb24gfTtcblxuZXhwb3J0IGRlZmF1bHQgY2xhc3MgS2V5bWFwcyB7XG4gIGNvbnN0cnVjdG9yKHByaXZhdGUgcmVhZG9ubHkgZGF0YTogeyBba2V5OiBzdHJpbmddOiBvcGVyYXRpb25zLk9wZXJhdGlvbiB9KSB7fVxuXG4gIHN0YXRpYyBmcm9tSlNPTihqc29uOiBLZXltYXBzSlNPTik6IEtleW1hcHMge1xuICAgIGNvbnN0IGVudHJpZXM6IHsgW2tleTogc3RyaW5nXTogb3BlcmF0aW9ucy5PcGVyYXRpb24gfSA9IHt9O1xuICAgIGZvciAoY29uc3Qga2V5IG9mIE9iamVjdC5rZXlzKGpzb24pKSB7XG4gICAgICBlbnRyaWVzW2tleV0gPSBvcGVyYXRpb25zLnZhbHVlT2YoanNvbltrZXldKTtcbiAgICB9XG4gICAgcmV0dXJuIG5ldyBLZXltYXBzKGVudHJpZXMpO1xuICB9XG5cbiAgY29tYmluZShvdGhlcjogS2V5bWFwcyk6IEtleW1hcHMge1xuICAgIHJldHVybiBuZXcgS2V5bWFwcyh7XG4gICAgICAuLi50aGlzLmRhdGEsXG4gICAgICAuLi5vdGhlci5kYXRhLFxuICAgIH0pO1xuICB9XG5cbiAgdG9KU09OKCk6IEtleW1hcHNKU09OIHtcbiAgICByZXR1cm4gdGhpcy5kYXRhO1xuICB9XG5cbiAgZW50cmllcygpOiBbc3RyaW5nLCBvcGVyYXRpb25zLk9wZXJhdGlvbl1bXSB7XG4gICAgcmV0dXJuIE9iamVjdC5lbnRyaWVzKHRoaXMuZGF0YSk7XG4gIH1cbn1cbiIsImltcG9ydCAqIGFzIEFqdiBmcm9tIFwiYWp2XCI7XG5cbmltcG9ydCBLZXltYXBzLCB7IEtleW1hcHNKU09OIH0gZnJvbSBcIi4vS2V5bWFwc1wiO1xuaW1wb3J0IFNlYXJjaCwgeyBTZWFyY2hKU09OIH0gZnJvbSBcIi4vU2VhcmNoXCI7XG5pbXBvcnQgUHJvcGVydGllcywgeyBQcm9wZXJ0aWVzSlNPTiB9IGZyb20gXCIuL1Byb3BlcnRpZXNcIjtcbmltcG9ydCBCbGFja2xpc3QsIHsgQmxhY2tsaXN0SlNPTiB9IGZyb20gXCIuL0JsYWNrbGlzdFwiO1xuaW1wb3J0IHZhbGlkYXRlIGZyb20gXCIuL3ZhbGlkYXRlXCI7XG5cbmV4cG9ydCB0eXBlIFNldHRpbmdzSlNPTiA9IHtcbiAga2V5bWFwcz86IEtleW1hcHNKU09OO1xuICBzZWFyY2g/OiBTZWFyY2hKU09OO1xuICBwcm9wZXJ0aWVzPzogUHJvcGVydGllc0pTT047XG4gIGJsYWNrbGlzdD86IEJsYWNrbGlzdEpTT047XG59O1xuXG5leHBvcnQgZGVmYXVsdCBjbGFzcyBTZXR0aW5ncyB7XG4gIHB1YmxpYyBrZXltYXBzOiBLZXltYXBzO1xuXG4gIHB1YmxpYyBzZWFyY2g6IFNlYXJjaDtcblxuICBwdWJsaWMgcHJvcGVydGllczogUHJvcGVydGllcztcblxuICBwdWJsaWMgYmxhY2tsaXN0OiBCbGFja2xpc3Q7XG5cbiAgY29uc3RydWN0b3Ioe1xuICAgIGtleW1hcHMsXG4gICAgc2VhcmNoLFxuICAgIHByb3BlcnRpZXMsXG4gICAgYmxhY2tsaXN0LFxuICB9OiB7XG4gICAga2V5bWFwczogS2V5bWFwcztcbiAgICBzZWFyY2g6IFNlYXJjaDtcbiAgICBwcm9wZXJ0aWVzOiBQcm9wZXJ0aWVzO1xuICAgIGJsYWNrbGlzdDogQmxhY2tsaXN0O1xuICB9KSB7XG4gICAgdGhpcy5rZXltYXBzID0ga2V5bWFwcztcbiAgICB0aGlzLnNlYXJjaCA9IHNlYXJjaDtcbiAgICB0aGlzLnByb3BlcnRpZXMgPSBwcm9wZXJ0aWVzO1xuICAgIHRoaXMuYmxhY2tsaXN0ID0gYmxhY2tsaXN0O1xuICB9XG5cbiAgc3RhdGljIGZyb21KU09OKGpzb246IHVua25vd24pOiBTZXR0aW5ncyB7XG4gICAgY29uc3QgdmFsaWQgPSB2YWxpZGF0ZShqc29uKTtcbiAgICBpZiAoIXZhbGlkKSB7XG4gICAgICBjb25zdCBtZXNzYWdlID0gKHZhbGlkYXRlIGFzIGFueSlcbiAgICAgICAgLmVycm9ycyEubWFwKChlcnI6IEFqdi5FcnJvck9iamVjdCkgPT4ge1xuICAgICAgICAgIHJldHVybiBgJyR7ZXJyLmRhdGFQYXRofScgJHtlcnIubWVzc2FnZX1gO1xuICAgICAgICB9KVxuICAgICAgICAuam9pbihcIjsgXCIpO1xuICAgICAgdGhyb3cgbmV3IFR5cGVFcnJvcihtZXNzYWdlKTtcbiAgICB9XG5cbiAgICBjb25zdCBvYmogPSBqc29uIGFzIFNldHRpbmdzSlNPTjtcbiAgICBjb25zdCBzZXR0aW5ncyA9IHsgLi4uRGVmYXVsdFNldHRpbmcgfTtcbiAgICBpZiAob2JqLmtleW1hcHMpIHtcbiAgICAgIHNldHRpbmdzLmtleW1hcHMgPSBLZXltYXBzLmZyb21KU09OKG9iai5rZXltYXBzKTtcbiAgICB9XG4gICAgaWYgKG9iai5zZWFyY2gpIHtcbiAgICAgIHNldHRpbmdzLnNlYXJjaCA9IFNlYXJjaC5mcm9tSlNPTihvYmouc2VhcmNoKTtcbiAgICB9XG4gICAgaWYgKG9iai5wcm9wZXJ0aWVzKSB7XG4gICAgICBzZXR0aW5ncy5wcm9wZXJ0aWVzID0gUHJvcGVydGllcy5mcm9tSlNPTihvYmoucHJvcGVydGllcyk7XG4gICAgfVxuICAgIGlmIChvYmouYmxhY2tsaXN0KSB7XG4gICAgICBzZXR0aW5ncy5ibGFja2xpc3QgPSBCbGFja2xpc3QuZnJvbUpTT04ob2JqLmJsYWNrbGlzdCk7XG4gICAgfVxuICAgIHJldHVybiBuZXcgU2V0dGluZ3Moc2V0dGluZ3MpO1xuICB9XG5cbiAgdG9KU09OKCk6IFNldHRpbmdzSlNPTiB7XG4gICAgcmV0dXJuIHtcbiAgICAgIGtleW1hcHM6IHRoaXMua2V5bWFwcy50b0pTT04oKSxcbiAgICAgIHNlYXJjaDogdGhpcy5zZWFyY2gudG9KU09OKCksXG4gICAgICBwcm9wZXJ0aWVzOiB0aGlzLnByb3BlcnRpZXMudG9KU09OKCksXG4gICAgICBibGFja2xpc3Q6IHRoaXMuYmxhY2tsaXN0LnRvSlNPTigpLFxuICAgIH07XG4gIH1cbn1cblxuZXhwb3J0IGNvbnN0IERlZmF1bHRTZXR0aW5nSlNPTlRleHQgPSBge1xuICBcImtleW1hcHNcIjoge1xuICAgIFwiMFwiOiB7IFwidHlwZVwiOiBcInNjcm9sbC5ob21lXCIgfSxcbiAgICBcIjpcIjogeyBcInR5cGVcIjogXCJjb21tYW5kLnNob3dcIiB9LFxuICAgIFwib1wiOiB7IFwidHlwZVwiOiBcImNvbW1hbmQuc2hvdy5vcGVuXCIsIFwiYWx0ZXJcIjogZmFsc2UgfSxcbiAgICBcIk9cIjogeyBcInR5cGVcIjogXCJjb21tYW5kLnNob3cub3BlblwiLCBcImFsdGVyXCI6IHRydWUgfSxcbiAgICBcInRcIjogeyBcInR5cGVcIjogXCJjb21tYW5kLnNob3cudGFib3BlblwiLCBcImFsdGVyXCI6IGZhbHNlIH0sXG4gICAgXCJUXCI6IHsgXCJ0eXBlXCI6IFwiY29tbWFuZC5zaG93LnRhYm9wZW5cIiwgXCJhbHRlclwiOiB0cnVlIH0sXG4gICAgXCJ3XCI6IHsgXCJ0eXBlXCI6IFwiY29tbWFuZC5zaG93Lndpbm9wZW5cIiwgXCJhbHRlclwiOiBmYWxzZSB9LFxuICAgIFwiV1wiOiB7IFwidHlwZVwiOiBcImNvbW1hbmQuc2hvdy53aW5vcGVuXCIsIFwiYWx0ZXJcIjogdHJ1ZSB9LFxuICAgIFwiYlwiOiB7IFwidHlwZVwiOiBcImNvbW1hbmQuc2hvdy5idWZmZXJcIiB9LFxuICAgIFwiYVwiOiB7IFwidHlwZVwiOiBcImNvbW1hbmQuc2hvdy5hZGRib29rbWFya1wiLCBcImFsdGVyXCI6IHRydWUgfSxcbiAgICBcImtcIjogeyBcInR5cGVcIjogXCJzY3JvbGwudmVydGljYWxseVwiLCBcImNvdW50XCI6IC0xIH0sXG4gICAgXCJqXCI6IHsgXCJ0eXBlXCI6IFwic2Nyb2xsLnZlcnRpY2FsbHlcIiwgXCJjb3VudFwiOiAxIH0sXG4gICAgXCJoXCI6IHsgXCJ0eXBlXCI6IFwic2Nyb2xsLmhvcml6b25hbGx5XCIsIFwiY291bnRcIjogLTEgfSxcbiAgICBcImxcIjogeyBcInR5cGVcIjogXCJzY3JvbGwuaG9yaXpvbmFsbHlcIiwgXCJjb3VudFwiOiAxIH0sXG4gICAgXCI8Qy1VPlwiOiB7IFwidHlwZVwiOiBcInNjcm9sbC5wYWdlc1wiLCBcImNvdW50XCI6IC0wLjUgfSxcbiAgICBcIjxDLUQ+XCI6IHsgXCJ0eXBlXCI6IFwic2Nyb2xsLnBhZ2VzXCIsIFwiY291bnRcIjogMC41IH0sXG4gICAgXCI8Qy1CPlwiOiB7IFwidHlwZVwiOiBcInNjcm9sbC5wYWdlc1wiLCBcImNvdW50XCI6IC0xIH0sXG4gICAgXCI8Qy1GPlwiOiB7IFwidHlwZVwiOiBcInNjcm9sbC5wYWdlc1wiLCBcImNvdW50XCI6IDEgfSxcbiAgICBcImdnXCI6IHsgXCJ0eXBlXCI6IFwic2Nyb2xsLnRvcFwiIH0sXG4gICAgXCJHXCI6IHsgXCJ0eXBlXCI6IFwic2Nyb2xsLmJvdHRvbVwiIH0sXG4gICAgXCIkXCI6IHsgXCJ0eXBlXCI6IFwic2Nyb2xsLmVuZFwiIH0sXG4gICAgXCJkXCI6IHsgXCJ0eXBlXCI6IFwidGFicy5jbG9zZVwiIH0sXG4gICAgXCJEXCI6IHsgXCJ0eXBlXCI6IFwidGFicy5jbG9zZVwiLCBcInNlbGVjdFwiOiBcImxlZnRcIiB9LFxuICAgIFwieCRcIjogeyBcInR5cGVcIjogXCJ0YWJzLmNsb3NlLnJpZ2h0XCIgfSxcbiAgICBcIiFkXCI6IHsgXCJ0eXBlXCI6IFwidGFicy5jbG9zZS5mb3JjZVwiIH0sXG4gICAgXCJ1XCI6IHsgXCJ0eXBlXCI6IFwidGFicy5yZW9wZW5cIiB9LFxuICAgIFwiS1wiOiB7IFwidHlwZVwiOiBcInRhYnMucHJldlwiIH0sXG4gICAgXCJKXCI6IHsgXCJ0eXBlXCI6IFwidGFicy5uZXh0XCIgfSxcbiAgICBcImdUXCI6IHsgXCJ0eXBlXCI6IFwidGFicy5wcmV2XCIgfSxcbiAgICBcImd0XCI6IHsgXCJ0eXBlXCI6IFwidGFicy5uZXh0XCIgfSxcbiAgICBcImcwXCI6IHsgXCJ0eXBlXCI6IFwidGFicy5maXJzdFwiIH0sXG4gICAgXCJnJFwiOiB7IFwidHlwZVwiOiBcInRhYnMubGFzdFwiIH0sXG4gICAgXCI8Qy02PlwiOiB7IFwidHlwZVwiOiBcInRhYnMucHJldnNlbFwiIH0sXG4gICAgXCJyXCI6IHsgXCJ0eXBlXCI6IFwidGFicy5yZWxvYWRcIiwgXCJjYWNoZVwiOiBmYWxzZSB9LFxuICAgIFwiUlwiOiB7IFwidHlwZVwiOiBcInRhYnMucmVsb2FkXCIsIFwiY2FjaGVcIjogdHJ1ZSB9LFxuICAgIFwienBcIjogeyBcInR5cGVcIjogXCJ0YWJzLnBpbi50b2dnbGVcIiB9LFxuICAgIFwiemRcIjogeyBcInR5cGVcIjogXCJ0YWJzLmR1cGxpY2F0ZVwiIH0sXG4gICAgXCJ6aVwiOiB7IFwidHlwZVwiOiBcInpvb20uaW5cIiB9LFxuICAgIFwiem9cIjogeyBcInR5cGVcIjogXCJ6b29tLm91dFwiIH0sXG4gICAgXCJ6elwiOiB7IFwidHlwZVwiOiBcInpvb20ubmV1dHJhbFwiIH0sXG4gICAgXCJmXCI6IHsgXCJ0eXBlXCI6IFwiZm9sbG93LnN0YXJ0XCIsIFwibmV3VGFiXCI6IGZhbHNlIH0sXG4gICAgXCJGXCI6IHsgXCJ0eXBlXCI6IFwiZm9sbG93LnN0YXJ0XCIsIFwibmV3VGFiXCI6IHRydWUsIFwiYmFja2dyb3VuZFwiOiBmYWxzZSB9LFxuICAgIFwibVwiOiB7IFwidHlwZVwiOiBcIm1hcmsuc2V0LnByZWZpeFwiIH0sXG4gICAgXCInXCI6IHsgXCJ0eXBlXCI6IFwibWFyay5qdW1wLnByZWZpeFwiIH0sXG4gICAgXCJIXCI6IHsgXCJ0eXBlXCI6IFwibmF2aWdhdGUuaGlzdG9yeS5wcmV2XCIgfSxcbiAgICBcIkxcIjogeyBcInR5cGVcIjogXCJuYXZpZ2F0ZS5oaXN0b3J5Lm5leHRcIiB9LFxuICAgIFwiW1tcIjogeyBcInR5cGVcIjogXCJuYXZpZ2F0ZS5saW5rLnByZXZcIiB9LFxuICAgIFwiXV1cIjogeyBcInR5cGVcIjogXCJuYXZpZ2F0ZS5saW5rLm5leHRcIiB9LFxuICAgIFwiZ3VcIjogeyBcInR5cGVcIjogXCJuYXZpZ2F0ZS5wYXJlbnRcIiB9LFxuICAgIFwiZ1VcIjogeyBcInR5cGVcIjogXCJuYXZpZ2F0ZS5yb290XCIgfSxcbiAgICBcImdpXCI6IHsgXCJ0eXBlXCI6IFwiZm9jdXMuaW5wdXRcIiB9LFxuICAgIFwiZ2ZcIjogeyBcInR5cGVcIjogXCJwYWdlLnNvdXJjZVwiIH0sXG4gICAgXCJnaFwiOiB7IFwidHlwZVwiOiBcInBhZ2UuaG9tZVwiIH0sXG4gICAgXCJnSFwiOiB7IFwidHlwZVwiOiBcInBhZ2UuaG9tZVwiLCBcIm5ld1RhYlwiOiB0cnVlIH0sXG4gICAgXCJnclwiOiB7IFwidHlwZVwiOiBcInRhYnMucmVhZGVyLnRvZ2dsZVwiIH0sXG4gICAgXCJ5XCI6IHsgXCJ0eXBlXCI6IFwidXJscy55YW5rXCIgfSxcbiAgICBcInBcIjogeyBcInR5cGVcIjogXCJ1cmxzLnBhc3RlXCIsIFwibmV3VGFiXCI6IGZhbHNlIH0sXG4gICAgXCJQXCI6IHsgXCJ0eXBlXCI6IFwidXJscy5wYXN0ZVwiLCBcIm5ld1RhYlwiOiB0cnVlIH0sXG4gICAgXCIvXCI6IHsgXCJ0eXBlXCI6IFwiZmluZC5zdGFydFwiIH0sXG4gICAgXCJuXCI6IHsgXCJ0eXBlXCI6IFwiZmluZC5uZXh0XCIgfSxcbiAgICBcIk5cIjogeyBcInR5cGVcIjogXCJmaW5kLnByZXZcIiB9LFxuICAgIFwiLlwiOiB7IFwidHlwZVwiOiBcInJlcGVhdC5sYXN0XCIgfSxcbiAgICBcIjxTLUVzYz5cIjogeyBcInR5cGVcIjogXCJhZGRvbi50b2dnbGUuZW5hYmxlZFwiIH1cbiAgfSxcbiAgXCJzZWFyY2hcIjoge1xuICAgIFwiZGVmYXVsdFwiOiBcImdvb2dsZVwiLFxuICAgIFwiZW5naW5lc1wiOiB7XG4gICAgICBcImdvb2dsZVwiOiBcImh0dHBzOi8vZ29vZ2xlLmNvbS9zZWFyY2g/cT17fVwiLFxuICAgICAgXCJ5YWhvb1wiOiBcImh0dHBzOi8vc2VhcmNoLnlhaG9vLmNvbS9zZWFyY2g/cD17fVwiLFxuICAgICAgXCJiaW5nXCI6IFwiaHR0cHM6Ly93d3cuYmluZy5jb20vc2VhcmNoP3E9e31cIixcbiAgICAgIFwiZHVja2R1Y2tnb1wiOiBcImh0dHBzOi8vZHVja2R1Y2tnby5jb20vP3E9e31cIixcbiAgICAgIFwidHdpdHRlclwiOiBcImh0dHBzOi8vdHdpdHRlci5jb20vc2VhcmNoP3E9e31cIixcbiAgICAgIFwid2lraXBlZGlhXCI6IFwiaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3cvaW5kZXgucGhwP3NlYXJjaD17fVwiXG4gICAgfVxuICB9LFxuICBcInByb3BlcnRpZXNcIjoge1xuICAgIFwiaGludGNoYXJzXCI6IFwiYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXpcIixcbiAgICBcInNtb290aHNjcm9sbFwiOiBmYWxzZSxcbiAgICBcImNvbXBsZXRlXCI6IFwic2JoXCIsXG4gICAgXCJjb2xvcnNjaGVtZVwiOiBcInN5c3RlbVwiXG4gIH0sXG4gIFwiYmxhY2tsaXN0XCI6IFtcbiAgXVxufWA7XG5cbmV4cG9ydCBjb25zdCBEZWZhdWx0U2V0dGluZzogU2V0dGluZ3MgPSBTZXR0aW5ncy5mcm9tSlNPTihcbiAgSlNPTi5wYXJzZShEZWZhdWx0U2V0dGluZ0pTT05UZXh0KVxuKTtcbiIsImVudW0gQ29sb3JTY2hlbWUge1xuICBTeXN0ZW0gPSBcInN5c3RlbVwiLFxuICBMaWdodCA9IFwibGlnaHRcIixcbiAgRGFyayA9IFwiZGFya1wiLFxufVxuXG5leHBvcnQgZGVmYXVsdCBDb2xvclNjaGVtZTtcbiIsIid1c2Ugc3RyaWN0JztcblxudmFyIHJlYWN0SXMgPSByZXF1aXJlKCdyZWFjdC1pcycpO1xuXG4vKipcbiAqIENvcHlyaWdodCAyMDE1LCBZYWhvbyEgSW5jLlxuICogQ29weXJpZ2h0cyBsaWNlbnNlZCB1bmRlciB0aGUgTmV3IEJTRCBMaWNlbnNlLiBTZWUgdGhlIGFjY29tcGFueWluZyBMSUNFTlNFIGZpbGUgZm9yIHRlcm1zLlxuICovXG52YXIgUkVBQ1RfU1RBVElDUyA9IHtcbiAgY2hpbGRDb250ZXh0VHlwZXM6IHRydWUsXG4gIGNvbnRleHRUeXBlOiB0cnVlLFxuICBjb250ZXh0VHlwZXM6IHRydWUsXG4gIGRlZmF1bHRQcm9wczogdHJ1ZSxcbiAgZGlzcGxheU5hbWU6IHRydWUsXG4gIGdldERlZmF1bHRQcm9wczogdHJ1ZSxcbiAgZ2V0RGVyaXZlZFN0YXRlRnJvbUVycm9yOiB0cnVlLFxuICBnZXREZXJpdmVkU3RhdGVGcm9tUHJvcHM6IHRydWUsXG4gIG1peGluczogdHJ1ZSxcbiAgcHJvcFR5cGVzOiB0cnVlLFxuICB0eXBlOiB0cnVlXG59O1xudmFyIEtOT1dOX1NUQVRJQ1MgPSB7XG4gIG5hbWU6IHRydWUsXG4gIGxlbmd0aDogdHJ1ZSxcbiAgcHJvdG90eXBlOiB0cnVlLFxuICBjYWxsZXI6IHRydWUsXG4gIGNhbGxlZTogdHJ1ZSxcbiAgYXJndW1lbnRzOiB0cnVlLFxuICBhcml0eTogdHJ1ZVxufTtcbnZhciBGT1JXQVJEX1JFRl9TVEFUSUNTID0ge1xuICAnJCR0eXBlb2YnOiB0cnVlLFxuICByZW5kZXI6IHRydWUsXG4gIGRlZmF1bHRQcm9wczogdHJ1ZSxcbiAgZGlzcGxheU5hbWU6IHRydWUsXG4gIHByb3BUeXBlczogdHJ1ZVxufTtcbnZhciBNRU1PX1NUQVRJQ1MgPSB7XG4gICckJHR5cGVvZic6IHRydWUsXG4gIGNvbXBhcmU6IHRydWUsXG4gIGRlZmF1bHRQcm9wczogdHJ1ZSxcbiAgZGlzcGxheU5hbWU6IHRydWUsXG4gIHByb3BUeXBlczogdHJ1ZSxcbiAgdHlwZTogdHJ1ZVxufTtcbnZhciBUWVBFX1NUQVRJQ1MgPSB7fTtcblRZUEVfU1RBVElDU1tyZWFjdElzLkZvcndhcmRSZWZdID0gRk9SV0FSRF9SRUZfU1RBVElDUztcblRZUEVfU1RBVElDU1tyZWFjdElzLk1lbW9dID0gTUVNT19TVEFUSUNTO1xuXG5mdW5jdGlvbiBnZXRTdGF0aWNzKGNvbXBvbmVudCkge1xuICAvLyBSZWFjdCB2MTYuMTEgYW5kIGJlbG93XG4gIGlmIChyZWFjdElzLmlzTWVtbyhjb21wb25lbnQpKSB7XG4gICAgcmV0dXJuIE1FTU9fU1RBVElDUztcbiAgfSAvLyBSZWFjdCB2MTYuMTIgYW5kIGFib3ZlXG5cblxuICByZXR1cm4gVFlQRV9TVEFUSUNTW2NvbXBvbmVudFsnJCR0eXBlb2YnXV0gfHwgUkVBQ1RfU1RBVElDUztcbn1cblxudmFyIGRlZmluZVByb3BlcnR5ID0gT2JqZWN0LmRlZmluZVByb3BlcnR5O1xudmFyIGdldE93blByb3BlcnR5TmFtZXMgPSBPYmplY3QuZ2V0T3duUHJvcGVydHlOYW1lcztcbnZhciBnZXRPd25Qcm9wZXJ0eVN5bWJvbHMgPSBPYmplY3QuZ2V0T3duUHJvcGVydHlTeW1ib2xzO1xudmFyIGdldE93blByb3BlcnR5RGVzY3JpcHRvciA9IE9iamVjdC5nZXRPd25Qcm9wZXJ0eURlc2NyaXB0b3I7XG52YXIgZ2V0UHJvdG90eXBlT2YgPSBPYmplY3QuZ2V0UHJvdG90eXBlT2Y7XG52YXIgb2JqZWN0UHJvdG90eXBlID0gT2JqZWN0LnByb3RvdHlwZTtcbmZ1bmN0aW9uIGhvaXN0Tm9uUmVhY3RTdGF0aWNzKHRhcmdldENvbXBvbmVudCwgc291cmNlQ29tcG9uZW50LCBibGFja2xpc3QpIHtcbiAgaWYgKHR5cGVvZiBzb3VyY2VDb21wb25lbnQgIT09ICdzdHJpbmcnKSB7XG4gICAgLy8gZG9uJ3QgaG9pc3Qgb3ZlciBzdHJpbmcgKGh0bWwpIGNvbXBvbmVudHNcbiAgICBpZiAob2JqZWN0UHJvdG90eXBlKSB7XG4gICAgICB2YXIgaW5oZXJpdGVkQ29tcG9uZW50ID0gZ2V0UHJvdG90eXBlT2Yoc291cmNlQ29tcG9uZW50KTtcblxuICAgICAgaWYgKGluaGVyaXRlZENvbXBvbmVudCAmJiBpbmhlcml0ZWRDb21wb25lbnQgIT09IG9iamVjdFByb3RvdHlwZSkge1xuICAgICAgICBob2lzdE5vblJlYWN0U3RhdGljcyh0YXJnZXRDb21wb25lbnQsIGluaGVyaXRlZENvbXBvbmVudCwgYmxhY2tsaXN0KTtcbiAgICAgIH1cbiAgICB9XG5cbiAgICB2YXIga2V5cyA9IGdldE93blByb3BlcnR5TmFtZXMoc291cmNlQ29tcG9uZW50KTtcblxuICAgIGlmIChnZXRPd25Qcm9wZXJ0eVN5bWJvbHMpIHtcbiAgICAgIGtleXMgPSBrZXlzLmNvbmNhdChnZXRPd25Qcm9wZXJ0eVN5bWJvbHMoc291cmNlQ29tcG9uZW50KSk7XG4gICAgfVxuXG4gICAgdmFyIHRhcmdldFN0YXRpY3MgPSBnZXRTdGF0aWNzKHRhcmdldENvbXBvbmVudCk7XG4gICAgdmFyIHNvdXJjZVN0YXRpY3MgPSBnZXRTdGF0aWNzKHNvdXJjZUNvbXBvbmVudCk7XG5cbiAgICBmb3IgKHZhciBpID0gMDsgaSA8IGtleXMubGVuZ3RoOyArK2kpIHtcbiAgICAgIHZhciBrZXkgPSBrZXlzW2ldO1xuXG4gICAgICBpZiAoIUtOT1dOX1NUQVRJQ1Nba2V5XSAmJiAhKGJsYWNrbGlzdCAmJiBibGFja2xpc3Rba2V5XSkgJiYgIShzb3VyY2VTdGF0aWNzICYmIHNvdXJjZVN0YXRpY3Nba2V5XSkgJiYgISh0YXJnZXRTdGF0aWNzICYmIHRhcmdldFN0YXRpY3Nba2V5XSkpIHtcbiAgICAgICAgdmFyIGRlc2NyaXB0b3IgPSBnZXRPd25Qcm9wZXJ0eURlc2NyaXB0b3Ioc291cmNlQ29tcG9uZW50LCBrZXkpO1xuXG4gICAgICAgIHRyeSB7XG4gICAgICAgICAgLy8gQXZvaWQgZmFpbHVyZXMgZnJvbSByZWFkLW9ubHkgcHJvcGVydGllc1xuICAgICAgICAgIGRlZmluZVByb3BlcnR5KHRhcmdldENvbXBvbmVudCwga2V5LCBkZXNjcmlwdG9yKTtcbiAgICAgICAgfSBjYXRjaCAoZSkge31cbiAgICAgIH1cbiAgICB9XG4gIH1cblxuICByZXR1cm4gdGFyZ2V0Q29tcG9uZW50O1xufVxuXG5tb2R1bGUuZXhwb3J0cyA9IGhvaXN0Tm9uUmVhY3RTdGF0aWNzO1xuIiwiY29uc3QgZGlnaXRzID0gW1wiMFwiLCBcIjFcIiwgXCIyXCIsIFwiM1wiLCBcIjRcIiwgXCI1XCIsIFwiNlwiLCBcIjdcIiwgXCI4XCIsIFwiOVwiXTtcblxuZXhwb3J0IGRlZmF1bHQgY2xhc3MgS2V5IHtcbiAgcHVibGljIHJlYWRvbmx5IGtleTogc3RyaW5nO1xuXG4gIHB1YmxpYyByZWFkb25seSBzaGlmdDogYm9vbGVhbjtcblxuICBwdWJsaWMgcmVhZG9ubHkgY3RybDogYm9vbGVhbjtcblxuICBwdWJsaWMgcmVhZG9ubHkgYWx0OiBib29sZWFuO1xuXG4gIHB1YmxpYyByZWFkb25seSBtZXRhOiBib29sZWFuO1xuXG4gIGNvbnN0cnVjdG9yKHtcbiAgICBrZXksXG4gICAgc2hpZnQgPSBmYWxzZSxcbiAgICBjdHJsID0gZmFsc2UsXG4gICAgYWx0ID0gZmFsc2UsXG4gICAgbWV0YSA9IGZhbHNlLFxuICB9OiB7XG4gICAga2V5OiBzdHJpbmc7XG4gICAgc2hpZnQ/OiBib29sZWFuO1xuICAgIGN0cmw/OiBib29sZWFuO1xuICAgIGFsdD86IGJvb2xlYW47XG4gICAgbWV0YT86IGJvb2xlYW47XG4gIH0pIHtcbiAgICB0aGlzLmtleSA9IGtleTtcbiAgICB0aGlzLnNoaWZ0ID0gc2hpZnQ7XG4gICAgdGhpcy5jdHJsID0gY3RybDtcbiAgICB0aGlzLmFsdCA9IGFsdDtcbiAgICB0aGlzLm1ldGEgPSBtZXRhO1xuICB9XG5cbiAgc3RhdGljIGZyb21NYXBLZXkoc3RyOiBzdHJpbmcpOiBLZXkge1xuICAgIGlmIChzdHIuc3RhcnRzV2l0aChcIjxcIikgJiYgc3RyLmVuZHNXaXRoKFwiPlwiKSkge1xuICAgICAgY29uc3QgaW5uZXIgPSBzdHIuc2xpY2UoMSwgLTEpO1xuICAgICAgY29uc3Qgc2hpZnQgPSBpbm5lci5pbmNsdWRlcyhcIlMtXCIpO1xuICAgICAgbGV0IGJhc2UgPSBpbm5lci5zbGljZShpbm5lci5sYXN0SW5kZXhPZihcIi1cIikgKyAxKTtcbiAgICAgIGlmIChzaGlmdCAmJiBiYXNlLmxlbmd0aCA9PT0gMSkge1xuICAgICAgICBiYXNlID0gYmFzZS50b1VwcGVyQ2FzZSgpO1xuICAgICAgfSBlbHNlIGlmICghc2hpZnQgJiYgYmFzZS5sZW5ndGggPT09IDEpIHtcbiAgICAgICAgYmFzZSA9IGJhc2UudG9Mb3dlckNhc2UoKTtcbiAgICAgIH1cbiAgICAgIHJldHVybiBuZXcgS2V5KHtcbiAgICAgICAga2V5OiBiYXNlLFxuICAgICAgICBzaGlmdDogc2hpZnQsXG4gICAgICAgIGN0cmw6IGlubmVyLmluY2x1ZGVzKFwiQy1cIiksXG4gICAgICAgIGFsdDogaW5uZXIuaW5jbHVkZXMoXCJBLVwiKSxcbiAgICAgICAgbWV0YTogaW5uZXIuaW5jbHVkZXMoXCJNLVwiKSxcbiAgICAgIH0pO1xuICAgIH1cblxuICAgIHJldHVybiBuZXcgS2V5KHtcbiAgICAgIGtleTogc3RyLFxuICAgICAgc2hpZnQ6IHN0ci50b0xvd2VyQ2FzZSgpICE9PSBzdHIsXG4gICAgICBjdHJsOiBmYWxzZSxcbiAgICAgIGFsdDogZmFsc2UsXG4gICAgICBtZXRhOiBmYWxzZSxcbiAgICB9KTtcbiAgfVxuXG4gIGlzRGlnaXQoKTogYm9vbGVhbiB7XG4gICAgcmV0dXJuIGRpZ2l0cy5pbmNsdWRlcyh0aGlzLmtleSkgJiYgIXRoaXMuY3RybCAmJiAhdGhpcy5hbHQgJiYgIXRoaXMubWV0YTtcbiAgfVxuXG4gIGVxdWFscyhrZXk6IEtleSkge1xuICAgIHJldHVybiAoXG4gICAgICB0aGlzLmtleSA9PT0ga2V5LmtleSAmJlxuICAgICAgdGhpcy5jdHJsID09PSBrZXkuY3RybCAmJlxuICAgICAgdGhpcy5tZXRhID09PSBrZXkubWV0YSAmJlxuICAgICAgdGhpcy5hbHQgPT09IGtleS5hbHQgJiZcbiAgICAgIHRoaXMuc2hpZnQgPT09IGtleS5zaGlmdFxuICAgICk7XG4gIH1cbn1cbiIsInR5cGUgRW50cmllcyA9IHsgW25hbWU6IHN0cmluZ106IHN0cmluZyB9O1xuXG5leHBvcnQgdHlwZSBTZWFyY2hKU09OID0ge1xuICBkZWZhdWx0OiBzdHJpbmc7XG4gIGVuZ2luZXM6IHsgW2tleTogc3RyaW5nXTogc3RyaW5nIH07XG59O1xuXG5leHBvcnQgZGVmYXVsdCBjbGFzcyBTZWFyY2gge1xuICBjb25zdHJ1Y3RvcihwdWJsaWMgZGVmYXVsdEVuZ2luZTogc3RyaW5nLCBwdWJsaWMgZW5naW5lczogRW50cmllcykge31cblxuICBzdGF0aWMgZnJvbUpTT04oanNvbjogU2VhcmNoSlNPTik6IFNlYXJjaCB7XG4gICAgZm9yIChjb25zdCBbbmFtZSwgdXJsXSBvZiBPYmplY3QuZW50cmllcyhqc29uLmVuZ2luZXMpKSB7XG4gICAgICBpZiAoIS9eW2EtekEtWjAtOV0rJC8udGVzdChuYW1lKSkge1xuICAgICAgICB0aHJvdyBuZXcgVHlwZUVycm9yKFwiU2VhcmNoIGVuZ2luZSdzIG5hbWUgbXVzdCBiZSBbYS16QS1aMC05XStcIik7XG4gICAgICB9XG4gICAgICBjb25zdCBtYXRjaGVzID0gdXJsLm1hdGNoKC97fS9nKTtcbiAgICAgIGlmIChtYXRjaGVzID09PSBudWxsKSB7XG4gICAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoYE5vIHt9LXBsYWNlaG9sZGVycyBpbiBVUkwgb2YgXCIke25hbWV9XCJgKTtcbiAgICAgIH0gZWxzZSBpZiAobWF0Y2hlcy5sZW5ndGggPiAxKSB7XG4gICAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoYE11bHRpcGxlIHt9LXBsYWNlaG9sZGVycyBpbiBVUkwgb2YgXCIke25hbWV9XCJgKTtcbiAgICAgIH1cbiAgICB9XG4gICAgaWYgKCFPYmplY3Qua2V5cyhqc29uLmVuZ2luZXMpLmluY2x1ZGVzKGpzb24uZGVmYXVsdCkpIHtcbiAgICAgIHRocm93IG5ldyBUeXBlRXJyb3IoYERlZmF1bHQgZW5naW5lIFwiJHtqc29uLmRlZmF1bHR9XCIgbm90IGZvdW5kYCk7XG4gICAgfVxuXG4gICAgcmV0dXJuIG5ldyBTZWFyY2goanNvbi5kZWZhdWx0LCBqc29uLmVuZ2luZXMpO1xuICB9XG5cbiAgdG9KU09OKCk6IFNlYXJjaEpTT04ge1xuICAgIHJldHVybiB7XG4gICAgICBkZWZhdWx0OiB0aGlzLmRlZmF1bHRFbmdpbmUsXG4gICAgICBlbmdpbmVzOiB0aGlzLmVuZ2luZXMsXG4gICAgfTtcbiAgfVxufVxuIiwiLy8gc2hpbSBmb3IgdXNpbmcgcHJvY2VzcyBpbiBicm93c2VyXG52YXIgcHJvY2VzcyA9IG1vZHVsZS5leHBvcnRzID0ge307XG5cbi8vIGNhY2hlZCBmcm9tIHdoYXRldmVyIGdsb2JhbCBpcyBwcmVzZW50IHNvIHRoYXQgdGVzdCBydW5uZXJzIHRoYXQgc3R1YiBpdFxuLy8gZG9uJ3QgYnJlYWsgdGhpbmdzLiAgQnV0IHdlIG5lZWQgdG8gd3JhcCBpdCBpbiBhIHRyeSBjYXRjaCBpbiBjYXNlIGl0IGlzXG4vLyB3cmFwcGVkIGluIHN0cmljdCBtb2RlIGNvZGUgd2hpY2ggZG9lc24ndCBkZWZpbmUgYW55IGdsb2JhbHMuICBJdCdzIGluc2lkZSBhXG4vLyBmdW5jdGlvbiBiZWNhdXNlIHRyeS9jYXRjaGVzIGRlb3B0aW1pemUgaW4gY2VydGFpbiBlbmdpbmVzLlxuXG52YXIgY2FjaGVkU2V0VGltZW91dDtcbnZhciBjYWNoZWRDbGVhclRpbWVvdXQ7XG5cbmZ1bmN0aW9uIGRlZmF1bHRTZXRUaW1vdXQoKSB7XG4gICAgdGhyb3cgbmV3IEVycm9yKCdzZXRUaW1lb3V0IGhhcyBub3QgYmVlbiBkZWZpbmVkJyk7XG59XG5mdW5jdGlvbiBkZWZhdWx0Q2xlYXJUaW1lb3V0ICgpIHtcbiAgICB0aHJvdyBuZXcgRXJyb3IoJ2NsZWFyVGltZW91dCBoYXMgbm90IGJlZW4gZGVmaW5lZCcpO1xufVxuKGZ1bmN0aW9uICgpIHtcbiAgICB0cnkge1xuICAgICAgICBpZiAodHlwZW9mIHNldFRpbWVvdXQgPT09ICdmdW5jdGlvbicpIHtcbiAgICAgICAgICAgIGNhY2hlZFNldFRpbWVvdXQgPSBzZXRUaW1lb3V0O1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgY2FjaGVkU2V0VGltZW91dCA9IGRlZmF1bHRTZXRUaW1vdXQ7XG4gICAgICAgIH1cbiAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgIGNhY2hlZFNldFRpbWVvdXQgPSBkZWZhdWx0U2V0VGltb3V0O1xuICAgIH1cbiAgICB0cnkge1xuICAgICAgICBpZiAodHlwZW9mIGNsZWFyVGltZW91dCA9PT0gJ2Z1bmN0aW9uJykge1xuICAgICAgICAgICAgY2FjaGVkQ2xlYXJUaW1lb3V0ID0gY2xlYXJUaW1lb3V0O1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgY2FjaGVkQ2xlYXJUaW1lb3V0ID0gZGVmYXVsdENsZWFyVGltZW91dDtcbiAgICAgICAgfVxuICAgIH0gY2F0Y2ggKGUpIHtcbiAgICAgICAgY2FjaGVkQ2xlYXJUaW1lb3V0ID0gZGVmYXVsdENsZWFyVGltZW91dDtcbiAgICB9XG59ICgpKVxuZnVuY3Rpb24gcnVuVGltZW91dChmdW4pIHtcbiAgICBpZiAoY2FjaGVkU2V0VGltZW91dCA9PT0gc2V0VGltZW91dCkge1xuICAgICAgICAvL25vcm1hbCBlbnZpcm9tZW50cyBpbiBzYW5lIHNpdHVhdGlvbnNcbiAgICAgICAgcmV0dXJuIHNldFRpbWVvdXQoZnVuLCAwKTtcbiAgICB9XG4gICAgLy8gaWYgc2V0VGltZW91dCB3YXNuJ3QgYXZhaWxhYmxlIGJ1dCB3YXMgbGF0dGVyIGRlZmluZWRcbiAgICBpZiAoKGNhY2hlZFNldFRpbWVvdXQgPT09IGRlZmF1bHRTZXRUaW1vdXQgfHwgIWNhY2hlZFNldFRpbWVvdXQpICYmIHNldFRpbWVvdXQpIHtcbiAgICAgICAgY2FjaGVkU2V0VGltZW91dCA9IHNldFRpbWVvdXQ7XG4gICAgICAgIHJldHVybiBzZXRUaW1lb3V0KGZ1biwgMCk7XG4gICAgfVxuICAgIHRyeSB7XG4gICAgICAgIC8vIHdoZW4gd2hlbiBzb21lYm9keSBoYXMgc2NyZXdlZCB3aXRoIHNldFRpbWVvdXQgYnV0IG5vIEkuRS4gbWFkZG5lc3NcbiAgICAgICAgcmV0dXJuIGNhY2hlZFNldFRpbWVvdXQoZnVuLCAwKTtcbiAgICB9IGNhdGNoKGUpe1xuICAgICAgICB0cnkge1xuICAgICAgICAgICAgLy8gV2hlbiB3ZSBhcmUgaW4gSS5FLiBidXQgdGhlIHNjcmlwdCBoYXMgYmVlbiBldmFsZWQgc28gSS5FLiBkb2Vzbid0IHRydXN0IHRoZSBnbG9iYWwgb2JqZWN0IHdoZW4gY2FsbGVkIG5vcm1hbGx5XG4gICAgICAgICAgICByZXR1cm4gY2FjaGVkU2V0VGltZW91dC5jYWxsKG51bGwsIGZ1biwgMCk7XG4gICAgICAgIH0gY2F0Y2goZSl7XG4gICAgICAgICAgICAvLyBzYW1lIGFzIGFib3ZlIGJ1dCB3aGVuIGl0J3MgYSB2ZXJzaW9uIG9mIEkuRS4gdGhhdCBtdXN0IGhhdmUgdGhlIGdsb2JhbCBvYmplY3QgZm9yICd0aGlzJywgaG9wZnVsbHkgb3VyIGNvbnRleHQgY29ycmVjdCBvdGhlcndpc2UgaXQgd2lsbCB0aHJvdyBhIGdsb2JhbCBlcnJvclxuICAgICAgICAgICAgcmV0dXJuIGNhY2hlZFNldFRpbWVvdXQuY2FsbCh0aGlzLCBmdW4sIDApO1xuICAgICAgICB9XG4gICAgfVxuXG5cbn1cbmZ1bmN0aW9uIHJ1bkNsZWFyVGltZW91dChtYXJrZXIpIHtcbiAgICBpZiAoY2FjaGVkQ2xlYXJUaW1lb3V0ID09PSBjbGVhclRpbWVvdXQpIHtcbiAgICAgICAgLy9ub3JtYWwgZW52aXJvbWVudHMgaW4gc2FuZSBzaXR1YXRpb25zXG4gICAgICAgIHJldHVybiBjbGVhclRpbWVvdXQobWFya2VyKTtcbiAgICB9XG4gICAgLy8gaWYgY2xlYXJUaW1lb3V0IHdhc24ndCBhdmFpbGFibGUgYnV0IHdhcyBsYXR0ZXIgZGVmaW5lZFxuICAgIGlmICgoY2FjaGVkQ2xlYXJUaW1lb3V0ID09PSBkZWZhdWx0Q2xlYXJUaW1lb3V0IHx8ICFjYWNoZWRDbGVhclRpbWVvdXQpICYmIGNsZWFyVGltZW91dCkge1xuICAgICAgICBjYWNoZWRDbGVhclRpbWVvdXQgPSBjbGVhclRpbWVvdXQ7XG4gICAgICAgIHJldHVybiBjbGVhclRpbWVvdXQobWFya2VyKTtcbiAgICB9XG4gICAgdHJ5IHtcbiAgICAgICAgLy8gd2hlbiB3aGVuIHNvbWVib2R5IGhhcyBzY3Jld2VkIHdpdGggc2V0VGltZW91dCBidXQgbm8gSS5FLiBtYWRkbmVzc1xuICAgICAgICByZXR1cm4gY2FjaGVkQ2xlYXJUaW1lb3V0KG1hcmtlcik7XG4gICAgfSBjYXRjaCAoZSl7XG4gICAgICAgIHRyeSB7XG4gICAgICAgICAgICAvLyBXaGVuIHdlIGFyZSBpbiBJLkUuIGJ1dCB0aGUgc2NyaXB0IGhhcyBiZWVuIGV2YWxlZCBzbyBJLkUuIGRvZXNuJ3QgIHRydXN0IHRoZSBnbG9iYWwgb2JqZWN0IHdoZW4gY2FsbGVkIG5vcm1hbGx5XG4gICAgICAgICAgICByZXR1cm4gY2FjaGVkQ2xlYXJUaW1lb3V0LmNhbGwobnVsbCwgbWFya2VyKTtcbiAgICAgICAgfSBjYXRjaCAoZSl7XG4gICAgICAgICAgICAvLyBzYW1lIGFzIGFib3ZlIGJ1dCB3aGVuIGl0J3MgYSB2ZXJzaW9uIG9mIEkuRS4gdGhhdCBtdXN0IGhhdmUgdGhlIGdsb2JhbCBvYmplY3QgZm9yICd0aGlzJywgaG9wZnVsbHkgb3VyIGNvbnRleHQgY29ycmVjdCBvdGhlcndpc2UgaXQgd2lsbCB0aHJvdyBhIGdsb2JhbCBlcnJvci5cbiAgICAgICAgICAgIC8vIFNvbWUgdmVyc2lvbnMgb2YgSS5FLiBoYXZlIGRpZmZlcmVudCBydWxlcyBmb3IgY2xlYXJUaW1lb3V0IHZzIHNldFRpbWVvdXRcbiAgICAgICAgICAgIHJldHVybiBjYWNoZWRDbGVhclRpbWVvdXQuY2FsbCh0aGlzLCBtYXJrZXIpO1xuICAgICAgICB9XG4gICAgfVxuXG5cblxufVxudmFyIHF1ZXVlID0gW107XG52YXIgZHJhaW5pbmcgPSBmYWxzZTtcbnZhciBjdXJyZW50UXVldWU7XG52YXIgcXVldWVJbmRleCA9IC0xO1xuXG5mdW5jdGlvbiBjbGVhblVwTmV4dFRpY2soKSB7XG4gICAgaWYgKCFkcmFpbmluZyB8fCAhY3VycmVudFF1ZXVlKSB7XG4gICAgICAgIHJldHVybjtcbiAgICB9XG4gICAgZHJhaW5pbmcgPSBmYWxzZTtcbiAgICBpZiAoY3VycmVudFF1ZXVlLmxlbmd0aCkge1xuICAgICAgICBxdWV1ZSA9IGN1cnJlbnRRdWV1ZS5jb25jYXQocXVldWUpO1xuICAgIH0gZWxzZSB7XG4gICAgICAgIHF1ZXVlSW5kZXggPSAtMTtcbiAgICB9XG4gICAgaWYgKHF1ZXVlLmxlbmd0aCkge1xuICAgICAgICBkcmFpblF1ZXVlKCk7XG4gICAgfVxufVxuXG5mdW5jdGlvbiBkcmFpblF1ZXVlKCkge1xuICAgIGlmIChkcmFpbmluZykge1xuICAgICAgICByZXR1cm47XG4gICAgfVxuICAgIHZhciB0aW1lb3V0ID0gcnVuVGltZW91dChjbGVhblVwTmV4dFRpY2spO1xuICAgIGRyYWluaW5nID0gdHJ1ZTtcblxuICAgIHZhciBsZW4gPSBxdWV1ZS5sZW5ndGg7XG4gICAgd2hpbGUobGVuKSB7XG4gICAgICAgIGN1cnJlbnRRdWV1ZSA9IHF1ZXVlO1xuICAgICAgICBxdWV1ZSA9IFtdO1xuICAgICAgICB3aGlsZSAoKytxdWV1ZUluZGV4IDwgbGVuKSB7XG4gICAgICAgICAgICBpZiAoY3VycmVudFF1ZXVlKSB7XG4gICAgICAgICAgICAgICAgY3VycmVudFF1ZXVlW3F1ZXVlSW5kZXhdLnJ1bigpO1xuICAgICAgICAgICAgfVxuICAgICAgICB9XG4gICAgICAgIHF1ZXVlSW5kZXggPSAtMTtcbiAgICAgICAgbGVuID0gcXVldWUubGVuZ3RoO1xuICAgIH1cbiAgICBjdXJyZW50UXVldWUgPSBudWxsO1xuICAgIGRyYWluaW5nID0gZmFsc2U7XG4gICAgcnVuQ2xlYXJUaW1lb3V0KHRpbWVvdXQpO1xufVxuXG5wcm9jZXNzLm5leHRUaWNrID0gZnVuY3Rpb24gKGZ1bikge1xuICAgIHZhciBhcmdzID0gbmV3IEFycmF5KGFyZ3VtZW50cy5sZW5ndGggLSAxKTtcbiAgICBpZiAoYXJndW1lbnRzLmxlbmd0aCA+IDEpIHtcbiAgICAgICAgZm9yICh2YXIgaSA9IDE7IGkgPCBhcmd1bWVudHMubGVuZ3RoOyBpKyspIHtcbiAgICAgICAgICAgIGFyZ3NbaSAtIDFdID0gYXJndW1lbnRzW2ldO1xuICAgICAgICB9XG4gICAgfVxuICAgIHF1ZXVlLnB1c2gobmV3IEl0ZW0oZnVuLCBhcmdzKSk7XG4gICAgaWYgKHF1ZXVlLmxlbmd0aCA9PT0gMSAmJiAhZHJhaW5pbmcpIHtcbiAgICAgICAgcnVuVGltZW91dChkcmFpblF1ZXVlKTtcbiAgICB9XG59O1xuXG4vLyB2OCBsaWtlcyBwcmVkaWN0aWJsZSBvYmplY3RzXG5mdW5jdGlvbiBJdGVtKGZ1biwgYXJyYXkpIHtcbiAgICB0aGlzLmZ1biA9IGZ1bjtcbiAgICB0aGlzLmFycmF5ID0gYXJyYXk7XG59XG5JdGVtLnByb3RvdHlwZS5ydW4gPSBmdW5jdGlvbiAoKSB7XG4gICAgdGhpcy5mdW4uYXBwbHkobnVsbCwgdGhpcy5hcnJheSk7XG59O1xucHJvY2Vzcy50aXRsZSA9ICdicm93c2VyJztcbnByb2Nlc3MuYnJvd3NlciA9IHRydWU7XG5wcm9jZXNzLmVudiA9IHt9O1xucHJvY2Vzcy5hcmd2ID0gW107XG5wcm9jZXNzLnZlcnNpb24gPSAnJzsgLy8gZW1wdHkgc3RyaW5nIHRvIGF2b2lkIHJlZ2V4cCBpc3N1ZXNcbnByb2Nlc3MudmVyc2lvbnMgPSB7fTtcblxuZnVuY3Rpb24gbm9vcCgpIHt9XG5cbnByb2Nlc3Mub24gPSBub29wO1xucHJvY2Vzcy5hZGRMaXN0ZW5lciA9IG5vb3A7XG5wcm9jZXNzLm9uY2UgPSBub29wO1xucHJvY2Vzcy5vZmYgPSBub29wO1xucHJvY2Vzcy5yZW1vdmVMaXN0ZW5lciA9IG5vb3A7XG5wcm9jZXNzLnJlbW92ZUFsbExpc3RlbmVycyA9IG5vb3A7XG5wcm9jZXNzLmVtaXQgPSBub29wO1xucHJvY2Vzcy5wcmVwZW5kTGlzdGVuZXIgPSBub29wO1xucHJvY2Vzcy5wcmVwZW5kT25jZUxpc3RlbmVyID0gbm9vcDtcblxucHJvY2Vzcy5saXN0ZW5lcnMgPSBmdW5jdGlvbiAobmFtZSkgeyByZXR1cm4gW10gfVxuXG5wcm9jZXNzLmJpbmRpbmcgPSBmdW5jdGlvbiAobmFtZSkge1xuICAgIHRocm93IG5ldyBFcnJvcigncHJvY2Vzcy5iaW5kaW5nIGlzIG5vdCBzdXBwb3J0ZWQnKTtcbn07XG5cbnByb2Nlc3MuY3dkID0gZnVuY3Rpb24gKCkgeyByZXR1cm4gJy8nIH07XG5wcm9jZXNzLmNoZGlyID0gZnVuY3Rpb24gKGRpcikge1xuICAgIHRocm93IG5ldyBFcnJvcigncHJvY2Vzcy5jaGRpciBpcyBub3Qgc3VwcG9ydGVkJyk7XG59O1xucHJvY2Vzcy51bWFzayA9IGZ1bmN0aW9uKCkgeyByZXR1cm4gMDsgfTtcbiIsIid1c2Ugc3RyaWN0JztcbnZhciBlcXVhbCA9IHJlcXVpcmUoJ2Fqdi9saWIvY29tcGlsZS9lcXVhbCcpO1xudmFyIHZhbGlkYXRlID0gKGZ1bmN0aW9uKCkge1xuICB2YXIgcGF0dGVybjAgPSBuZXcgUmVnRXhwKCcuKicpO1xuICB2YXIgcmVmVmFsID0gW107XG4gIHJldHVybiBmdW5jdGlvbiB2YWxpZGF0ZShkYXRhLCBkYXRhUGF0aCwgcGFyZW50RGF0YSwgcGFyZW50RGF0YVByb3BlcnR5LCByb290RGF0YSkge1xuICAgICd1c2Ugc3RyaWN0JztcbiAgICB2YXIgdkVycm9ycyA9IG51bGw7XG4gICAgdmFyIGVycm9ycyA9IDA7XG4gICAgaWYgKChkYXRhICYmIHR5cGVvZiBkYXRhID09PSBcIm9iamVjdFwiICYmICFBcnJheS5pc0FycmF5KGRhdGEpKSkge1xuICAgICAgdmFyIGVycnNfXzAgPSBlcnJvcnM7XG4gICAgICB2YXIgdmFsaWQxID0gdHJ1ZTtcbiAgICAgIGZvciAodmFyIGtleTAgaW4gZGF0YSkge1xuICAgICAgICB2YXIgaXNBZGRpdGlvbmFsMCA9ICEoZmFsc2UgfHwga2V5MCA9PSAna2V5bWFwcycgfHwga2V5MCA9PSAnc2VhcmNoJyB8fCBrZXkwID09ICdwcm9wZXJ0aWVzJyB8fCBrZXkwID09ICdibGFja2xpc3QnKTtcbiAgICAgICAgaWYgKGlzQWRkaXRpb25hbDApIHtcbiAgICAgICAgICB2YWxpZDEgPSBmYWxzZTtcbiAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAga2V5d29yZDogJ2FkZGl0aW9uYWxQcm9wZXJ0aWVzJyxcbiAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgXCJcIixcbiAgICAgICAgICAgIHNjaGVtYVBhdGg6ICcjL2FkZGl0aW9uYWxQcm9wZXJ0aWVzJyxcbiAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICBhZGRpdGlvbmFsUHJvcGVydHk6ICcnICsga2V5MCArICcnXG4gICAgICAgICAgICB9LFxuICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBOT1QgaGF2ZSBhZGRpdGlvbmFsIHByb3BlcnRpZXMnXG4gICAgICAgICAgfV07XG4gICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgIGJyZWFrO1xuICAgICAgICB9XG4gICAgICB9XG4gICAgICBpZiAodmFsaWQxKSB7XG4gICAgICAgIHZhciBkYXRhMSA9IGRhdGEua2V5bWFwcztcbiAgICAgICAgaWYgKGRhdGExID09PSB1bmRlZmluZWQpIHtcbiAgICAgICAgICB2YWxpZDEgPSB0cnVlO1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgIHZhciBlcnJzXzEgPSBlcnJvcnM7XG4gICAgICAgICAgaWYgKChkYXRhMSAmJiB0eXBlb2YgZGF0YTEgPT09IFwib2JqZWN0XCIgJiYgIUFycmF5LmlzQXJyYXkoZGF0YTEpKSkge1xuICAgICAgICAgICAgdmFyIGVycnNfXzEgPSBlcnJvcnM7XG4gICAgICAgICAgICB2YXIgdmFsaWQyID0gdHJ1ZTtcbiAgICAgICAgICAgIGZvciAodmFyIGtleTEgaW4gZGF0YTEpIHtcbiAgICAgICAgICAgICAgaWYgKHBhdHRlcm4wLnRlc3Qoa2V5MSkpIHtcbiAgICAgICAgICAgICAgICB2YXIgZGF0YTIgPSBkYXRhMVtrZXkxXTtcbiAgICAgICAgICAgICAgICB2YXIgZXJyc18yID0gZXJyb3JzO1xuICAgICAgICAgICAgICAgIGlmICgoZGF0YTIgJiYgdHlwZW9mIGRhdGEyID09PSBcIm9iamVjdFwiICYmICFBcnJheS5pc0FycmF5KGRhdGEyKSkpIHtcbiAgICAgICAgICAgICAgICAgIGlmICh0cnVlKSB7XG4gICAgICAgICAgICAgICAgICAgIHZhciBlcnJzX18yID0gZXJyb3JzO1xuICAgICAgICAgICAgICAgICAgICB2YXIgdmFsaWQzID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICAgICAgaWYgKGRhdGEyLnR5cGUgPT09IHVuZGVmaW5lZCkge1xuICAgICAgICAgICAgICAgICAgICAgIHZhbGlkMyA9IGZhbHNlO1xuICAgICAgICAgICAgICAgICAgICAgIHZhbGlkYXRlLmVycm9ycyA9IFt7XG4gICAgICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAncmVxdWlyZWQnLFxuICAgICAgICAgICAgICAgICAgICAgICAgZGF0YVBhdGg6IChkYXRhUGF0aCB8fCAnJykgKyAnLmtleW1hcHNbXFwnJyArIGtleTEgKyAnXFwnXScsXG4gICAgICAgICAgICAgICAgICAgICAgICBzY2hlbWFQYXRoOiAnIy9wcm9wZXJ0aWVzL2tleW1hcHMvcGF0dGVyblByb3BlcnRpZXMvLiovcmVxdWlyZWQnLFxuICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIG1pc3NpbmdQcm9wZXJ0eTogJ3R5cGUnXG4gICAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBoYXZlIHJlcXVpcmVkIHByb3BlcnR5IFxcJ3R5cGVcXCcnXG4gICAgICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnJzXzMgPSBlcnJvcnM7XG4gICAgICAgICAgICAgICAgICAgICAgaWYgKHR5cGVvZiBkYXRhMi50eXBlICE9PSBcInN0cmluZ1wiKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5rZXltYXBzW1xcJycgKyBrZXkxICsgJ1xcJ10udHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgIHNjaGVtYVBhdGg6ICcjL3Byb3BlcnRpZXMva2V5bWFwcy9wYXR0ZXJuUHJvcGVydGllcy8uKi9wcm9wZXJ0aWVzL3R5cGUvdHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdzdHJpbmcnXG4gICAgICAgICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgYmUgc3RyaW5nJ1xuICAgICAgICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDMgPSBlcnJvcnMgPT09IGVycnNfMztcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5rZXltYXBzW1xcJycgKyBrZXkxICsgJ1xcJ10nLFxuICAgICAgICAgICAgICAgICAgICBzY2hlbWFQYXRoOiAnIy9wcm9wZXJ0aWVzL2tleW1hcHMvcGF0dGVyblByb3BlcnRpZXMvLiovdHlwZScsXG4gICAgICAgICAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdvYmplY3QnXG4gICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgYmUgb2JqZWN0J1xuICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIHZhciB2YWxpZDIgPSBlcnJvcnMgPT09IGVycnNfMjtcbiAgICAgICAgICAgICAgICBpZiAoIXZhbGlkMikgYnJlYWs7XG4gICAgICAgICAgICAgIH0gZWxzZSB2YWxpZDIgPSB0cnVlO1xuICAgICAgICAgICAgfVxuICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5rZXltYXBzJyxcbiAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9rZXltYXBzL3R5cGUnLFxuICAgICAgICAgICAgICBwYXJhbXM6IHtcbiAgICAgICAgICAgICAgICB0eXBlOiAnb2JqZWN0J1xuICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICBtZXNzYWdlOiAnc2hvdWxkIGJlIG9iamVjdCdcbiAgICAgICAgICAgIH1dO1xuICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgIH1cbiAgICAgICAgICB2YXIgdmFsaWQxID0gZXJyb3JzID09PSBlcnJzXzE7XG4gICAgICAgIH1cbiAgICAgICAgaWYgKHZhbGlkMSkge1xuICAgICAgICAgIHZhciBkYXRhMSA9IGRhdGEuc2VhcmNoO1xuICAgICAgICAgIGlmIChkYXRhMSA9PT0gdW5kZWZpbmVkKSB7XG4gICAgICAgICAgICB2YWxpZDEgPSB0cnVlO1xuICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICB2YXIgZXJyc18xID0gZXJyb3JzO1xuICAgICAgICAgICAgaWYgKChkYXRhMSAmJiB0eXBlb2YgZGF0YTEgPT09IFwib2JqZWN0XCIgJiYgIUFycmF5LmlzQXJyYXkoZGF0YTEpKSkge1xuICAgICAgICAgICAgICBpZiAodHJ1ZSkge1xuICAgICAgICAgICAgICAgIHZhciBlcnJzX18xID0gZXJyb3JzO1xuICAgICAgICAgICAgICAgIHZhciB2YWxpZDIgPSB0cnVlO1xuICAgICAgICAgICAgICAgIGlmIChkYXRhMS5kZWZhdWx0ID09PSB1bmRlZmluZWQpIHtcbiAgICAgICAgICAgICAgICAgIHZhbGlkMiA9IGZhbHNlO1xuICAgICAgICAgICAgICAgICAgdmFsaWRhdGUuZXJyb3JzID0gW3tcbiAgICAgICAgICAgICAgICAgICAga2V5d29yZDogJ3JlcXVpcmVkJyxcbiAgICAgICAgICAgICAgICAgICAgZGF0YVBhdGg6IChkYXRhUGF0aCB8fCAnJykgKyAnLnNlYXJjaCcsXG4gICAgICAgICAgICAgICAgICAgIHNjaGVtYVBhdGg6ICcjL3Byb3BlcnRpZXMvc2VhcmNoL3JlcXVpcmVkJyxcbiAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgbWlzc2luZ1Byb3BlcnR5OiAnZGVmYXVsdCdcbiAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBoYXZlIHJlcXVpcmVkIHByb3BlcnR5IFxcJ2RlZmF1bHRcXCcnXG4gICAgICAgICAgICAgICAgICB9XTtcbiAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTtcbiAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgdmFyIGVycnNfMiA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgIGlmICh0eXBlb2YgZGF0YTEuZGVmYXVsdCAhPT0gXCJzdHJpbmdcIikge1xuICAgICAgICAgICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICAgICAgICAgIGtleXdvcmQ6ICd0eXBlJyxcbiAgICAgICAgICAgICAgICAgICAgICBkYXRhUGF0aDogKGRhdGFQYXRoIHx8ICcnKSArICcuc2VhcmNoLmRlZmF1bHQnLFxuICAgICAgICAgICAgICAgICAgICAgIHNjaGVtYVBhdGg6ICcjL3Byb3BlcnRpZXMvc2VhcmNoL3Byb3BlcnRpZXMvZGVmYXVsdC90eXBlJyxcbiAgICAgICAgICAgICAgICAgICAgICBwYXJhbXM6IHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdzdHJpbmcnXG4gICAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgICBtZXNzYWdlOiAnc2hvdWxkIGJlIHN0cmluZydcbiAgICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTtcbiAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDIgPSBlcnJvcnMgPT09IGVycnNfMjtcbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgaWYgKHZhbGlkMikge1xuICAgICAgICAgICAgICAgICAgdmFyIGRhdGEyID0gZGF0YTEuZW5naW5lcztcbiAgICAgICAgICAgICAgICAgIGlmIChkYXRhMiA9PT0gdW5kZWZpbmVkKSB7XG4gICAgICAgICAgICAgICAgICAgIHZhbGlkMiA9IGZhbHNlO1xuICAgICAgICAgICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICAgICAgICAgIGtleXdvcmQ6ICdyZXF1aXJlZCcsXG4gICAgICAgICAgICAgICAgICAgICAgZGF0YVBhdGg6IChkYXRhUGF0aCB8fCAnJykgKyAnLnNlYXJjaCcsXG4gICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9zZWFyY2gvcmVxdWlyZWQnLFxuICAgICAgICAgICAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICAgICAgICAgICAgbWlzc2luZ1Byb3BlcnR5OiAnZW5naW5lcydcbiAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgaGF2ZSByZXF1aXJlZCBwcm9wZXJ0eSBcXCdlbmdpbmVzXFwnJ1xuICAgICAgICAgICAgICAgICAgICB9XTtcbiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgdmFyIGVycnNfMiA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgaWYgKChkYXRhMiAmJiB0eXBlb2YgZGF0YTIgPT09IFwib2JqZWN0XCIgJiYgIUFycmF5LmlzQXJyYXkoZGF0YTIpKSkge1xuICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnJzX18yID0gZXJyb3JzO1xuICAgICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDMgPSB0cnVlO1xuICAgICAgICAgICAgICAgICAgICAgIGZvciAodmFyIGtleTIgaW4gZGF0YTIpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChwYXR0ZXJuMC50ZXN0KGtleTIpKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnJzXzMgPSBlcnJvcnM7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0eXBlb2YgZGF0YTJba2V5Ml0gIT09IFwic3RyaW5nXCIpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2V5d29yZDogJ3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YVBhdGg6IChkYXRhUGF0aCB8fCAnJykgKyAnLnNlYXJjaC5lbmdpbmVzW1xcJycgKyBrZXkyICsgJ1xcJ10nLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9zZWFyY2gvcHJvcGVydGllcy9lbmdpbmVzL3BhdHRlcm5Qcm9wZXJ0aWVzLy4qL3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdzdHJpbmcnXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBiZSBzdHJpbmcnXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDMgPSBlcnJvcnMgPT09IGVycnNfMztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCF2YWxpZDMpIGJyZWFrO1xuICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHZhbGlkMyA9IHRydWU7XG4gICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICAgIHZhbGlkYXRlLmVycm9ycyA9IFt7XG4gICAgICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICBkYXRhUGF0aDogKGRhdGFQYXRoIHx8ICcnKSArICcuc2VhcmNoLmVuZ2luZXMnLFxuICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9zZWFyY2gvcHJvcGVydGllcy9lbmdpbmVzL3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdvYmplY3QnXG4gICAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBiZSBvYmplY3QnXG4gICAgICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDIgPSBlcnJvcnMgPT09IGVycnNfMjtcbiAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgIHZhbGlkYXRlLmVycm9ycyA9IFt7XG4gICAgICAgICAgICAgICAga2V5d29yZDogJ3R5cGUnLFxuICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5zZWFyY2gnLFxuICAgICAgICAgICAgICAgIHNjaGVtYVBhdGg6ICcjL3Byb3BlcnRpZXMvc2VhcmNoL3R5cGUnLFxuICAgICAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICAgICAgdHlwZTogJ29iamVjdCdcbiAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgYmUgb2JqZWN0J1xuICAgICAgICAgICAgICB9XTtcbiAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgdmFyIHZhbGlkMSA9IGVycm9ycyA9PT0gZXJyc18xO1xuICAgICAgICAgIH1cbiAgICAgICAgICBpZiAodmFsaWQxKSB7XG4gICAgICAgICAgICB2YXIgZGF0YTEgPSBkYXRhLnByb3BlcnRpZXM7XG4gICAgICAgICAgICBpZiAoZGF0YTEgPT09IHVuZGVmaW5lZCkge1xuICAgICAgICAgICAgICB2YWxpZDEgPSB0cnVlO1xuICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgdmFyIGVycnNfMSA9IGVycm9ycztcbiAgICAgICAgICAgICAgaWYgKChkYXRhMSAmJiB0eXBlb2YgZGF0YTEgPT09IFwib2JqZWN0XCIgJiYgIUFycmF5LmlzQXJyYXkoZGF0YTEpKSkge1xuICAgICAgICAgICAgICAgIHZhciBlcnJzX18xID0gZXJyb3JzO1xuICAgICAgICAgICAgICAgIHZhciB2YWxpZDIgPSB0cnVlO1xuICAgICAgICAgICAgICAgIGlmIChkYXRhMS5oaW50Y2hhcnMgPT09IHVuZGVmaW5lZCkge1xuICAgICAgICAgICAgICAgICAgdmFsaWQyID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgdmFyIGVycnNfMiA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgIGlmICh0eXBlb2YgZGF0YTEuaGludGNoYXJzICE9PSBcInN0cmluZ1wiKSB7XG4gICAgICAgICAgICAgICAgICAgIHZhbGlkYXRlLmVycm9ycyA9IFt7XG4gICAgICAgICAgICAgICAgICAgICAga2V5d29yZDogJ3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5wcm9wZXJ0aWVzLmhpbnRjaGFycycsXG4gICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9wcm9wZXJ0aWVzL3Byb3BlcnRpZXMvaGludGNoYXJzL3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICAgICAgICAgICAgdHlwZTogJ3N0cmluZydcbiAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgYmUgc3RyaW5nJ1xuICAgICAgICAgICAgICAgICAgICB9XTtcbiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgdmFyIHZhbGlkMiA9IGVycm9ycyA9PT0gZXJyc18yO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICBpZiAodmFsaWQyKSB7XG4gICAgICAgICAgICAgICAgICBpZiAoZGF0YTEuc21vb3Roc2Nyb2xsID09PSB1bmRlZmluZWQpIHtcbiAgICAgICAgICAgICAgICAgICAgdmFsaWQyID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgIHZhciBlcnJzXzIgPSBlcnJvcnM7XG4gICAgICAgICAgICAgICAgICAgIGlmICh0eXBlb2YgZGF0YTEuc21vb3Roc2Nyb2xsICE9PSBcImJvb2xlYW5cIikge1xuICAgICAgICAgICAgICAgICAgICAgIHZhbGlkYXRlLmVycm9ycyA9IFt7XG4gICAgICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICBkYXRhUGF0aDogKGRhdGFQYXRoIHx8ICcnKSArICcucHJvcGVydGllcy5zbW9vdGhzY3JvbGwnLFxuICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9wcm9wZXJ0aWVzL3Byb3BlcnRpZXMvc21vb3Roc2Nyb2xsL3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdib29sZWFuJ1xuICAgICAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgYmUgYm9vbGVhbidcbiAgICAgICAgICAgICAgICAgICAgICB9XTtcbiAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgdmFyIHZhbGlkMiA9IGVycm9ycyA9PT0gZXJyc18yO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgaWYgKHZhbGlkMikge1xuICAgICAgICAgICAgICAgICAgICBpZiAoZGF0YTEuY29tcGxldGUgPT09IHVuZGVmaW5lZCkge1xuICAgICAgICAgICAgICAgICAgICAgIHZhbGlkMiA9IHRydWU7XG4gICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgICAgdmFyIGVycnNfMiA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgICBpZiAodHlwZW9mIGRhdGExLmNvbXBsZXRlICE9PSBcInN0cmluZ1wiKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5wcm9wZXJ0aWVzLmNvbXBsZXRlJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9wcm9wZXJ0aWVzL3Byb3BlcnRpZXMvY29tcGxldGUvdHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdzdHJpbmcnXG4gICAgICAgICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgYmUgc3RyaW5nJ1xuICAgICAgICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDIgPSBlcnJvcnMgPT09IGVycnNfMjtcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICBpZiAodmFsaWQyKSB7XG4gICAgICAgICAgICAgICAgICAgICAgdmFyIGRhdGEyID0gZGF0YTEuY29sb3JzY2hlbWU7XG4gICAgICAgICAgICAgICAgICAgICAgaWYgKGRhdGEyID09PSB1bmRlZmluZWQpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHZhbGlkMiA9IHRydWU7XG4gICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnJzXzIgPSBlcnJvcnM7XG4gICAgICAgICAgICAgICAgICAgICAgICBpZiAodHlwZW9mIGRhdGEyICE9PSBcInN0cmluZ1wiKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIHZhbGlkYXRlLmVycm9ycyA9IFt7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAga2V5d29yZDogJ3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5wcm9wZXJ0aWVzLmNvbG9yc2NoZW1lJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzY2hlbWFQYXRoOiAnIy9wcm9wZXJ0aWVzL3Byb3BlcnRpZXMvcHJvcGVydGllcy9jb2xvcnNjaGVtZS90eXBlJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJhbXM6IHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdzdHJpbmcnXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZXNzYWdlOiAnc2hvdWxkIGJlIHN0cmluZydcbiAgICAgICAgICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTtcbiAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgIHZhciBzY2hlbWEyID0gdmFsaWRhdGUuc2NoZW1hLnByb3BlcnRpZXMucHJvcGVydGllcy5wcm9wZXJ0aWVzLmNvbG9yc2NoZW1lLmVudW07XG4gICAgICAgICAgICAgICAgICAgICAgICB2YXIgdmFsaWQyO1xuICAgICAgICAgICAgICAgICAgICAgICAgdmFsaWQyID0gZmFsc2U7XG4gICAgICAgICAgICAgICAgICAgICAgICBmb3IgKHZhciBpMiA9IDA7IGkyIDwgc2NoZW1hMi5sZW5ndGg7IGkyKyspXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcXVhbChkYXRhMiwgc2NoZW1hMltpMl0pKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFsaWQyID0gdHJ1ZTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhaztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgfSBpZiAoIXZhbGlkMikge1xuICAgICAgICAgICAgICAgICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtleXdvcmQ6ICdlbnVtJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhUGF0aDogKGRhdGFQYXRoIHx8ICcnKSArICcucHJvcGVydGllcy5jb2xvcnNjaGVtZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9wcm9wZXJ0aWVzL3Byb3BlcnRpZXMvY29sb3JzY2hlbWUvZW51bScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbGxvd2VkVmFsdWVzOiBzY2hlbWEyXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZXNzYWdlOiAnc2hvdWxkIGJlIGVxdWFsIHRvIG9uZSBvZiB0aGUgYWxsb3dlZCB2YWx1ZXMnXG4gICAgICAgICAgICAgICAgICAgICAgICAgIH1dO1xuICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgICB2YXIgdmFsaWQyID0gZXJyb3JzID09PSBlcnJzXzI7XG4gICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIHZhbGlkYXRlLmVycm9ycyA9IFt7XG4gICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICBkYXRhUGF0aDogKGRhdGFQYXRoIHx8ICcnKSArICcucHJvcGVydGllcycsXG4gICAgICAgICAgICAgICAgICBzY2hlbWFQYXRoOiAnIy9wcm9wZXJ0aWVzL3Byb3BlcnRpZXMvdHlwZScsXG4gICAgICAgICAgICAgICAgICBwYXJhbXM6IHtcbiAgICAgICAgICAgICAgICAgICAgdHlwZTogJ29iamVjdCdcbiAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICBtZXNzYWdlOiAnc2hvdWxkIGJlIG9iamVjdCdcbiAgICAgICAgICAgICAgICB9XTtcbiAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgdmFyIHZhbGlkMSA9IGVycm9ycyA9PT0gZXJyc18xO1xuICAgICAgICAgICAgfVxuICAgICAgICAgICAgaWYgKHZhbGlkMSkge1xuICAgICAgICAgICAgICB2YXIgZGF0YTEgPSBkYXRhLmJsYWNrbGlzdDtcbiAgICAgICAgICAgICAgaWYgKGRhdGExID09PSB1bmRlZmluZWQpIHtcbiAgICAgICAgICAgICAgICB2YWxpZDEgPSB0cnVlO1xuICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgIHZhciBlcnJzXzEgPSBlcnJvcnM7XG4gICAgICAgICAgICAgICAgaWYgKEFycmF5LmlzQXJyYXkoZGF0YTEpKSB7XG4gICAgICAgICAgICAgICAgICB2YXIgZXJyc19fMSA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDE7XG4gICAgICAgICAgICAgICAgICBmb3IgKHZhciBpMSA9IDA7IGkxIDwgZGF0YTEubGVuZ3RoOyBpMSsrKSB7XG4gICAgICAgICAgICAgICAgICAgIHZhciBkYXRhMiA9IGRhdGExW2kxXTtcbiAgICAgICAgICAgICAgICAgICAgdmFyIGVycnNfMiA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgdmFyIGVycnNfXzIgPSBlcnJvcnM7XG4gICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDIgPSBmYWxzZTtcbiAgICAgICAgICAgICAgICAgICAgdmFyIGVycnNfMyA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgaWYgKHR5cGVvZiBkYXRhMiAhPT0gXCJzdHJpbmdcIikge1xuICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnIgPSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICBkYXRhUGF0aDogKGRhdGFQYXRoIHx8ICcnKSArICcuYmxhY2tsaXN0WycgKyBpMSArICddJyxcbiAgICAgICAgICAgICAgICAgICAgICAgIHNjaGVtYVBhdGg6ICcjL3Byb3BlcnRpZXMvYmxhY2tsaXN0L2l0ZW1zL2FueU9mLzAvdHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICBwYXJhbXM6IHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgdHlwZTogJ3N0cmluZydcbiAgICAgICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICBtZXNzYWdlOiAnc2hvdWxkIGJlIHN0cmluZydcbiAgICAgICAgICAgICAgICAgICAgICB9O1xuICAgICAgICAgICAgICAgICAgICAgIGlmICh2RXJyb3JzID09PSBudWxsKSB2RXJyb3JzID0gW2Vycl07XG4gICAgICAgICAgICAgICAgICAgICAgZWxzZSB2RXJyb3JzLnB1c2goZXJyKTtcbiAgICAgICAgICAgICAgICAgICAgICBlcnJvcnMrKztcbiAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICB2YXIgdmFsaWQzID0gZXJyb3JzID09PSBlcnJzXzM7XG4gICAgICAgICAgICAgICAgICAgIHZhbGlkMiA9IHZhbGlkMiB8fCB2YWxpZDM7XG4gICAgICAgICAgICAgICAgICAgIGlmICghdmFsaWQyKSB7XG4gICAgICAgICAgICAgICAgICAgICAgdmFyIGVycnNfMyA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgICBpZiAoKGRhdGEyICYmIHR5cGVvZiBkYXRhMiA9PT0gXCJvYmplY3RcIiAmJiAhQXJyYXkuaXNBcnJheShkYXRhMikpKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICBpZiAodHJ1ZSkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICB2YXIgZXJyc19fMyA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgdmFyIHZhbGlkNCA9IHRydWU7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChkYXRhMi51cmwgPT09IHVuZGVmaW5lZCkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbGlkNCA9IGZhbHNlO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnIgPSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAncmVxdWlyZWQnLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YVBhdGg6IChkYXRhUGF0aCB8fCAnJykgKyAnLmJsYWNrbGlzdFsnICsgaTEgKyAnXScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzY2hlbWFQYXRoOiAnIy9wcm9wZXJ0aWVzL2JsYWNrbGlzdC9pdGVtcy9hbnlPZi8xL3JlcXVpcmVkJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtaXNzaW5nUHJvcGVydHk6ICd1cmwnXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBoYXZlIHJlcXVpcmVkIHByb3BlcnR5IFxcJ3VybFxcJydcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9O1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2RXJyb3JzID09PSBudWxsKSB2RXJyb3JzID0gW2Vycl07XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSB2RXJyb3JzLnB1c2goZXJyKTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcnMrKztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YXIgZXJyc180ID0gZXJyb3JzO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0eXBlb2YgZGF0YTIudXJsICE9PSBcInN0cmluZ1wiKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YXIgZXJyID0ge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5ibGFja2xpc3RbJyArIGkxICsgJ10udXJsJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9ibGFja2xpc3QvaXRlbXMvYW55T2YvMS9wcm9wZXJ0aWVzL3VybC90eXBlJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHlwZTogJ3N0cmluZydcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBiZSBzdHJpbmcnXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9O1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZFcnJvcnMgPT09IG51bGwpIHZFcnJvcnMgPSBbZXJyXTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgdkVycm9ycy5wdXNoKGVycik7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcnMrKztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFyIHZhbGlkNCA9IGVycm9ycyA9PT0gZXJyc180O1xuICAgICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2YWxpZDQpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YXIgZGF0YTMgPSBkYXRhMi5rZXlzO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChkYXRhMyA9PT0gdW5kZWZpbmVkKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWxpZDQgPSBmYWxzZTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnIgPSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtleXdvcmQ6ICdyZXF1aXJlZCcsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5ibGFja2xpc3RbJyArIGkxICsgJ10nLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzY2hlbWFQYXRoOiAnIy9wcm9wZXJ0aWVzL2JsYWNrbGlzdC9pdGVtcy9hbnlPZi8xL3JlcXVpcmVkJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWlzc2luZ1Byb3BlcnR5OiAna2V5cydcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBoYXZlIHJlcXVpcmVkIHByb3BlcnR5IFxcJ2tleXNcXCcnXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9O1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZFcnJvcnMgPT09IG51bGwpIHZFcnJvcnMgPSBbZXJyXTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgdkVycm9ycy5wdXNoKGVycik7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcnMrKztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFyIGVycnNfNCA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChBcnJheS5pc0FycmF5KGRhdGEzKSkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YXIgZXJyc19fNCA9IGVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFyIHZhbGlkNDtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9yICh2YXIgaTQgPSAwOyBpNCA8IGRhdGEzLmxlbmd0aDsgaTQrKykge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnJzXzUgPSBlcnJvcnM7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHR5cGVvZiBkYXRhM1tpNF0gIT09IFwic3RyaW5nXCIpIHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnIgPSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtleXdvcmQ6ICd0eXBlJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YVBhdGg6IChkYXRhUGF0aCB8fCAnJykgKyAnLmJsYWNrbGlzdFsnICsgaTEgKyAnXS5rZXlzWycgKyBpNCArICddJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9ibGFja2xpc3QvaXRlbXMvYW55T2YvMS9wcm9wZXJ0aWVzL2tleXMvaXRlbXMvdHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtczoge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHR5cGU6ICdzdHJpbmcnXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0sXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgYmUgc3RyaW5nJ1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2RXJyb3JzID09PSBudWxsKSB2RXJyb3JzID0gW2Vycl07XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIHZFcnJvcnMucHVzaChlcnIpO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3JzKys7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDUgPSBlcnJvcnMgPT09IGVycnNfNTtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXZhbGlkNSkgYnJlYWs7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhciBlcnIgPSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2V5d29yZDogJ3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5ibGFja2xpc3RbJyArIGkxICsgJ10ua2V5cycsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9ibGFja2xpc3QvaXRlbXMvYW55T2YvMS9wcm9wZXJ0aWVzL2tleXMvdHlwZScsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlOiAnYXJyYXknXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZXNzYWdlOiAnc2hvdWxkIGJlIGFycmF5J1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9O1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodkVycm9ycyA9PT0gbnVsbCkgdkVycm9ycyA9IFtlcnJdO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIHZFcnJvcnMucHVzaChlcnIpO1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvcnMrKztcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDQgPSBlcnJvcnMgPT09IGVycnNfNDtcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgICAgICAgICAgICAgICAgdmFyIGVyciA9IHtcbiAgICAgICAgICAgICAgICAgICAgICAgICAga2V5d29yZDogJ3R5cGUnLFxuICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhUGF0aDogKGRhdGFQYXRoIHx8ICcnKSArICcuYmxhY2tsaXN0WycgKyBpMSArICddJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9ibGFja2xpc3QvaXRlbXMvYW55T2YvMS90eXBlJyxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdHlwZTogJ29iamVjdCdcbiAgICAgICAgICAgICAgICAgICAgICAgICAgfSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZTogJ3Nob3VsZCBiZSBvYmplY3QnXG4gICAgICAgICAgICAgICAgICAgICAgICB9O1xuICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZFcnJvcnMgPT09IG51bGwpIHZFcnJvcnMgPSBbZXJyXTtcbiAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgdkVycm9ycy5wdXNoKGVycik7XG4gICAgICAgICAgICAgICAgICAgICAgICBlcnJvcnMrKztcbiAgICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgICAgdmFyIHZhbGlkMyA9IGVycm9ycyA9PT0gZXJyc18zO1xuICAgICAgICAgICAgICAgICAgICAgIHZhbGlkMiA9IHZhbGlkMiB8fCB2YWxpZDM7XG4gICAgICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICAgICAgaWYgKCF2YWxpZDIpIHtcbiAgICAgICAgICAgICAgICAgICAgICB2YXIgZXJyID0ge1xuICAgICAgICAgICAgICAgICAgICAgICAga2V5d29yZDogJ2FueU9mJyxcbiAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5ibGFja2xpc3RbJyArIGkxICsgJ10nLFxuICAgICAgICAgICAgICAgICAgICAgICAgc2NoZW1hUGF0aDogJyMvcHJvcGVydGllcy9ibGFja2xpc3QvaXRlbXMvYW55T2YnLFxuICAgICAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7fSxcbiAgICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgbWF0Y2ggc29tZSBzY2hlbWEgaW4gYW55T2YnXG4gICAgICAgICAgICAgICAgICAgICAgfTtcbiAgICAgICAgICAgICAgICAgICAgICBpZiAodkVycm9ycyA9PT0gbnVsbCkgdkVycm9ycyA9IFtlcnJdO1xuICAgICAgICAgICAgICAgICAgICAgIGVsc2UgdkVycm9ycy5wdXNoKGVycik7XG4gICAgICAgICAgICAgICAgICAgICAgZXJyb3JzKys7XG4gICAgICAgICAgICAgICAgICAgICAgdmFsaWRhdGUuZXJyb3JzID0gdkVycm9ycztcbiAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICAgICAgZXJyb3JzID0gZXJyc19fMjtcbiAgICAgICAgICAgICAgICAgICAgICBpZiAodkVycm9ycyAhPT0gbnVsbCkge1xuICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVycnNfXzIpIHZFcnJvcnMubGVuZ3RoID0gZXJyc19fMjtcbiAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UgdkVycm9ycyA9IG51bGw7XG4gICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICB9XG4gICAgICAgICAgICAgICAgICAgIHZhciB2YWxpZDIgPSBlcnJvcnMgPT09IGVycnNfMjtcbiAgICAgICAgICAgICAgICAgICAgaWYgKCF2YWxpZDIpIGJyZWFrO1xuICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgICAgICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICAgICAgICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgICAgICAgICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgJy5ibGFja2xpc3QnLFxuICAgICAgICAgICAgICAgICAgICBzY2hlbWFQYXRoOiAnIy9wcm9wZXJ0aWVzL2JsYWNrbGlzdC90eXBlJyxcbiAgICAgICAgICAgICAgICAgICAgcGFyYW1zOiB7XG4gICAgICAgICAgICAgICAgICAgICAgdHlwZTogJ2FycmF5J1xuICAgICAgICAgICAgICAgICAgICB9LFxuICAgICAgICAgICAgICAgICAgICBtZXNzYWdlOiAnc2hvdWxkIGJlIGFycmF5J1xuICAgICAgICAgICAgICAgICAgfV07XG4gICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7XG4gICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgIHZhciB2YWxpZDEgPSBlcnJvcnMgPT09IGVycnNfMTtcbiAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgfVxuICAgIH0gZWxzZSB7XG4gICAgICB2YWxpZGF0ZS5lcnJvcnMgPSBbe1xuICAgICAgICBrZXl3b3JkOiAndHlwZScsXG4gICAgICAgIGRhdGFQYXRoOiAoZGF0YVBhdGggfHwgJycpICsgXCJcIixcbiAgICAgICAgc2NoZW1hUGF0aDogJyMvdHlwZScsXG4gICAgICAgIHBhcmFtczoge1xuICAgICAgICAgIHR5cGU6ICdvYmplY3QnXG4gICAgICAgIH0sXG4gICAgICAgIG1lc3NhZ2U6ICdzaG91bGQgYmUgb2JqZWN0J1xuICAgICAgfV07XG4gICAgICByZXR1cm4gZmFsc2U7XG4gICAgfVxuICAgIHZhbGlkYXRlLmVycm9ycyA9IHZFcnJvcnM7XG4gICAgcmV0dXJuIGVycm9ycyA9PT0gMDtcbiAgfTtcbn0pKCk7XG52YWxpZGF0ZS5zY2hlbWEgPSB7XG4gIFwidHlwZVwiOiBcIm9iamVjdFwiLFxuICBcInByb3BlcnRpZXNcIjoge1xuICAgIFwia2V5bWFwc1wiOiB7XG4gICAgICBcInR5cGVcIjogXCJvYmplY3RcIixcbiAgICAgIFwicGF0dGVyblByb3BlcnRpZXNcIjoge1xuICAgICAgICBcIi4qXCI6IHtcbiAgICAgICAgICBcInR5cGVcIjogXCJvYmplY3RcIixcbiAgICAgICAgICBcInByb3BlcnRpZXNcIjoge1xuICAgICAgICAgICAgXCJ0eXBlXCI6IHtcbiAgICAgICAgICAgICAgXCJ0eXBlXCI6IFwic3RyaW5nXCJcbiAgICAgICAgICAgIH1cbiAgICAgICAgICB9LFxuICAgICAgICAgIFwicmVxdWlyZWRcIjogW1widHlwZVwiXVxuICAgICAgICB9XG4gICAgICB9XG4gICAgfSxcbiAgICBcInNlYXJjaFwiOiB7XG4gICAgICBcInR5cGVcIjogXCJvYmplY3RcIixcbiAgICAgIFwicHJvcGVydGllc1wiOiB7XG4gICAgICAgIFwiZGVmYXVsdFwiOiB7XG4gICAgICAgICAgXCJ0eXBlXCI6IFwic3RyaW5nXCJcbiAgICAgICAgfSxcbiAgICAgICAgXCJlbmdpbmVzXCI6IHtcbiAgICAgICAgICBcInR5cGVcIjogXCJvYmplY3RcIixcbiAgICAgICAgICBcInBhdHRlcm5Qcm9wZXJ0aWVzXCI6IHtcbiAgICAgICAgICAgIFwiLipcIjoge1xuICAgICAgICAgICAgICBcInR5cGVcIjogXCJzdHJpbmdcIlxuICAgICAgICAgICAgfVxuICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgfSxcbiAgICAgIFwicmVxdWlyZWRcIjogW1wiZGVmYXVsdFwiLCBcImVuZ2luZXNcIl1cbiAgICB9LFxuICAgIFwicHJvcGVydGllc1wiOiB7XG4gICAgICBcInR5cGVcIjogXCJvYmplY3RcIixcbiAgICAgIFwicHJvcGVydGllc1wiOiB7XG4gICAgICAgIFwiaGludGNoYXJzXCI6IHtcbiAgICAgICAgICBcInR5cGVcIjogXCJzdHJpbmdcIlxuICAgICAgICB9LFxuICAgICAgICBcInNtb290aHNjcm9sbFwiOiB7XG4gICAgICAgICAgXCJ0eXBlXCI6IFwiYm9vbGVhblwiXG4gICAgICAgIH0sXG4gICAgICAgIFwiY29tcGxldGVcIjoge1xuICAgICAgICAgIFwidHlwZVwiOiBcInN0cmluZ1wiXG4gICAgICAgIH0sXG4gICAgICAgIFwiY29sb3JzY2hlbWVcIjoge1xuICAgICAgICAgIFwidHlwZVwiOiBcInN0cmluZ1wiLFxuICAgICAgICAgIFwiZW51bVwiOiBbXCJzeXN0ZW1cIiwgXCJsaWdodFwiLCBcImRhcmtcIl1cbiAgICAgICAgfVxuICAgICAgfVxuICAgIH0sXG4gICAgXCJibGFja2xpc3RcIjoge1xuICAgICAgXCJ0eXBlXCI6IFwiYXJyYXlcIixcbiAgICAgIFwiaXRlbXNcIjoge1xuICAgICAgICBcImFueU9mXCI6IFt7XG4gICAgICAgICAgXCJ0eXBlXCI6IFwic3RyaW5nXCJcbiAgICAgICAgfSwge1xuICAgICAgICAgIFwidHlwZVwiOiBcIm9iamVjdFwiLFxuICAgICAgICAgIFwicHJvcGVydGllc1wiOiB7XG4gICAgICAgICAgICBcInVybFwiOiB7XG4gICAgICAgICAgICAgIFwidHlwZVwiOiBcInN0cmluZ1wiXG4gICAgICAgICAgICB9LFxuICAgICAgICAgICAgXCJrZXlzXCI6IHtcbiAgICAgICAgICAgICAgXCJ0eXBlXCI6IFwiYXJyYXlcIixcbiAgICAgICAgICAgICAgXCJpdGVtc1wiOiB7XG4gICAgICAgICAgICAgICAgXCJ0eXBlXCI6IFwic3RyaW5nXCJcbiAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgfVxuICAgICAgICAgIH0sXG4gICAgICAgICAgXCJyZXF1aXJlZFwiOiBbXCJ1cmxcIiwgXCJrZXlzXCJdXG4gICAgICAgIH1dXG4gICAgICB9XG4gICAgfVxuICB9LFxuICBcImFkZGl0aW9uYWxQcm9wZXJ0aWVzXCI6IGZhbHNlXG59O1xudmFsaWRhdGUuZXJyb3JzID0gbnVsbDtcbm1vZHVsZS5leHBvcnRzID0gdmFsaWRhdGU7IiwiLy8gZG8gTk9UIHJlbW92ZSB0aGlzIGZpbGUgLSBpdCB3b3VsZCBicmVhayBwcmUtY29tcGlsZWQgc2NoZW1hc1xuLy8gaHR0cHM6Ly9naXRodWIuY29tL2Fqdi12YWxpZGF0b3IvYWp2L2lzc3Vlcy84ODlcbm1vZHVsZS5leHBvcnRzID0gcmVxdWlyZShcImZhc3QtZGVlcC1lcXVhbFwiKVxuIiwiJ3VzZSBzdHJpY3QnO1xuXG4vLyBkbyBub3QgZWRpdCAuanMgZmlsZXMgZGlyZWN0bHkgLSBlZGl0IHNyYy9pbmRleC5qc3RcblxuXG5cbm1vZHVsZS5leHBvcnRzID0gZnVuY3Rpb24gZXF1YWwoYSwgYikge1xuICBpZiAoYSA9PT0gYikgcmV0dXJuIHRydWU7XG5cbiAgaWYgKGEgJiYgYiAmJiB0eXBlb2YgYSA9PSAnb2JqZWN0JyAmJiB0eXBlb2YgYiA9PSAnb2JqZWN0Jykge1xuICAgIGlmIChhLmNvbnN0cnVjdG9yICE9PSBiLmNvbnN0cnVjdG9yKSByZXR1cm4gZmFsc2U7XG5cbiAgICB2YXIgbGVuZ3RoLCBpLCBrZXlzO1xuICAgIGlmIChBcnJheS5pc0FycmF5KGEpKSB7XG4gICAgICBsZW5ndGggPSBhLmxlbmd0aDtcbiAgICAgIGlmIChsZW5ndGggIT0gYi5sZW5ndGgpIHJldHVybiBmYWxzZTtcbiAgICAgIGZvciAoaSA9IGxlbmd0aDsgaS0tICE9PSAwOylcbiAgICAgICAgaWYgKCFlcXVhbChhW2ldLCBiW2ldKSkgcmV0dXJuIGZhbHNlO1xuICAgICAgcmV0dXJuIHRydWU7XG4gICAgfVxuXG5cblxuICAgIGlmIChhLmNvbnN0cnVjdG9yID09PSBSZWdFeHApIHJldHVybiBhLnNvdXJjZSA9PT0gYi5zb3VyY2UgJiYgYS5mbGFncyA9PT0gYi5mbGFncztcbiAgICBpZiAoYS52YWx1ZU9mICE9PSBPYmplY3QucHJvdG90eXBlLnZhbHVlT2YpIHJldHVybiBhLnZhbHVlT2YoKSA9PT0gYi52YWx1ZU9mKCk7XG4gICAgaWYgKGEudG9TdHJpbmcgIT09IE9iamVjdC5wcm90b3R5cGUudG9TdHJpbmcpIHJldHVybiBhLnRvU3RyaW5nKCkgPT09IGIudG9TdHJpbmcoKTtcblxuICAgIGtleXMgPSBPYmplY3Qua2V5cyhhKTtcbiAgICBsZW5ndGggPSBrZXlzLmxlbmd0aDtcbiAgICBpZiAobGVuZ3RoICE9PSBPYmplY3Qua2V5cyhiKS5sZW5ndGgpIHJldHVybiBmYWxzZTtcblxuICAgIGZvciAoaSA9IGxlbmd0aDsgaS0tICE9PSAwOylcbiAgICAgIGlmICghT2JqZWN0LnByb3RvdHlwZS5oYXNPd25Qcm9wZXJ0eS5jYWxsKGIsIGtleXNbaV0pKSByZXR1cm4gZmFsc2U7XG5cbiAgICBmb3IgKGkgPSBsZW5ndGg7IGktLSAhPT0gMDspIHtcbiAgICAgIHZhciBrZXkgPSBrZXlzW2ldO1xuXG4gICAgICBpZiAoIWVxdWFsKGFba2V5XSwgYltrZXldKSkgcmV0dXJuIGZhbHNlO1xuICAgIH1cblxuICAgIHJldHVybiB0cnVlO1xuICB9XG5cbiAgLy8gdHJ1ZSBpZiBib3RoIE5hTiwgZmFsc2Ugb3RoZXJ3aXNlXG4gIHJldHVybiBhIT09YSAmJiBiIT09Yjtcbn07XG4iLCJmdW5jdGlvbiBtZW1vaXplKGZuKSB7XG4gIHZhciBjYWNoZSA9IHt9O1xuICByZXR1cm4gZnVuY3Rpb24gKGFyZykge1xuICAgIGlmIChjYWNoZVthcmddID09PSB1bmRlZmluZWQpIGNhY2hlW2FyZ10gPSBmbihhcmcpO1xuICAgIHJldHVybiBjYWNoZVthcmddO1xuICB9O1xufVxuXG5leHBvcnQgZGVmYXVsdCBtZW1vaXplO1xuIiwiaW1wb3J0IG1lbW9pemUgZnJvbSAnQGVtb3Rpb24vbWVtb2l6ZSc7XG5cbnZhciByZWFjdFByb3BzUmVnZXggPSAvXigoY2hpbGRyZW58ZGFuZ2Vyb3VzbHlTZXRJbm5lckhUTUx8a2V5fHJlZnxhdXRvRm9jdXN8ZGVmYXVsdFZhbHVlfGRlZmF1bHRDaGVja2VkfGlubmVySFRNTHxzdXBwcmVzc0NvbnRlbnRFZGl0YWJsZVdhcm5pbmd8c3VwcHJlc3NIeWRyYXRpb25XYXJuaW5nfHZhbHVlTGlua3xhY2NlcHR8YWNjZXB0Q2hhcnNldHxhY2Nlc3NLZXl8YWN0aW9ufGFsbG93fGFsbG93VXNlck1lZGlhfGFsbG93UGF5bWVudFJlcXVlc3R8YWxsb3dGdWxsU2NyZWVufGFsbG93VHJhbnNwYXJlbmN5fGFsdHxhc3luY3xhdXRvQ29tcGxldGV8YXV0b1BsYXl8Y2FwdHVyZXxjZWxsUGFkZGluZ3xjZWxsU3BhY2luZ3xjaGFsbGVuZ2V8Y2hhclNldHxjaGVja2VkfGNpdGV8Y2xhc3NJRHxjbGFzc05hbWV8Y29sc3xjb2xTcGFufGNvbnRlbnR8Y29udGVudEVkaXRhYmxlfGNvbnRleHRNZW51fGNvbnRyb2xzfGNvbnRyb2xzTGlzdHxjb29yZHN8Y3Jvc3NPcmlnaW58ZGF0YXxkYXRlVGltZXxkZWNvZGluZ3xkZWZhdWx0fGRlZmVyfGRpcnxkaXNhYmxlZHxkaXNhYmxlUGljdHVyZUluUGljdHVyZXxkb3dubG9hZHxkcmFnZ2FibGV8ZW5jVHlwZXxmb3JtfGZvcm1BY3Rpb258Zm9ybUVuY1R5cGV8Zm9ybU1ldGhvZHxmb3JtTm9WYWxpZGF0ZXxmb3JtVGFyZ2V0fGZyYW1lQm9yZGVyfGhlYWRlcnN8aGVpZ2h0fGhpZGRlbnxoaWdofGhyZWZ8aHJlZkxhbmd8aHRtbEZvcnxodHRwRXF1aXZ8aWR8aW5wdXRNb2RlfGludGVncml0eXxpc3xrZXlQYXJhbXN8a2V5VHlwZXxraW5kfGxhYmVsfGxhbmd8bGlzdHxsb2FkaW5nfGxvb3B8bG93fG1hcmdpbkhlaWdodHxtYXJnaW5XaWR0aHxtYXh8bWF4TGVuZ3RofG1lZGlhfG1lZGlhR3JvdXB8bWV0aG9kfG1pbnxtaW5MZW5ndGh8bXVsdGlwbGV8bXV0ZWR8bmFtZXxub25jZXxub1ZhbGlkYXRlfG9wZW58b3B0aW11bXxwYXR0ZXJufHBsYWNlaG9sZGVyfHBsYXlzSW5saW5lfHBvc3RlcnxwcmVsb2FkfHByb2ZpbGV8cmFkaW9Hcm91cHxyZWFkT25seXxyZWZlcnJlclBvbGljeXxyZWx8cmVxdWlyZWR8cmV2ZXJzZWR8cm9sZXxyb3dzfHJvd1NwYW58c2FuZGJveHxzY29wZXxzY29wZWR8c2Nyb2xsaW5nfHNlYW1sZXNzfHNlbGVjdGVkfHNoYXBlfHNpemV8c2l6ZXN8c2xvdHxzcGFufHNwZWxsQ2hlY2t8c3JjfHNyY0RvY3xzcmNMYW5nfHNyY1NldHxzdGFydHxzdGVwfHN0eWxlfHN1bW1hcnl8dGFiSW5kZXh8dGFyZ2V0fHRpdGxlfHR5cGV8dXNlTWFwfHZhbHVlfHdpZHRofHdtb2RlfHdyYXB8YWJvdXR8ZGF0YXR5cGV8aW5saXN0fHByZWZpeHxwcm9wZXJ0eXxyZXNvdXJjZXx0eXBlb2Z8dm9jYWJ8YXV0b0NhcGl0YWxpemV8YXV0b0NvcnJlY3R8YXV0b1NhdmV8Y29sb3J8aW5lcnR8aXRlbVByb3B8aXRlbVNjb3BlfGl0ZW1UeXBlfGl0ZW1JRHxpdGVtUmVmfG9ufHJlc3VsdHN8c2VjdXJpdHl8dW5zZWxlY3RhYmxlfGFjY2VudEhlaWdodHxhY2N1bXVsYXRlfGFkZGl0aXZlfGFsaWdubWVudEJhc2VsaW5lfGFsbG93UmVvcmRlcnxhbHBoYWJldGljfGFtcGxpdHVkZXxhcmFiaWNGb3JtfGFzY2VudHxhdHRyaWJ1dGVOYW1lfGF0dHJpYnV0ZVR5cGV8YXV0b1JldmVyc2V8YXppbXV0aHxiYXNlRnJlcXVlbmN5fGJhc2VsaW5lU2hpZnR8YmFzZVByb2ZpbGV8YmJveHxiZWdpbnxiaWFzfGJ5fGNhbGNNb2RlfGNhcEhlaWdodHxjbGlwfGNsaXBQYXRoVW5pdHN8Y2xpcFBhdGh8Y2xpcFJ1bGV8Y29sb3JJbnRlcnBvbGF0aW9ufGNvbG9ySW50ZXJwb2xhdGlvbkZpbHRlcnN8Y29sb3JQcm9maWxlfGNvbG9yUmVuZGVyaW5nfGNvbnRlbnRTY3JpcHRUeXBlfGNvbnRlbnRTdHlsZVR5cGV8Y3Vyc29yfGN4fGN5fGR8ZGVjZWxlcmF0ZXxkZXNjZW50fGRpZmZ1c2VDb25zdGFudHxkaXJlY3Rpb258ZGlzcGxheXxkaXZpc29yfGRvbWluYW50QmFzZWxpbmV8ZHVyfGR4fGR5fGVkZ2VNb2RlfGVsZXZhdGlvbnxlbmFibGVCYWNrZ3JvdW5kfGVuZHxleHBvbmVudHxleHRlcm5hbFJlc291cmNlc1JlcXVpcmVkfGZpbGx8ZmlsbE9wYWNpdHl8ZmlsbFJ1bGV8ZmlsdGVyfGZpbHRlclJlc3xmaWx0ZXJVbml0c3xmbG9vZENvbG9yfGZsb29kT3BhY2l0eXxmb2N1c2FibGV8Zm9udEZhbWlseXxmb250U2l6ZXxmb250U2l6ZUFkanVzdHxmb250U3RyZXRjaHxmb250U3R5bGV8Zm9udFZhcmlhbnR8Zm9udFdlaWdodHxmb3JtYXR8ZnJvbXxmcnxmeHxmeXxnMXxnMnxnbHlwaE5hbWV8Z2x5cGhPcmllbnRhdGlvbkhvcml6b250YWx8Z2x5cGhPcmllbnRhdGlvblZlcnRpY2FsfGdseXBoUmVmfGdyYWRpZW50VHJhbnNmb3JtfGdyYWRpZW50VW5pdHN8aGFuZ2luZ3xob3JpekFkdlh8aG9yaXpPcmlnaW5YfGlkZW9ncmFwaGljfGltYWdlUmVuZGVyaW5nfGlufGluMnxpbnRlcmNlcHR8a3xrMXxrMnxrM3xrNHxrZXJuZWxNYXRyaXh8a2VybmVsVW5pdExlbmd0aHxrZXJuaW5nfGtleVBvaW50c3xrZXlTcGxpbmVzfGtleVRpbWVzfGxlbmd0aEFkanVzdHxsZXR0ZXJTcGFjaW5nfGxpZ2h0aW5nQ29sb3J8bGltaXRpbmdDb25lQW5nbGV8bG9jYWx8bWFya2VyRW5kfG1hcmtlck1pZHxtYXJrZXJTdGFydHxtYXJrZXJIZWlnaHR8bWFya2VyVW5pdHN8bWFya2VyV2lkdGh8bWFza3xtYXNrQ29udGVudFVuaXRzfG1hc2tVbml0c3xtYXRoZW1hdGljYWx8bW9kZXxudW1PY3RhdmVzfG9mZnNldHxvcGFjaXR5fG9wZXJhdG9yfG9yZGVyfG9yaWVudHxvcmllbnRhdGlvbnxvcmlnaW58b3ZlcmZsb3d8b3ZlcmxpbmVQb3NpdGlvbnxvdmVybGluZVRoaWNrbmVzc3xwYW5vc2UxfHBhaW50T3JkZXJ8cGF0aExlbmd0aHxwYXR0ZXJuQ29udGVudFVuaXRzfHBhdHRlcm5UcmFuc2Zvcm18cGF0dGVyblVuaXRzfHBvaW50ZXJFdmVudHN8cG9pbnRzfHBvaW50c0F0WHxwb2ludHNBdFl8cG9pbnRzQXRafHByZXNlcnZlQWxwaGF8cHJlc2VydmVBc3BlY3RSYXRpb3xwcmltaXRpdmVVbml0c3xyfHJhZGl1c3xyZWZYfHJlZll8cmVuZGVyaW5nSW50ZW50fHJlcGVhdENvdW50fHJlcGVhdER1cnxyZXF1aXJlZEV4dGVuc2lvbnN8cmVxdWlyZWRGZWF0dXJlc3xyZXN0YXJ0fHJlc3VsdHxyb3RhdGV8cnh8cnl8c2NhbGV8c2VlZHxzaGFwZVJlbmRlcmluZ3xzbG9wZXxzcGFjaW5nfHNwZWN1bGFyQ29uc3RhbnR8c3BlY3VsYXJFeHBvbmVudHxzcGVlZHxzcHJlYWRNZXRob2R8c3RhcnRPZmZzZXR8c3RkRGV2aWF0aW9ufHN0ZW1ofHN0ZW12fHN0aXRjaFRpbGVzfHN0b3BDb2xvcnxzdG9wT3BhY2l0eXxzdHJpa2V0aHJvdWdoUG9zaXRpb258c3RyaWtldGhyb3VnaFRoaWNrbmVzc3xzdHJpbmd8c3Ryb2tlfHN0cm9rZURhc2hhcnJheXxzdHJva2VEYXNob2Zmc2V0fHN0cm9rZUxpbmVjYXB8c3Ryb2tlTGluZWpvaW58c3Ryb2tlTWl0ZXJsaW1pdHxzdHJva2VPcGFjaXR5fHN0cm9rZVdpZHRofHN1cmZhY2VTY2FsZXxzeXN0ZW1MYW5ndWFnZXx0YWJsZVZhbHVlc3x0YXJnZXRYfHRhcmdldFl8dGV4dEFuY2hvcnx0ZXh0RGVjb3JhdGlvbnx0ZXh0UmVuZGVyaW5nfHRleHRMZW5ndGh8dG98dHJhbnNmb3JtfHUxfHUyfHVuZGVybGluZVBvc2l0aW9ufHVuZGVybGluZVRoaWNrbmVzc3x1bmljb2RlfHVuaWNvZGVCaWRpfHVuaWNvZGVSYW5nZXx1bml0c1BlckVtfHZBbHBoYWJldGljfHZIYW5naW5nfHZJZGVvZ3JhcGhpY3x2TWF0aGVtYXRpY2FsfHZhbHVlc3x2ZWN0b3JFZmZlY3R8dmVyc2lvbnx2ZXJ0QWR2WXx2ZXJ0T3JpZ2luWHx2ZXJ0T3JpZ2luWXx2aWV3Qm94fHZpZXdUYXJnZXR8dmlzaWJpbGl0eXx3aWR0aHN8d29yZFNwYWNpbmd8d3JpdGluZ01vZGV8eHx4SGVpZ2h0fHgxfHgyfHhDaGFubmVsU2VsZWN0b3J8eGxpbmtBY3R1YXRlfHhsaW5rQXJjcm9sZXx4bGlua0hyZWZ8eGxpbmtSb2xlfHhsaW5rU2hvd3x4bGlua1RpdGxlfHhsaW5rVHlwZXx4bWxCYXNlfHhtbG5zfHhtbG5zWGxpbmt8eG1sTGFuZ3x4bWxTcGFjZXx5fHkxfHkyfHlDaGFubmVsU2VsZWN0b3J8enx6b29tQW5kUGFufGZvcnxjbGFzc3xhdXRvZm9jdXMpfCgoW0RkXVtBYV1bVHRdW0FhXXxbQWFdW1JyXVtJaV1bQWFdfHgpLS4qKSkkLzsgLy8gaHR0cHM6Ly9lc2JlbmNoLmNvbS9iZW5jaC81YmZlZTY4YTRjZDdlNjAwOWVmNjFkMjNcblxudmFyIGluZGV4ID0gbWVtb2l6ZShmdW5jdGlvbiAocHJvcCkge1xuICByZXR1cm4gcmVhY3RQcm9wc1JlZ2V4LnRlc3QocHJvcCkgfHwgcHJvcC5jaGFyQ29kZUF0KDApID09PSAxMTFcbiAgLyogbyAqL1xuICAmJiBwcm9wLmNoYXJDb2RlQXQoMSkgPT09IDExMFxuICAvKiBuICovXG4gICYmIHByb3AuY2hhckNvZGVBdCgyKSA8IDkxO1xufVxuLyogWisxICovXG4pO1xuXG5leHBvcnQgZGVmYXVsdCBpbmRleDtcbiIsIi8qXG5vYmplY3QtYXNzaWduXG4oYykgU2luZHJlIFNvcmh1c1xuQGxpY2Vuc2UgTUlUXG4qL1xuXG4ndXNlIHN0cmljdCc7XG4vKiBlc2xpbnQtZGlzYWJsZSBuby11bnVzZWQtdmFycyAqL1xudmFyIGdldE93blByb3BlcnR5U3ltYm9scyA9IE9iamVjdC5nZXRPd25Qcm9wZXJ0eVN5bWJvbHM7XG52YXIgaGFzT3duUHJvcGVydHkgPSBPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5O1xudmFyIHByb3BJc0VudW1lcmFibGUgPSBPYmplY3QucHJvdG90eXBlLnByb3BlcnR5SXNFbnVtZXJhYmxlO1xuXG5mdW5jdGlvbiB0b09iamVjdCh2YWwpIHtcblx0aWYgKHZhbCA9PT0gbnVsbCB8fCB2YWwgPT09IHVuZGVmaW5lZCkge1xuXHRcdHRocm93IG5ldyBUeXBlRXJyb3IoJ09iamVjdC5hc3NpZ24gY2Fubm90IGJlIGNhbGxlZCB3aXRoIG51bGwgb3IgdW5kZWZpbmVkJyk7XG5cdH1cblxuXHRyZXR1cm4gT2JqZWN0KHZhbCk7XG59XG5cbmZ1bmN0aW9uIHNob3VsZFVzZU5hdGl2ZSgpIHtcblx0dHJ5IHtcblx0XHRpZiAoIU9iamVjdC5hc3NpZ24pIHtcblx0XHRcdHJldHVybiBmYWxzZTtcblx0XHR9XG5cblx0XHQvLyBEZXRlY3QgYnVnZ3kgcHJvcGVydHkgZW51bWVyYXRpb24gb3JkZXIgaW4gb2xkZXIgVjggdmVyc2lvbnMuXG5cblx0XHQvLyBodHRwczovL2J1Z3MuY2hyb21pdW0ub3JnL3AvdjgvaXNzdWVzL2RldGFpbD9pZD00MTE4XG5cdFx0dmFyIHRlc3QxID0gbmV3IFN0cmluZygnYWJjJyk7ICAvLyBlc2xpbnQtZGlzYWJsZS1saW5lIG5vLW5ldy13cmFwcGVyc1xuXHRcdHRlc3QxWzVdID0gJ2RlJztcblx0XHRpZiAoT2JqZWN0LmdldE93blByb3BlcnR5TmFtZXModGVzdDEpWzBdID09PSAnNScpIHtcblx0XHRcdHJldHVybiBmYWxzZTtcblx0XHR9XG5cblx0XHQvLyBodHRwczovL2J1Z3MuY2hyb21pdW0ub3JnL3AvdjgvaXNzdWVzL2RldGFpbD9pZD0zMDU2XG5cdFx0dmFyIHRlc3QyID0ge307XG5cdFx0Zm9yICh2YXIgaSA9IDA7IGkgPCAxMDsgaSsrKSB7XG5cdFx0XHR0ZXN0MlsnXycgKyBTdHJpbmcuZnJvbUNoYXJDb2RlKGkpXSA9IGk7XG5cdFx0fVxuXHRcdHZhciBvcmRlcjIgPSBPYmplY3QuZ2V0T3duUHJvcGVydHlOYW1lcyh0ZXN0MikubWFwKGZ1bmN0aW9uIChuKSB7XG5cdFx0XHRyZXR1cm4gdGVzdDJbbl07XG5cdFx0fSk7XG5cdFx0aWYgKG9yZGVyMi5qb2luKCcnKSAhPT0gJzAxMjM0NTY3ODknKSB7XG5cdFx0XHRyZXR1cm4gZmFsc2U7XG5cdFx0fVxuXG5cdFx0Ly8gaHR0cHM6Ly9idWdzLmNocm9taXVtLm9yZy9wL3Y4L2lzc3Vlcy9kZXRhaWw/aWQ9MzA1NlxuXHRcdHZhciB0ZXN0MyA9IHt9O1xuXHRcdCdhYmNkZWZnaGlqa2xtbm9wcXJzdCcuc3BsaXQoJycpLmZvckVhY2goZnVuY3Rpb24gKGxldHRlcikge1xuXHRcdFx0dGVzdDNbbGV0dGVyXSA9IGxldHRlcjtcblx0XHR9KTtcblx0XHRpZiAoT2JqZWN0LmtleXMoT2JqZWN0LmFzc2lnbih7fSwgdGVzdDMpKS5qb2luKCcnKSAhPT1cblx0XHRcdFx0J2FiY2RlZmdoaWprbG1ub3BxcnN0Jykge1xuXHRcdFx0cmV0dXJuIGZhbHNlO1xuXHRcdH1cblxuXHRcdHJldHVybiB0cnVlO1xuXHR9IGNhdGNoIChlcnIpIHtcblx0XHQvLyBXZSBkb24ndCBleHBlY3QgYW55IG9mIHRoZSBhYm92ZSB0byB0aHJvdywgYnV0IGJldHRlciB0byBiZSBzYWZlLlxuXHRcdHJldHVybiBmYWxzZTtcblx0fVxufVxuXG5tb2R1bGUuZXhwb3J0cyA9IHNob3VsZFVzZU5hdGl2ZSgpID8gT2JqZWN0LmFzc2lnbiA6IGZ1bmN0aW9uICh0YXJnZXQsIHNvdXJjZSkge1xuXHR2YXIgZnJvbTtcblx0dmFyIHRvID0gdG9PYmplY3QodGFyZ2V0KTtcblx0dmFyIHN5bWJvbHM7XG5cblx0Zm9yICh2YXIgcyA9IDE7IHMgPCBhcmd1bWVudHMubGVuZ3RoOyBzKyspIHtcblx0XHRmcm9tID0gT2JqZWN0KGFyZ3VtZW50c1tzXSk7XG5cblx0XHRmb3IgKHZhciBrZXkgaW4gZnJvbSkge1xuXHRcdFx0aWYgKGhhc093blByb3BlcnR5LmNhbGwoZnJvbSwga2V5KSkge1xuXHRcdFx0XHR0b1trZXldID0gZnJvbVtrZXldO1xuXHRcdFx0fVxuXHRcdH1cblxuXHRcdGlmIChnZXRPd25Qcm9wZXJ0eVN5bWJvbHMpIHtcblx0XHRcdHN5bWJvbHMgPSBnZXRPd25Qcm9wZXJ0eVN5bWJvbHMoZnJvbSk7XG5cdFx0XHRmb3IgKHZhciBpID0gMDsgaSA8IHN5bWJvbHMubGVuZ3RoOyBpKyspIHtcblx0XHRcdFx0aWYgKHByb3BJc0VudW1lcmFibGUuY2FsbChmcm9tLCBzeW1ib2xzW2ldKSkge1xuXHRcdFx0XHRcdHRvW3N5bWJvbHNbaV1dID0gZnJvbVtzeW1ib2xzW2ldXTtcblx0XHRcdFx0fVxuXHRcdFx0fVxuXHRcdH1cblx0fVxuXG5cdHJldHVybiB0bztcbn07XG4iLCIndXNlIHN0cmljdCc7XG5cbmZ1bmN0aW9uIGNoZWNrRENFKCkge1xuICAvKiBnbG9iYWwgX19SRUFDVF9ERVZUT09MU19HTE9CQUxfSE9PS19fICovXG4gIGlmIChcbiAgICB0eXBlb2YgX19SRUFDVF9ERVZUT09MU19HTE9CQUxfSE9PS19fID09PSAndW5kZWZpbmVkJyB8fFxuICAgIHR5cGVvZiBfX1JFQUNUX0RFVlRPT0xTX0dMT0JBTF9IT09LX18uY2hlY2tEQ0UgIT09ICdmdW5jdGlvbidcbiAgKSB7XG4gICAgcmV0dXJuO1xuICB9XG4gIGlmIChwcm9jZXNzLmVudi5OT0RFX0VOViAhPT0gJ3Byb2R1Y3Rpb24nKSB7XG4gICAgLy8gVGhpcyBicmFuY2ggaXMgdW5yZWFjaGFibGUgYmVjYXVzZSB0aGlzIGZ1bmN0aW9uIGlzIG9ubHkgY2FsbGVkXG4gICAgLy8gaW4gcHJvZHVjdGlvbiwgYnV0IHRoZSBjb25kaXRpb24gaXMgdHJ1ZSBvbmx5IGluIGRldmVsb3BtZW50LlxuICAgIC8vIFRoZXJlZm9yZSBpZiB0aGUgYnJhbmNoIGlzIHN0aWxsIGhlcmUsIGRlYWQgY29kZSBlbGltaW5hdGlvbiB3YXNuJ3RcbiAgICAvLyBwcm9wZXJseSBhcHBsaWVkLlxuICAgIC8vIERvbid0IGNoYW5nZSB0aGUgbWVzc2FnZS4gUmVhY3QgRGV2VG9vbHMgcmVsaWVzIG9uIGl0LiBBbHNvIG1ha2Ugc3VyZVxuICAgIC8vIHRoaXMgbWVzc2FnZSBkb2Vzbid0IG9jY3VyIGVsc2V3aGVyZSBpbiB0aGlzIGZ1bmN0aW9uLCBvciBpdCB3aWxsIGNhdXNlXG4gICAgLy8gYSBmYWxzZSBwb3NpdGl2ZS5cbiAgICB0aHJvdyBuZXcgRXJyb3IoJ15fXicpO1xuICB9XG4gIHRyeSB7XG4gICAgLy8gVmVyaWZ5IHRoYXQgdGhlIGNvZGUgYWJvdmUgaGFzIGJlZW4gZGVhZCBjb2RlIGVsaW1pbmF0ZWQgKERDRSdkKS5cbiAgICBfX1JFQUNUX0RFVlRPT0xTX0dMT0JBTF9IT09LX18uY2hlY2tEQ0UoY2hlY2tEQ0UpO1xuICB9IGNhdGNoIChlcnIpIHtcbiAgICAvLyBEZXZUb29scyBzaG91bGRuJ3QgY3Jhc2ggUmVhY3QsIG5vIG1hdHRlciB3aGF0LlxuICAgIC8vIFdlIHNob3VsZCBzdGlsbCByZXBvcnQgaW4gY2FzZSB3ZSBicmVhayB0aGlzIGNvZGUuXG4gICAgY29uc29sZS5lcnJvcihlcnIpO1xuICB9XG59XG5cbmlmIChwcm9jZXNzLmVudi5OT0RFX0VOViA9PT0gJ3Byb2R1Y3Rpb24nKSB7XG4gIC8vIERDRSBjaGVjayBzaG91bGQgaGFwcGVuIGJlZm9yZSBSZWFjdERPTSBidW5kbGUgZXhlY3V0ZXMgc28gdGhhdFxuICAvLyBEZXZUb29scyBjYW4gcmVwb3J0IGJhZCBtaW5pZmljYXRpb24gZHVyaW5nIGluamVjdGlvbi5cbiAgY2hlY2tEQ0UoKTtcbiAgbW9kdWxlLmV4cG9ydHMgPSByZXF1aXJlKCcuL2Nqcy9yZWFjdC1kb20ucHJvZHVjdGlvbi5taW4uanMnKTtcbn0gZWxzZSB7XG4gIG1vZHVsZS5leHBvcnRzID0gcmVxdWlyZSgnLi9janMvcmVhY3QtZG9tLmRldmVsb3BtZW50LmpzJyk7XG59XG4iLCJpbXBvcnQgYmFzZVN0eWxlZCwgeyBUaGVtZWRTdHlsZWRJbnRlcmZhY2UgfSBmcm9tIFwic3R5bGVkLWNvbXBvbmVudHNcIjtcbmltcG9ydCB7IFRoZW1lUHJvcGVydGllcyB9IGZyb20gXCIuL3RoZW1lXCI7XG5cbmNvbnN0IHN0eWxlZCA9IGJhc2VTdHlsZWQgYXMgVGhlbWVkU3R5bGVkSW50ZXJmYWNlPFRoZW1lUHJvcGVydGllcz47XG5cbmV4cG9ydCBkZWZhdWx0IHN0eWxlZDtcbiIsIi8vXG5cbm1vZHVsZS5leHBvcnRzID0gZnVuY3Rpb24gc2hhbGxvd0VxdWFsKG9iakEsIG9iakIsIGNvbXBhcmUsIGNvbXBhcmVDb250ZXh0KSB7XG4gIHZhciByZXQgPSBjb21wYXJlID8gY29tcGFyZS5jYWxsKGNvbXBhcmVDb250ZXh0LCBvYmpBLCBvYmpCKSA6IHZvaWQgMDtcblxuICBpZiAocmV0ICE9PSB2b2lkIDApIHtcbiAgICByZXR1cm4gISFyZXQ7XG4gIH1cblxuICBpZiAob2JqQSA9PT0gb2JqQikge1xuICAgIHJldHVybiB0cnVlO1xuICB9XG5cbiAgaWYgKHR5cGVvZiBvYmpBICE9PSBcIm9iamVjdFwiIHx8ICFvYmpBIHx8IHR5cGVvZiBvYmpCICE9PSBcIm9iamVjdFwiIHx8ICFvYmpCKSB7XG4gICAgcmV0dXJuIGZhbHNlO1xuICB9XG5cbiAgdmFyIGtleXNBID0gT2JqZWN0LmtleXMob2JqQSk7XG4gIHZhciBrZXlzQiA9IE9iamVjdC5rZXlzKG9iakIpO1xuXG4gIGlmIChrZXlzQS5sZW5ndGggIT09IGtleXNCLmxlbmd0aCkge1xuICAgIHJldHVybiBmYWxzZTtcbiAgfVxuXG4gIHZhciBiSGFzT3duUHJvcGVydHkgPSBPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmJpbmQob2JqQik7XG5cbiAgLy8gVGVzdCBmb3IgQSdzIGtleXMgZGlmZmVyZW50IGZyb20gQi5cbiAgZm9yICh2YXIgaWR4ID0gMDsgaWR4IDwga2V5c0EubGVuZ3RoOyBpZHgrKykge1xuICAgIHZhciBrZXkgPSBrZXlzQVtpZHhdO1xuXG4gICAgaWYgKCFiSGFzT3duUHJvcGVydHkoa2V5KSkge1xuICAgICAgcmV0dXJuIGZhbHNlO1xuICAgIH1cblxuICAgIHZhciB2YWx1ZUEgPSBvYmpBW2tleV07XG4gICAgdmFyIHZhbHVlQiA9IG9iakJba2V5XTtcblxuICAgIHJldCA9IGNvbXBhcmUgPyBjb21wYXJlLmNhbGwoY29tcGFyZUNvbnRleHQsIHZhbHVlQSwgdmFsdWVCLCBrZXkpIDogdm9pZCAwO1xuXG4gICAgaWYgKHJldCA9PT0gZmFsc2UgfHwgKHJldCA9PT0gdm9pZCAwICYmIHZhbHVlQSAhPT0gdmFsdWVCKSkge1xuICAgICAgcmV0dXJuIGZhbHNlO1xuICAgIH1cbiAgfVxuXG4gIHJldHVybiB0cnVlO1xufTtcbiIsImZ1bmN0aW9uIHN0eWxpc19taW4gKFcpIHtcbiAgZnVuY3Rpb24gTShkLCBjLCBlLCBoLCBhKSB7XG4gICAgZm9yICh2YXIgbSA9IDAsIGIgPSAwLCB2ID0gMCwgbiA9IDAsIHEsIGcsIHggPSAwLCBLID0gMCwgaywgdSA9IGsgPSBxID0gMCwgbCA9IDAsIHIgPSAwLCBJID0gMCwgdCA9IDAsIEIgPSBlLmxlbmd0aCwgSiA9IEIgLSAxLCB5LCBmID0gJycsIHAgPSAnJywgRiA9ICcnLCBHID0gJycsIEM7IGwgPCBCOykge1xuICAgICAgZyA9IGUuY2hhckNvZGVBdChsKTtcbiAgICAgIGwgPT09IEogJiYgMCAhPT0gYiArIG4gKyB2ICsgbSAmJiAoMCAhPT0gYiAmJiAoZyA9IDQ3ID09PSBiID8gMTAgOiA0NyksIG4gPSB2ID0gbSA9IDAsIEIrKywgSisrKTtcblxuICAgICAgaWYgKDAgPT09IGIgKyBuICsgdiArIG0pIHtcbiAgICAgICAgaWYgKGwgPT09IEogJiYgKDAgPCByICYmIChmID0gZi5yZXBsYWNlKE4sICcnKSksIDAgPCBmLnRyaW0oKS5sZW5ndGgpKSB7XG4gICAgICAgICAgc3dpdGNoIChnKSB7XG4gICAgICAgICAgICBjYXNlIDMyOlxuICAgICAgICAgICAgY2FzZSA5OlxuICAgICAgICAgICAgY2FzZSA1OTpcbiAgICAgICAgICAgIGNhc2UgMTM6XG4gICAgICAgICAgICBjYXNlIDEwOlxuICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgZGVmYXVsdDpcbiAgICAgICAgICAgICAgZiArPSBlLmNoYXJBdChsKTtcbiAgICAgICAgICB9XG5cbiAgICAgICAgICBnID0gNTk7XG4gICAgICAgIH1cblxuICAgICAgICBzd2l0Y2ggKGcpIHtcbiAgICAgICAgICBjYXNlIDEyMzpcbiAgICAgICAgICAgIGYgPSBmLnRyaW0oKTtcbiAgICAgICAgICAgIHEgPSBmLmNoYXJDb2RlQXQoMCk7XG4gICAgICAgICAgICBrID0gMTtcblxuICAgICAgICAgICAgZm9yICh0ID0gKytsOyBsIDwgQjspIHtcbiAgICAgICAgICAgICAgc3dpdGNoIChnID0gZS5jaGFyQ29kZUF0KGwpKSB7XG4gICAgICAgICAgICAgICAgY2FzZSAxMjM6XG4gICAgICAgICAgICAgICAgICBrKys7XG4gICAgICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgICAgIGNhc2UgMTI1OlxuICAgICAgICAgICAgICAgICAgay0tO1xuICAgICAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgICAgICBjYXNlIDQ3OlxuICAgICAgICAgICAgICAgICAgc3dpdGNoIChnID0gZS5jaGFyQ29kZUF0KGwgKyAxKSkge1xuICAgICAgICAgICAgICAgICAgICBjYXNlIDQyOlxuICAgICAgICAgICAgICAgICAgICBjYXNlIDQ3OlxuICAgICAgICAgICAgICAgICAgICAgIGE6IHtcbiAgICAgICAgICAgICAgICAgICAgICAgIGZvciAodSA9IGwgKyAxOyB1IDwgSjsgKyt1KSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgIHN3aXRjaCAoZS5jaGFyQ29kZUF0KHUpKSB7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSA0NzpcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICg0MiA9PT0gZyAmJiA0MiA9PT0gZS5jaGFyQ29kZUF0KHUgLSAxKSAmJiBsICsgMiAhPT0gdSkge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsID0gdSArIDE7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrIGE7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9XG5cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSAxMDpcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICg0NyA9PT0gZykge1xuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsID0gdSArIDE7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrIGE7XG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9XG5cbiAgICAgICAgICAgICAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgICAgICAgICAgICBsID0gdTtcbiAgICAgICAgICAgICAgICAgICAgICB9XG5cbiAgICAgICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgICAgICBjYXNlIDkxOlxuICAgICAgICAgICAgICAgICAgZysrO1xuXG4gICAgICAgICAgICAgICAgY2FzZSA0MDpcbiAgICAgICAgICAgICAgICAgIGcrKztcblxuICAgICAgICAgICAgICAgIGNhc2UgMzQ6XG4gICAgICAgICAgICAgICAgY2FzZSAzOTpcbiAgICAgICAgICAgICAgICAgIGZvciAoOyBsKysgPCBKICYmIGUuY2hhckNvZGVBdChsKSAhPT0gZzspIHtcbiAgICAgICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICB9XG5cbiAgICAgICAgICAgICAgaWYgKDAgPT09IGspIGJyZWFrO1xuICAgICAgICAgICAgICBsKys7XG4gICAgICAgICAgICB9XG5cbiAgICAgICAgICAgIGsgPSBlLnN1YnN0cmluZyh0LCBsKTtcbiAgICAgICAgICAgIDAgPT09IHEgJiYgKHEgPSAoZiA9IGYucmVwbGFjZShjYSwgJycpLnRyaW0oKSkuY2hhckNvZGVBdCgwKSk7XG5cbiAgICAgICAgICAgIHN3aXRjaCAocSkge1xuICAgICAgICAgICAgICBjYXNlIDY0OlxuICAgICAgICAgICAgICAgIDAgPCByICYmIChmID0gZi5yZXBsYWNlKE4sICcnKSk7XG4gICAgICAgICAgICAgICAgZyA9IGYuY2hhckNvZGVBdCgxKTtcblxuICAgICAgICAgICAgICAgIHN3aXRjaCAoZykge1xuICAgICAgICAgICAgICAgICAgY2FzZSAxMDA6XG4gICAgICAgICAgICAgICAgICBjYXNlIDEwOTpcbiAgICAgICAgICAgICAgICAgIGNhc2UgMTE1OlxuICAgICAgICAgICAgICAgICAgY2FzZSA0NTpcbiAgICAgICAgICAgICAgICAgICAgciA9IGM7XG4gICAgICAgICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICAgICAgICBkZWZhdWx0OlxuICAgICAgICAgICAgICAgICAgICByID0gTztcbiAgICAgICAgICAgICAgICB9XG5cbiAgICAgICAgICAgICAgICBrID0gTShjLCByLCBrLCBnLCBhICsgMSk7XG4gICAgICAgICAgICAgICAgdCA9IGsubGVuZ3RoO1xuICAgICAgICAgICAgICAgIDAgPCBBICYmIChyID0gWChPLCBmLCBJKSwgQyA9IEgoMywgaywgciwgYywgRCwgeiwgdCwgZywgYSwgaCksIGYgPSByLmpvaW4oJycpLCB2b2lkIDAgIT09IEMgJiYgMCA9PT0gKHQgPSAoayA9IEMudHJpbSgpKS5sZW5ndGgpICYmIChnID0gMCwgayA9ICcnKSk7XG4gICAgICAgICAgICAgICAgaWYgKDAgPCB0KSBzd2l0Y2ggKGcpIHtcbiAgICAgICAgICAgICAgICAgIGNhc2UgMTE1OlxuICAgICAgICAgICAgICAgICAgICBmID0gZi5yZXBsYWNlKGRhLCBlYSk7XG5cbiAgICAgICAgICAgICAgICAgIGNhc2UgMTAwOlxuICAgICAgICAgICAgICAgICAgY2FzZSAxMDk6XG4gICAgICAgICAgICAgICAgICBjYXNlIDQ1OlxuICAgICAgICAgICAgICAgICAgICBrID0gZiArICd7JyArIGsgKyAnfSc7XG4gICAgICAgICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICAgICAgICBjYXNlIDEwNzpcbiAgICAgICAgICAgICAgICAgICAgZiA9IGYucmVwbGFjZShmYSwgJyQxICQyJyk7XG4gICAgICAgICAgICAgICAgICAgIGsgPSBmICsgJ3snICsgayArICd9JztcbiAgICAgICAgICAgICAgICAgICAgayA9IDEgPT09IHcgfHwgMiA9PT0gdyAmJiBMKCdAJyArIGssIDMpID8gJ0Atd2Via2l0LScgKyBrICsgJ0AnICsgayA6ICdAJyArIGs7XG4gICAgICAgICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICAgICAgICBkZWZhdWx0OlxuICAgICAgICAgICAgICAgICAgICBrID0gZiArIGssIDExMiA9PT0gaCAmJiAoayA9IChwICs9IGssICcnKSk7XG4gICAgICAgICAgICAgICAgfSBlbHNlIGsgPSAnJztcbiAgICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgICBkZWZhdWx0OlxuICAgICAgICAgICAgICAgIGsgPSBNKGMsIFgoYywgZiwgSSksIGssIGgsIGEgKyAxKTtcbiAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgRiArPSBrO1xuICAgICAgICAgICAgayA9IEkgPSByID0gdSA9IHEgPSAwO1xuICAgICAgICAgICAgZiA9ICcnO1xuICAgICAgICAgICAgZyA9IGUuY2hhckNvZGVBdCgrK2wpO1xuICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICBjYXNlIDEyNTpcbiAgICAgICAgICBjYXNlIDU5OlxuICAgICAgICAgICAgZiA9ICgwIDwgciA/IGYucmVwbGFjZShOLCAnJykgOiBmKS50cmltKCk7XG4gICAgICAgICAgICBpZiAoMSA8ICh0ID0gZi5sZW5ndGgpKSBzd2l0Y2ggKDAgPT09IHUgJiYgKHEgPSBmLmNoYXJDb2RlQXQoMCksIDQ1ID09PSBxIHx8IDk2IDwgcSAmJiAxMjMgPiBxKSAmJiAodCA9IChmID0gZi5yZXBsYWNlKCcgJywgJzonKSkubGVuZ3RoKSwgMCA8IEEgJiYgdm9pZCAwICE9PSAoQyA9IEgoMSwgZiwgYywgZCwgRCwgeiwgcC5sZW5ndGgsIGgsIGEsIGgpKSAmJiAwID09PSAodCA9IChmID0gQy50cmltKCkpLmxlbmd0aCkgJiYgKGYgPSAnXFx4MDBcXHgwMCcpLCBxID0gZi5jaGFyQ29kZUF0KDApLCBnID0gZi5jaGFyQ29kZUF0KDEpLCBxKSB7XG4gICAgICAgICAgICAgIGNhc2UgMDpcbiAgICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgICBjYXNlIDY0OlxuICAgICAgICAgICAgICAgIGlmICgxMDUgPT09IGcgfHwgOTkgPT09IGcpIHtcbiAgICAgICAgICAgICAgICAgIEcgKz0gZiArIGUuY2hhckF0KGwpO1xuICAgICAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICAgICAgfVxuXG4gICAgICAgICAgICAgIGRlZmF1bHQ6XG4gICAgICAgICAgICAgICAgNTggIT09IGYuY2hhckNvZGVBdCh0IC0gMSkgJiYgKHAgKz0gUChmLCBxLCBnLCBmLmNoYXJDb2RlQXQoMikpKTtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICAgIEkgPSByID0gdSA9IHEgPSAwO1xuICAgICAgICAgICAgZiA9ICcnO1xuICAgICAgICAgICAgZyA9IGUuY2hhckNvZGVBdCgrK2wpO1xuICAgICAgICB9XG4gICAgICB9XG5cbiAgICAgIHN3aXRjaCAoZykge1xuICAgICAgICBjYXNlIDEzOlxuICAgICAgICBjYXNlIDEwOlxuICAgICAgICAgIDQ3ID09PSBiID8gYiA9IDAgOiAwID09PSAxICsgcSAmJiAxMDcgIT09IGggJiYgMCA8IGYubGVuZ3RoICYmIChyID0gMSwgZiArPSAnXFx4MDAnKTtcbiAgICAgICAgICAwIDwgQSAqIFkgJiYgSCgwLCBmLCBjLCBkLCBELCB6LCBwLmxlbmd0aCwgaCwgYSwgaCk7XG4gICAgICAgICAgeiA9IDE7XG4gICAgICAgICAgRCsrO1xuICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgIGNhc2UgNTk6XG4gICAgICAgIGNhc2UgMTI1OlxuICAgICAgICAgIGlmICgwID09PSBiICsgbiArIHYgKyBtKSB7XG4gICAgICAgICAgICB6Kys7XG4gICAgICAgICAgICBicmVhaztcbiAgICAgICAgICB9XG5cbiAgICAgICAgZGVmYXVsdDpcbiAgICAgICAgICB6Kys7XG4gICAgICAgICAgeSA9IGUuY2hhckF0KGwpO1xuXG4gICAgICAgICAgc3dpdGNoIChnKSB7XG4gICAgICAgICAgICBjYXNlIDk6XG4gICAgICAgICAgICBjYXNlIDMyOlxuICAgICAgICAgICAgICBpZiAoMCA9PT0gbiArIG0gKyBiKSBzd2l0Y2ggKHgpIHtcbiAgICAgICAgICAgICAgICBjYXNlIDQ0OlxuICAgICAgICAgICAgICAgIGNhc2UgNTg6XG4gICAgICAgICAgICAgICAgY2FzZSA5OlxuICAgICAgICAgICAgICAgIGNhc2UgMzI6XG4gICAgICAgICAgICAgICAgICB5ID0gJyc7XG4gICAgICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgICAgIGRlZmF1bHQ6XG4gICAgICAgICAgICAgICAgICAzMiAhPT0gZyAmJiAoeSA9ICcgJyk7XG4gICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgIGNhc2UgMDpcbiAgICAgICAgICAgICAgeSA9ICdcXFxcMCc7XG4gICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICBjYXNlIDEyOlxuICAgICAgICAgICAgICB5ID0gJ1xcXFxmJztcbiAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgIGNhc2UgMTE6XG4gICAgICAgICAgICAgIHkgPSAnXFxcXHYnO1xuICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgY2FzZSAzODpcbiAgICAgICAgICAgICAgMCA9PT0gbiArIGIgKyBtICYmIChyID0gSSA9IDEsIHkgPSAnXFxmJyArIHkpO1xuICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgY2FzZSAxMDg6XG4gICAgICAgICAgICAgIGlmICgwID09PSBuICsgYiArIG0gKyBFICYmIDAgPCB1KSBzd2l0Y2ggKGwgLSB1KSB7XG4gICAgICAgICAgICAgICAgY2FzZSAyOlxuICAgICAgICAgICAgICAgICAgMTEyID09PSB4ICYmIDU4ID09PSBlLmNoYXJDb2RlQXQobCAtIDMpICYmIChFID0geCk7XG5cbiAgICAgICAgICAgICAgICBjYXNlIDg6XG4gICAgICAgICAgICAgICAgICAxMTEgPT09IEsgJiYgKEUgPSBLKTtcbiAgICAgICAgICAgICAgfVxuICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgY2FzZSA1ODpcbiAgICAgICAgICAgICAgMCA9PT0gbiArIGIgKyBtICYmICh1ID0gbCk7XG4gICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICBjYXNlIDQ0OlxuICAgICAgICAgICAgICAwID09PSBiICsgdiArIG4gKyBtICYmIChyID0gMSwgeSArPSAnXFxyJyk7XG4gICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICBjYXNlIDM0OlxuICAgICAgICAgICAgY2FzZSAzOTpcbiAgICAgICAgICAgICAgMCA9PT0gYiAmJiAobiA9IG4gPT09IGcgPyAwIDogMCA9PT0gbiA/IGcgOiBuKTtcbiAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgIGNhc2UgOTE6XG4gICAgICAgICAgICAgIDAgPT09IG4gKyBiICsgdiAmJiBtKys7XG4gICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICBjYXNlIDkzOlxuICAgICAgICAgICAgICAwID09PSBuICsgYiArIHYgJiYgbS0tO1xuICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgY2FzZSA0MTpcbiAgICAgICAgICAgICAgMCA9PT0gbiArIGIgKyBtICYmIHYtLTtcbiAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgIGNhc2UgNDA6XG4gICAgICAgICAgICAgIGlmICgwID09PSBuICsgYiArIG0pIHtcbiAgICAgICAgICAgICAgICBpZiAoMCA9PT0gcSkgc3dpdGNoICgyICogeCArIDMgKiBLKSB7XG4gICAgICAgICAgICAgICAgICBjYXNlIDUzMzpcbiAgICAgICAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgICAgICAgIGRlZmF1bHQ6XG4gICAgICAgICAgICAgICAgICAgIHEgPSAxO1xuICAgICAgICAgICAgICAgIH1cbiAgICAgICAgICAgICAgICB2Kys7XG4gICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgICAgY2FzZSA2NDpcbiAgICAgICAgICAgICAgMCA9PT0gYiArIHYgKyBuICsgbSArIHUgKyBrICYmIChrID0gMSk7XG4gICAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgICBjYXNlIDQyOlxuICAgICAgICAgICAgY2FzZSA0NzpcbiAgICAgICAgICAgICAgaWYgKCEoMCA8IG4gKyBtICsgdikpIHN3aXRjaCAoYikge1xuICAgICAgICAgICAgICAgIGNhc2UgMDpcbiAgICAgICAgICAgICAgICAgIHN3aXRjaCAoMiAqIGcgKyAzICogZS5jaGFyQ29kZUF0KGwgKyAxKSkge1xuICAgICAgICAgICAgICAgICAgICBjYXNlIDIzNTpcbiAgICAgICAgICAgICAgICAgICAgICBiID0gNDc7XG4gICAgICAgICAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgICAgICAgICAgY2FzZSAyMjA6XG4gICAgICAgICAgICAgICAgICAgICAgdCA9IGwsIGIgPSA0MjtcbiAgICAgICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICAgICAgICBjYXNlIDQyOlxuICAgICAgICAgICAgICAgICAgNDcgPT09IGcgJiYgNDIgPT09IHggJiYgdCArIDIgIT09IGwgJiYgKDMzID09PSBlLmNoYXJDb2RlQXQodCArIDIpICYmIChwICs9IGUuc3Vic3RyaW5nKHQsIGwgKyAxKSksIHkgPSAnJywgYiA9IDApO1xuICAgICAgICAgICAgICB9XG4gICAgICAgICAgfVxuXG4gICAgICAgICAgMCA9PT0gYiAmJiAoZiArPSB5KTtcbiAgICAgIH1cblxuICAgICAgSyA9IHg7XG4gICAgICB4ID0gZztcbiAgICAgIGwrKztcbiAgICB9XG5cbiAgICB0ID0gcC5sZW5ndGg7XG5cbiAgICBpZiAoMCA8IHQpIHtcbiAgICAgIHIgPSBjO1xuICAgICAgaWYgKDAgPCBBICYmIChDID0gSCgyLCBwLCByLCBkLCBELCB6LCB0LCBoLCBhLCBoKSwgdm9pZCAwICE9PSBDICYmIDAgPT09IChwID0gQykubGVuZ3RoKSkgcmV0dXJuIEcgKyBwICsgRjtcbiAgICAgIHAgPSByLmpvaW4oJywnKSArICd7JyArIHAgKyAnfSc7XG5cbiAgICAgIGlmICgwICE9PSB3ICogRSkge1xuICAgICAgICAyICE9PSB3IHx8IEwocCwgMikgfHwgKEUgPSAwKTtcblxuICAgICAgICBzd2l0Y2ggKEUpIHtcbiAgICAgICAgICBjYXNlIDExMTpcbiAgICAgICAgICAgIHAgPSBwLnJlcGxhY2UoaGEsICc6LW1vei0kMScpICsgcDtcbiAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgY2FzZSAxMTI6XG4gICAgICAgICAgICBwID0gcC5yZXBsYWNlKFEsICc6Oi13ZWJraXQtaW5wdXQtJDEnKSArIHAucmVwbGFjZShRLCAnOjotbW96LSQxJykgKyBwLnJlcGxhY2UoUSwgJzotbXMtaW5wdXQtJDEnKSArIHA7XG4gICAgICAgIH1cblxuICAgICAgICBFID0gMDtcbiAgICAgIH1cbiAgICB9XG5cbiAgICByZXR1cm4gRyArIHAgKyBGO1xuICB9XG5cbiAgZnVuY3Rpb24gWChkLCBjLCBlKSB7XG4gICAgdmFyIGggPSBjLnRyaW0oKS5zcGxpdChpYSk7XG4gICAgYyA9IGg7XG4gICAgdmFyIGEgPSBoLmxlbmd0aCxcbiAgICAgICAgbSA9IGQubGVuZ3RoO1xuXG4gICAgc3dpdGNoIChtKSB7XG4gICAgICBjYXNlIDA6XG4gICAgICBjYXNlIDE6XG4gICAgICAgIHZhciBiID0gMDtcblxuICAgICAgICBmb3IgKGQgPSAwID09PSBtID8gJycgOiBkWzBdICsgJyAnOyBiIDwgYTsgKytiKSB7XG4gICAgICAgICAgY1tiXSA9IFooZCwgY1tiXSwgZSkudHJpbSgpO1xuICAgICAgICB9XG5cbiAgICAgICAgYnJlYWs7XG5cbiAgICAgIGRlZmF1bHQ6XG4gICAgICAgIHZhciB2ID0gYiA9IDA7XG5cbiAgICAgICAgZm9yIChjID0gW107IGIgPCBhOyArK2IpIHtcbiAgICAgICAgICBmb3IgKHZhciBuID0gMDsgbiA8IG07ICsrbikge1xuICAgICAgICAgICAgY1t2KytdID0gWihkW25dICsgJyAnLCBoW2JdLCBlKS50cmltKCk7XG4gICAgICAgICAgfVxuICAgICAgICB9XG5cbiAgICB9XG5cbiAgICByZXR1cm4gYztcbiAgfVxuXG4gIGZ1bmN0aW9uIFooZCwgYywgZSkge1xuICAgIHZhciBoID0gYy5jaGFyQ29kZUF0KDApO1xuICAgIDMzID4gaCAmJiAoaCA9IChjID0gYy50cmltKCkpLmNoYXJDb2RlQXQoMCkpO1xuXG4gICAgc3dpdGNoIChoKSB7XG4gICAgICBjYXNlIDM4OlxuICAgICAgICByZXR1cm4gYy5yZXBsYWNlKEYsICckMScgKyBkLnRyaW0oKSk7XG5cbiAgICAgIGNhc2UgNTg6XG4gICAgICAgIHJldHVybiBkLnRyaW0oKSArIGMucmVwbGFjZShGLCAnJDEnICsgZC50cmltKCkpO1xuXG4gICAgICBkZWZhdWx0OlxuICAgICAgICBpZiAoMCA8IDEgKiBlICYmIDAgPCBjLmluZGV4T2YoJ1xcZicpKSByZXR1cm4gYy5yZXBsYWNlKEYsICg1OCA9PT0gZC5jaGFyQ29kZUF0KDApID8gJycgOiAnJDEnKSArIGQudHJpbSgpKTtcbiAgICB9XG5cbiAgICByZXR1cm4gZCArIGM7XG4gIH1cblxuICBmdW5jdGlvbiBQKGQsIGMsIGUsIGgpIHtcbiAgICB2YXIgYSA9IGQgKyAnOycsXG4gICAgICAgIG0gPSAyICogYyArIDMgKiBlICsgNCAqIGg7XG5cbiAgICBpZiAoOTQ0ID09PSBtKSB7XG4gICAgICBkID0gYS5pbmRleE9mKCc6JywgOSkgKyAxO1xuICAgICAgdmFyIGIgPSBhLnN1YnN0cmluZyhkLCBhLmxlbmd0aCAtIDEpLnRyaW0oKTtcbiAgICAgIGIgPSBhLnN1YnN0cmluZygwLCBkKS50cmltKCkgKyBiICsgJzsnO1xuICAgICAgcmV0dXJuIDEgPT09IHcgfHwgMiA9PT0gdyAmJiBMKGIsIDEpID8gJy13ZWJraXQtJyArIGIgKyBiIDogYjtcbiAgICB9XG5cbiAgICBpZiAoMCA9PT0gdyB8fCAyID09PSB3ICYmICFMKGEsIDEpKSByZXR1cm4gYTtcblxuICAgIHN3aXRjaCAobSkge1xuICAgICAgY2FzZSAxMDE1OlxuICAgICAgICByZXR1cm4gOTcgPT09IGEuY2hhckNvZGVBdCgxMCkgPyAnLXdlYmtpdC0nICsgYSArIGEgOiBhO1xuXG4gICAgICBjYXNlIDk1MTpcbiAgICAgICAgcmV0dXJuIDExNiA9PT0gYS5jaGFyQ29kZUF0KDMpID8gJy13ZWJraXQtJyArIGEgKyBhIDogYTtcblxuICAgICAgY2FzZSA5NjM6XG4gICAgICAgIHJldHVybiAxMTAgPT09IGEuY2hhckNvZGVBdCg1KSA/ICctd2Via2l0LScgKyBhICsgYSA6IGE7XG5cbiAgICAgIGNhc2UgMTAwOTpcbiAgICAgICAgaWYgKDEwMCAhPT0gYS5jaGFyQ29kZUF0KDQpKSBicmVhaztcblxuICAgICAgY2FzZSA5Njk6XG4gICAgICBjYXNlIDk0MjpcbiAgICAgICAgcmV0dXJuICctd2Via2l0LScgKyBhICsgYTtcblxuICAgICAgY2FzZSA5Nzg6XG4gICAgICAgIHJldHVybiAnLXdlYmtpdC0nICsgYSArICctbW96LScgKyBhICsgYTtcblxuICAgICAgY2FzZSAxMDE5OlxuICAgICAgY2FzZSA5ODM6XG4gICAgICAgIHJldHVybiAnLXdlYmtpdC0nICsgYSArICctbW96LScgKyBhICsgJy1tcy0nICsgYSArIGE7XG5cbiAgICAgIGNhc2UgODgzOlxuICAgICAgICBpZiAoNDUgPT09IGEuY2hhckNvZGVBdCg4KSkgcmV0dXJuICctd2Via2l0LScgKyBhICsgYTtcbiAgICAgICAgaWYgKDAgPCBhLmluZGV4T2YoJ2ltYWdlLXNldCgnLCAxMSkpIHJldHVybiBhLnJlcGxhY2UoamEsICckMS13ZWJraXQtJDInKSArIGE7XG4gICAgICAgIGJyZWFrO1xuXG4gICAgICBjYXNlIDkzMjpcbiAgICAgICAgaWYgKDQ1ID09PSBhLmNoYXJDb2RlQXQoNCkpIHN3aXRjaCAoYS5jaGFyQ29kZUF0KDUpKSB7XG4gICAgICAgICAgY2FzZSAxMDM6XG4gICAgICAgICAgICByZXR1cm4gJy13ZWJraXQtYm94LScgKyBhLnJlcGxhY2UoJy1ncm93JywgJycpICsgJy13ZWJraXQtJyArIGEgKyAnLW1zLScgKyBhLnJlcGxhY2UoJ2dyb3cnLCAncG9zaXRpdmUnKSArIGE7XG5cbiAgICAgICAgICBjYXNlIDExNTpcbiAgICAgICAgICAgIHJldHVybiAnLXdlYmtpdC0nICsgYSArICctbXMtJyArIGEucmVwbGFjZSgnc2hyaW5rJywgJ25lZ2F0aXZlJykgKyBhO1xuXG4gICAgICAgICAgY2FzZSA5ODpcbiAgICAgICAgICAgIHJldHVybiAnLXdlYmtpdC0nICsgYSArICctbXMtJyArIGEucmVwbGFjZSgnYmFzaXMnLCAncHJlZmVycmVkLXNpemUnKSArIGE7XG4gICAgICAgIH1cbiAgICAgICAgcmV0dXJuICctd2Via2l0LScgKyBhICsgJy1tcy0nICsgYSArIGE7XG5cbiAgICAgIGNhc2UgOTY0OlxuICAgICAgICByZXR1cm4gJy13ZWJraXQtJyArIGEgKyAnLW1zLWZsZXgtJyArIGEgKyBhO1xuXG4gICAgICBjYXNlIDEwMjM6XG4gICAgICAgIGlmICg5OSAhPT0gYS5jaGFyQ29kZUF0KDgpKSBicmVhaztcbiAgICAgICAgYiA9IGEuc3Vic3RyaW5nKGEuaW5kZXhPZignOicsIDE1KSkucmVwbGFjZSgnZmxleC0nLCAnJykucmVwbGFjZSgnc3BhY2UtYmV0d2VlbicsICdqdXN0aWZ5Jyk7XG4gICAgICAgIHJldHVybiAnLXdlYmtpdC1ib3gtcGFjaycgKyBiICsgJy13ZWJraXQtJyArIGEgKyAnLW1zLWZsZXgtcGFjaycgKyBiICsgYTtcblxuICAgICAgY2FzZSAxMDA1OlxuICAgICAgICByZXR1cm4ga2EudGVzdChhKSA/IGEucmVwbGFjZShhYSwgJzotd2Via2l0LScpICsgYS5yZXBsYWNlKGFhLCAnOi1tb3otJykgKyBhIDogYTtcblxuICAgICAgY2FzZSAxZTM6XG4gICAgICAgIGIgPSBhLnN1YnN0cmluZygxMykudHJpbSgpO1xuICAgICAgICBjID0gYi5pbmRleE9mKCctJykgKyAxO1xuXG4gICAgICAgIHN3aXRjaCAoYi5jaGFyQ29kZUF0KDApICsgYi5jaGFyQ29kZUF0KGMpKSB7XG4gICAgICAgICAgY2FzZSAyMjY6XG4gICAgICAgICAgICBiID0gYS5yZXBsYWNlKEcsICd0YicpO1xuICAgICAgICAgICAgYnJlYWs7XG5cbiAgICAgICAgICBjYXNlIDIzMjpcbiAgICAgICAgICAgIGIgPSBhLnJlcGxhY2UoRywgJ3RiLXJsJyk7XG4gICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgIGNhc2UgMjIwOlxuICAgICAgICAgICAgYiA9IGEucmVwbGFjZShHLCAnbHInKTtcbiAgICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgICAgZGVmYXVsdDpcbiAgICAgICAgICAgIHJldHVybiBhO1xuICAgICAgICB9XG5cbiAgICAgICAgcmV0dXJuICctd2Via2l0LScgKyBhICsgJy1tcy0nICsgYiArIGE7XG5cbiAgICAgIGNhc2UgMTAxNzpcbiAgICAgICAgaWYgKC0xID09PSBhLmluZGV4T2YoJ3N0aWNreScsIDkpKSBicmVhaztcblxuICAgICAgY2FzZSA5NzU6XG4gICAgICAgIGMgPSAoYSA9IGQpLmxlbmd0aCAtIDEwO1xuICAgICAgICBiID0gKDMzID09PSBhLmNoYXJDb2RlQXQoYykgPyBhLnN1YnN0cmluZygwLCBjKSA6IGEpLnN1YnN0cmluZyhkLmluZGV4T2YoJzonLCA3KSArIDEpLnRyaW0oKTtcblxuICAgICAgICBzd2l0Y2ggKG0gPSBiLmNoYXJDb2RlQXQoMCkgKyAoYi5jaGFyQ29kZUF0KDcpIHwgMCkpIHtcbiAgICAgICAgICBjYXNlIDIwMzpcbiAgICAgICAgICAgIGlmICgxMTEgPiBiLmNoYXJDb2RlQXQoOCkpIGJyZWFrO1xuXG4gICAgICAgICAgY2FzZSAxMTU6XG4gICAgICAgICAgICBhID0gYS5yZXBsYWNlKGIsICctd2Via2l0LScgKyBiKSArICc7JyArIGE7XG4gICAgICAgICAgICBicmVhaztcblxuICAgICAgICAgIGNhc2UgMjA3OlxuICAgICAgICAgIGNhc2UgMTAyOlxuICAgICAgICAgICAgYSA9IGEucmVwbGFjZShiLCAnLXdlYmtpdC0nICsgKDEwMiA8IG0gPyAnaW5saW5lLScgOiAnJykgKyAnYm94JykgKyAnOycgKyBhLnJlcGxhY2UoYiwgJy13ZWJraXQtJyArIGIpICsgJzsnICsgYS5yZXBsYWNlKGIsICctbXMtJyArIGIgKyAnYm94JykgKyAnOycgKyBhO1xuICAgICAgICB9XG5cbiAgICAgICAgcmV0dXJuIGEgKyAnOyc7XG5cbiAgICAgIGNhc2UgOTM4OlxuICAgICAgICBpZiAoNDUgPT09IGEuY2hhckNvZGVBdCg1KSkgc3dpdGNoIChhLmNoYXJDb2RlQXQoNikpIHtcbiAgICAgICAgICBjYXNlIDEwNTpcbiAgICAgICAgICAgIHJldHVybiBiID0gYS5yZXBsYWNlKCctaXRlbXMnLCAnJyksICctd2Via2l0LScgKyBhICsgJy13ZWJraXQtYm94LScgKyBiICsgJy1tcy1mbGV4LScgKyBiICsgYTtcblxuICAgICAgICAgIGNhc2UgMTE1OlxuICAgICAgICAgICAgcmV0dXJuICctd2Via2l0LScgKyBhICsgJy1tcy1mbGV4LWl0ZW0tJyArIGEucmVwbGFjZShiYSwgJycpICsgYTtcblxuICAgICAgICAgIGRlZmF1bHQ6XG4gICAgICAgICAgICByZXR1cm4gJy13ZWJraXQtJyArIGEgKyAnLW1zLWZsZXgtbGluZS1wYWNrJyArIGEucmVwbGFjZSgnYWxpZ24tY29udGVudCcsICcnKS5yZXBsYWNlKGJhLCAnJykgKyBhO1xuICAgICAgICB9XG4gICAgICAgIGJyZWFrO1xuXG4gICAgICBjYXNlIDk3MzpcbiAgICAgIGNhc2UgOTg5OlxuICAgICAgICBpZiAoNDUgIT09IGEuY2hhckNvZGVBdCgzKSB8fCAxMjIgPT09IGEuY2hhckNvZGVBdCg0KSkgYnJlYWs7XG5cbiAgICAgIGNhc2UgOTMxOlxuICAgICAgY2FzZSA5NTM6XG4gICAgICAgIGlmICghMCA9PT0gbGEudGVzdChkKSkgcmV0dXJuIDExNSA9PT0gKGIgPSBkLnN1YnN0cmluZyhkLmluZGV4T2YoJzonKSArIDEpKS5jaGFyQ29kZUF0KDApID8gUChkLnJlcGxhY2UoJ3N0cmV0Y2gnLCAnZmlsbC1hdmFpbGFibGUnKSwgYywgZSwgaCkucmVwbGFjZSgnOmZpbGwtYXZhaWxhYmxlJywgJzpzdHJldGNoJykgOiBhLnJlcGxhY2UoYiwgJy13ZWJraXQtJyArIGIpICsgYS5yZXBsYWNlKGIsICctbW96LScgKyBiLnJlcGxhY2UoJ2ZpbGwtJywgJycpKSArIGE7XG4gICAgICAgIGJyZWFrO1xuXG4gICAgICBjYXNlIDk2MjpcbiAgICAgICAgaWYgKGEgPSAnLXdlYmtpdC0nICsgYSArICgxMDIgPT09IGEuY2hhckNvZGVBdCg1KSA/ICctbXMtJyArIGEgOiAnJykgKyBhLCAyMTEgPT09IGUgKyBoICYmIDEwNSA9PT0gYS5jaGFyQ29kZUF0KDEzKSAmJiAwIDwgYS5pbmRleE9mKCd0cmFuc2Zvcm0nLCAxMCkpIHJldHVybiBhLnN1YnN0cmluZygwLCBhLmluZGV4T2YoJzsnLCAyNykgKyAxKS5yZXBsYWNlKG1hLCAnJDEtd2Via2l0LSQyJykgKyBhO1xuICAgIH1cblxuICAgIHJldHVybiBhO1xuICB9XG5cbiAgZnVuY3Rpb24gTChkLCBjKSB7XG4gICAgdmFyIGUgPSBkLmluZGV4T2YoMSA9PT0gYyA/ICc6JyA6ICd7JyksXG4gICAgICAgIGggPSBkLnN1YnN0cmluZygwLCAzICE9PSBjID8gZSA6IDEwKTtcbiAgICBlID0gZC5zdWJzdHJpbmcoZSArIDEsIGQubGVuZ3RoIC0gMSk7XG4gICAgcmV0dXJuIFIoMiAhPT0gYyA/IGggOiBoLnJlcGxhY2UobmEsICckMScpLCBlLCBjKTtcbiAgfVxuXG4gIGZ1bmN0aW9uIGVhKGQsIGMpIHtcbiAgICB2YXIgZSA9IFAoYywgYy5jaGFyQ29kZUF0KDApLCBjLmNoYXJDb2RlQXQoMSksIGMuY2hhckNvZGVBdCgyKSk7XG4gICAgcmV0dXJuIGUgIT09IGMgKyAnOycgPyBlLnJlcGxhY2Uob2EsICcgb3IgKCQxKScpLnN1YnN0cmluZyg0KSA6ICcoJyArIGMgKyAnKSc7XG4gIH1cblxuICBmdW5jdGlvbiBIKGQsIGMsIGUsIGgsIGEsIG0sIGIsIHYsIG4sIHEpIHtcbiAgICBmb3IgKHZhciBnID0gMCwgeCA9IGMsIHc7IGcgPCBBOyArK2cpIHtcbiAgICAgIHN3aXRjaCAodyA9IFNbZ10uY2FsbChCLCBkLCB4LCBlLCBoLCBhLCBtLCBiLCB2LCBuLCBxKSkge1xuICAgICAgICBjYXNlIHZvaWQgMDpcbiAgICAgICAgY2FzZSAhMTpcbiAgICAgICAgY2FzZSAhMDpcbiAgICAgICAgY2FzZSBudWxsOlxuICAgICAgICAgIGJyZWFrO1xuXG4gICAgICAgIGRlZmF1bHQ6XG4gICAgICAgICAgeCA9IHc7XG4gICAgICB9XG4gICAgfVxuXG4gICAgaWYgKHggIT09IGMpIHJldHVybiB4O1xuICB9XG5cbiAgZnVuY3Rpb24gVChkKSB7XG4gICAgc3dpdGNoIChkKSB7XG4gICAgICBjYXNlIHZvaWQgMDpcbiAgICAgIGNhc2UgbnVsbDpcbiAgICAgICAgQSA9IFMubGVuZ3RoID0gMDtcbiAgICAgICAgYnJlYWs7XG5cbiAgICAgIGRlZmF1bHQ6XG4gICAgICAgIGlmICgnZnVuY3Rpb24nID09PSB0eXBlb2YgZCkgU1tBKytdID0gZDtlbHNlIGlmICgnb2JqZWN0JyA9PT0gdHlwZW9mIGQpIGZvciAodmFyIGMgPSAwLCBlID0gZC5sZW5ndGg7IGMgPCBlOyArK2MpIHtcbiAgICAgICAgICBUKGRbY10pO1xuICAgICAgICB9IGVsc2UgWSA9ICEhZCB8IDA7XG4gICAgfVxuXG4gICAgcmV0dXJuIFQ7XG4gIH1cblxuICBmdW5jdGlvbiBVKGQpIHtcbiAgICBkID0gZC5wcmVmaXg7XG4gICAgdm9pZCAwICE9PSBkICYmIChSID0gbnVsbCwgZCA/ICdmdW5jdGlvbicgIT09IHR5cGVvZiBkID8gdyA9IDEgOiAodyA9IDIsIFIgPSBkKSA6IHcgPSAwKTtcbiAgICByZXR1cm4gVTtcbiAgfVxuXG4gIGZ1bmN0aW9uIEIoZCwgYykge1xuICAgIHZhciBlID0gZDtcbiAgICAzMyA+IGUuY2hhckNvZGVBdCgwKSAmJiAoZSA9IGUudHJpbSgpKTtcbiAgICBWID0gZTtcbiAgICBlID0gW1ZdO1xuXG4gICAgaWYgKDAgPCBBKSB7XG4gICAgICB2YXIgaCA9IEgoLTEsIGMsIGUsIGUsIEQsIHosIDAsIDAsIDAsIDApO1xuICAgICAgdm9pZCAwICE9PSBoICYmICdzdHJpbmcnID09PSB0eXBlb2YgaCAmJiAoYyA9IGgpO1xuICAgIH1cblxuICAgIHZhciBhID0gTShPLCBlLCBjLCAwLCAwKTtcbiAgICAwIDwgQSAmJiAoaCA9IEgoLTIsIGEsIGUsIGUsIEQsIHosIGEubGVuZ3RoLCAwLCAwLCAwKSwgdm9pZCAwICE9PSBoICYmIChhID0gaCkpO1xuICAgIFYgPSAnJztcbiAgICBFID0gMDtcbiAgICB6ID0gRCA9IDE7XG4gICAgcmV0dXJuIGE7XG4gIH1cblxuICB2YXIgY2EgPSAvXlxcMCsvZyxcbiAgICAgIE4gPSAvW1xcMFxcclxcZl0vZyxcbiAgICAgIGFhID0gLzogKi9nLFxuICAgICAga2EgPSAvem9vfGdyYS8sXG4gICAgICBtYSA9IC8oWyw6IF0pKHRyYW5zZm9ybSkvZyxcbiAgICAgIGlhID0gLyxcXHIrPy9nLFxuICAgICAgRiA9IC8oW1xcdFxcclxcbiBdKSpcXGY/Ji9nLFxuICAgICAgZmEgPSAvQChrXFx3KylcXHMqKFxcUyopXFxzKi8sXG4gICAgICBRID0gLzo6KHBsYWNlKS9nLFxuICAgICAgaGEgPSAvOihyZWFkLW9ubHkpL2csXG4gICAgICBHID0gL1tzdmhdXFx3Ky1bdGJscl17Mn0vLFxuICAgICAgZGEgPSAvXFwoXFxzKiguKilcXHMqXFwpL2csXG4gICAgICBvYSA9IC8oW1xcc1xcU10qPyk7L2csXG4gICAgICBiYSA9IC8tc2VsZnxmbGV4LS9nLFxuICAgICAgbmEgPSAvW15dKj8oOltycF1bZWxdYVtcXHctXSspW15dKi8sXG4gICAgICBsYSA9IC9zdHJldGNofDpcXHMqXFx3K1xcLSg/OmNvbnRlfGF2YWlsKS8sXG4gICAgICBqYSA9IC8oW14tXSkoaW1hZ2Utc2V0XFwoKS8sXG4gICAgICB6ID0gMSxcbiAgICAgIEQgPSAxLFxuICAgICAgRSA9IDAsXG4gICAgICB3ID0gMSxcbiAgICAgIE8gPSBbXSxcbiAgICAgIFMgPSBbXSxcbiAgICAgIEEgPSAwLFxuICAgICAgUiA9IG51bGwsXG4gICAgICBZID0gMCxcbiAgICAgIFYgPSAnJztcbiAgQi51c2UgPSBUO1xuICBCLnNldCA9IFU7XG4gIHZvaWQgMCAhPT0gVyAmJiBVKFcpO1xuICByZXR1cm4gQjtcbn1cblxuZXhwb3J0IGRlZmF1bHQgc3R5bGlzX21pbjtcbiIsInZhciB1bml0bGVzc0tleXMgPSB7XG4gIGFuaW1hdGlvbkl0ZXJhdGlvbkNvdW50OiAxLFxuICBib3JkZXJJbWFnZU91dHNldDogMSxcbiAgYm9yZGVySW1hZ2VTbGljZTogMSxcbiAgYm9yZGVySW1hZ2VXaWR0aDogMSxcbiAgYm94RmxleDogMSxcbiAgYm94RmxleEdyb3VwOiAxLFxuICBib3hPcmRpbmFsR3JvdXA6IDEsXG4gIGNvbHVtbkNvdW50OiAxLFxuICBjb2x1bW5zOiAxLFxuICBmbGV4OiAxLFxuICBmbGV4R3JvdzogMSxcbiAgZmxleFBvc2l0aXZlOiAxLFxuICBmbGV4U2hyaW5rOiAxLFxuICBmbGV4TmVnYXRpdmU6IDEsXG4gIGZsZXhPcmRlcjogMSxcbiAgZ3JpZFJvdzogMSxcbiAgZ3JpZFJvd0VuZDogMSxcbiAgZ3JpZFJvd1NwYW46IDEsXG4gIGdyaWRSb3dTdGFydDogMSxcbiAgZ3JpZENvbHVtbjogMSxcbiAgZ3JpZENvbHVtbkVuZDogMSxcbiAgZ3JpZENvbHVtblNwYW46IDEsXG4gIGdyaWRDb2x1bW5TdGFydDogMSxcbiAgbXNHcmlkUm93OiAxLFxuICBtc0dyaWRSb3dTcGFuOiAxLFxuICBtc0dyaWRDb2x1bW46IDEsXG4gIG1zR3JpZENvbHVtblNwYW46IDEsXG4gIGZvbnRXZWlnaHQ6IDEsXG4gIGxpbmVIZWlnaHQ6IDEsXG4gIG9wYWNpdHk6IDEsXG4gIG9yZGVyOiAxLFxuICBvcnBoYW5zOiAxLFxuICB0YWJTaXplOiAxLFxuICB3aWRvd3M6IDEsXG4gIHpJbmRleDogMSxcbiAgem9vbTogMSxcbiAgV2Via2l0TGluZUNsYW1wOiAxLFxuICAvLyBTVkctcmVsYXRlZCBwcm9wZXJ0aWVzXG4gIGZpbGxPcGFjaXR5OiAxLFxuICBmbG9vZE9wYWNpdHk6IDEsXG4gIHN0b3BPcGFjaXR5OiAxLFxuICBzdHJva2VEYXNoYXJyYXk6IDEsXG4gIHN0cm9rZURhc2hvZmZzZXQ6IDEsXG4gIHN0cm9rZU1pdGVybGltaXQ6IDEsXG4gIHN0cm9rZU9wYWNpdHk6IDEsXG4gIHN0cm9rZVdpZHRoOiAxXG59O1xuXG5leHBvcnQgZGVmYXVsdCB1bml0bGVzc0tleXM7XG4iLCJpbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgKiBhcyBhY3Rpb25zIGZyb20gXCIuL2FjdGlvbnNcIjtcbmltcG9ydCB7IEFwcERpc3BhdGNoQ29udGV4dCwgQXBwU3RhdGVDb250ZXh0IH0gZnJvbSBcIi4vY29udGV4dHNcIjtcbmltcG9ydCAqIGFzIG1lc3NhZ2VzIGZyb20gXCIuLi8uLi9zaGFyZWQvbWVzc2FnZXNcIjtcblxuZXhwb3J0IGNvbnN0IHVzZUhpZGUgPSAoKSA9PiB7XG4gIGNvbnN0IGRpc3BhdGNoID0gUmVhY3QudXNlQ29udGV4dChBcHBEaXNwYXRjaENvbnRleHQpO1xuICBjb25zdCBoaWRlID0gUmVhY3QudXNlQ2FsbGJhY2soKCkgPT4ge1xuICAgIHdpbmRvdy50b3AucG9zdE1lc3NhZ2UoXG4gICAgICBKU09OLnN0cmluZ2lmeSh7XG4gICAgICAgIHR5cGU6IG1lc3NhZ2VzLkNPTlNPTEVfVU5GT0NVUyxcbiAgICAgIH0pLFxuICAgICAgXCIqXCJcbiAgICApO1xuICAgIGRpc3BhdGNoKGFjdGlvbnMuaGlkZSgpKTtcbiAgfSwgW2Rpc3BhdGNoXSk7XG5cbiAgcmV0dXJuIGhpZGU7XG59O1xuXG5leHBvcnQgY29uc3QgdXNlQ29tbWFuZE1vZGUgPSAoKSA9PiB7XG4gIGNvbnN0IHN0YXRlID0gUmVhY3QudXNlQ29udGV4dChBcHBTdGF0ZUNvbnRleHQpO1xuICBjb25zdCBkaXNwYXRjaCA9IFJlYWN0LnVzZUNvbnRleHQoQXBwRGlzcGF0Y2hDb250ZXh0KTtcblxuICBjb25zdCBzaG93ID0gUmVhY3QudXNlQ2FsbGJhY2soXG4gICAgKGluaXRpYWxJbnB1dFZhbHVlOiBzdHJpbmcpID0+IHtcbiAgICAgIGRpc3BhdGNoKGFjdGlvbnMuc2hvd0NvbW1hbmQoaW5pdGlhbElucHV0VmFsdWUpKTtcbiAgICB9LFxuICAgIFtkaXNwYXRjaF1cbiAgKTtcblxuICByZXR1cm4ge1xuICAgIHZpc2libGU6IHN0YXRlLm1vZGUgPT09IFwiY29tbWFuZFwiLFxuICAgIGluaXRpYWxJbnB1dFZhbHVlOiBzdGF0ZS5jb25zb2xlVGV4dCxcbiAgICBzaG93LFxuICB9O1xufTtcblxuZXhwb3J0IGNvbnN0IHVzZUZpbmRNb2RlID0gKCkgPT4ge1xuICBjb25zdCBzdGF0ZSA9IFJlYWN0LnVzZUNvbnRleHQoQXBwU3RhdGVDb250ZXh0KTtcbiAgY29uc3QgZGlzcGF0Y2ggPSBSZWFjdC51c2VDb250ZXh0KEFwcERpc3BhdGNoQ29udGV4dCk7XG5cbiAgY29uc3Qgc2hvdyA9IFJlYWN0LnVzZUNhbGxiYWNrKCgpID0+IHtcbiAgICBkaXNwYXRjaChhY3Rpb25zLnNob3dGaW5kKCkpO1xuICB9LCBbZGlzcGF0Y2hdKTtcblxuICByZXR1cm4ge1xuICAgIHZpc2libGU6IHN0YXRlLm1vZGUgPT09IFwiZmluZFwiLFxuICAgIHNob3csXG4gIH07XG59O1xuXG5leHBvcnQgY29uc3QgdXNlSW5mb01lc3NhZ2UgPSAoKSA9PiB7XG4gIGNvbnN0IHN0YXRlID0gUmVhY3QudXNlQ29udGV4dChBcHBTdGF0ZUNvbnRleHQpO1xuICBjb25zdCBkaXNwYXRjaCA9IFJlYWN0LnVzZUNvbnRleHQoQXBwRGlzcGF0Y2hDb250ZXh0KTtcblxuICBjb25zdCBzaG93ID0gUmVhY3QudXNlQ2FsbGJhY2soXG4gICAgKG1lc3NhZ2U6IHN0cmluZykgPT4ge1xuICAgICAgZGlzcGF0Y2goYWN0aW9ucy5zaG93SW5mbyhtZXNzYWdlKSk7XG4gICAgfSxcbiAgICBbZGlzcGF0Y2hdXG4gICk7XG5cbiAgcmV0dXJuIHtcbiAgICB2aXNpYmxlOiBzdGF0ZS5tb2RlID09PSBcImluZm9cIixcbiAgICBtZXNzYWdlOiBzdGF0ZS5tb2RlID09PSBcImluZm9cIiA/IHN0YXRlLm1lc3NhZ2VUZXh0IDogXCJcIixcbiAgICBzaG93LFxuICB9O1xufTtcblxuZXhwb3J0IGNvbnN0IHVzZUVycm9yTWVzc2FnZSA9ICgpID0+IHtcbiAgY29uc3Qgc3RhdGUgPSBSZWFjdC51c2VDb250ZXh0KEFwcFN0YXRlQ29udGV4dCk7XG4gIGNvbnN0IGRpc3BhdGNoID0gUmVhY3QudXNlQ29udGV4dChBcHBEaXNwYXRjaENvbnRleHQpO1xuXG4gIGNvbnN0IHNob3cgPSBSZWFjdC51c2VDYWxsYmFjayhcbiAgICAobWVzc2FnZTogc3RyaW5nKSA9PiB7XG4gICAgICBkaXNwYXRjaChhY3Rpb25zLnNob3dFcnJvcihtZXNzYWdlKSk7XG4gICAgfSxcbiAgICBbZGlzcGF0Y2hdXG4gICk7XG5cbiAgcmV0dXJuIHtcbiAgICB2aXNpYmxlOiBzdGF0ZS5tb2RlID09PSBcImVycm9yXCIsXG4gICAgbWVzc2FnZTogc3RhdGUubW9kZSA9PT0gXCJlcnJvclwiID8gc3RhdGUubWVzc2FnZVRleHQgOiBcIlwiLFxuICAgIHNob3csXG4gIH07XG59O1xuXG5leHBvcnQgY29uc3QgZ2V0SW5pdGlhbElucHV0VmFsdWUgPSAoKSA9PiB7XG4gIGNvbnN0IHN0YXRlID0gUmVhY3QudXNlQ29udGV4dChBcHBTdGF0ZUNvbnRleHQpO1xuICByZXR1cm4gc3RhdGUuY29uc29sZVRleHQ7XG59O1xuXG5leHBvcnQgY29uc3QgdXNlRXhlY0NvbW1hbmQgPSAoKSA9PiB7XG4gIGNvbnN0IGV4ZWNDb21tYW5kID0gUmVhY3QudXNlQ2FsbGJhY2soKHRleHQ6IHN0cmluZykgPT4ge1xuICAgIGJyb3dzZXIucnVudGltZS5zZW5kTWVzc2FnZSh7XG4gICAgICB0eXBlOiBtZXNzYWdlcy5DT05TT0xFX0VOVEVSX0NPTU1BTkQsXG4gICAgICB0ZXh0LFxuICAgIH0pO1xuICB9LCBbXSk7XG4gIHJldHVybiBleGVjQ29tbWFuZDtcbn07XG5cbmV4cG9ydCBjb25zdCB1c2VFeGVjRmluZCA9ICgpID0+IHtcbiAgY29uc3QgZXhlY0ZpbmQgPSBSZWFjdC51c2VDYWxsYmFjaygodGV4dD86IHN0cmluZykgPT4ge1xuICAgIGJyb3dzZXIucnVudGltZS5zZW5kTWVzc2FnZSh7XG4gICAgICB0eXBlOiBtZXNzYWdlcy5DT05TT0xFX0VOVEVSX0ZJTkQsXG4gICAgICBrZXl3b3JkOiB0ZXh0LFxuICAgIH0pO1xuICB9LCBbXSk7XG4gIHJldHVybiBleGVjRmluZDtcbn07XG4iLCIvKiogQGxpY2Vuc2UgUmVhY3QgdjE3LjAuMlxuICogcmVhY3QucHJvZHVjdGlvbi5taW4uanNcbiAqXG4gKiBDb3B5cmlnaHQgKGMpIEZhY2Vib29rLCBJbmMuIGFuZCBpdHMgYWZmaWxpYXRlcy5cbiAqXG4gKiBUaGlzIHNvdXJjZSBjb2RlIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBNSVQgbGljZW5zZSBmb3VuZCBpbiB0aGVcbiAqIExJQ0VOU0UgZmlsZSBpbiB0aGUgcm9vdCBkaXJlY3Rvcnkgb2YgdGhpcyBzb3VyY2UgdHJlZS5cbiAqL1xuJ3VzZSBzdHJpY3QnO3ZhciBsPXJlcXVpcmUoXCJvYmplY3QtYXNzaWduXCIpLG49NjAxMDMscD02MDEwNjtleHBvcnRzLkZyYWdtZW50PTYwMTA3O2V4cG9ydHMuU3RyaWN0TW9kZT02MDEwODtleHBvcnRzLlByb2ZpbGVyPTYwMTE0O3ZhciBxPTYwMTA5LHI9NjAxMTAsdD02MDExMjtleHBvcnRzLlN1c3BlbnNlPTYwMTEzO3ZhciB1PTYwMTE1LHY9NjAxMTY7XG5pZihcImZ1bmN0aW9uXCI9PT10eXBlb2YgU3ltYm9sJiZTeW1ib2wuZm9yKXt2YXIgdz1TeW1ib2wuZm9yO249dyhcInJlYWN0LmVsZW1lbnRcIik7cD13KFwicmVhY3QucG9ydGFsXCIpO2V4cG9ydHMuRnJhZ21lbnQ9dyhcInJlYWN0LmZyYWdtZW50XCIpO2V4cG9ydHMuU3RyaWN0TW9kZT13KFwicmVhY3Quc3RyaWN0X21vZGVcIik7ZXhwb3J0cy5Qcm9maWxlcj13KFwicmVhY3QucHJvZmlsZXJcIik7cT13KFwicmVhY3QucHJvdmlkZXJcIik7cj13KFwicmVhY3QuY29udGV4dFwiKTt0PXcoXCJyZWFjdC5mb3J3YXJkX3JlZlwiKTtleHBvcnRzLlN1c3BlbnNlPXcoXCJyZWFjdC5zdXNwZW5zZVwiKTt1PXcoXCJyZWFjdC5tZW1vXCIpO3Y9dyhcInJlYWN0LmxhenlcIil9dmFyIHg9XCJmdW5jdGlvblwiPT09dHlwZW9mIFN5bWJvbCYmU3ltYm9sLml0ZXJhdG9yO1xuZnVuY3Rpb24geShhKXtpZihudWxsPT09YXx8XCJvYmplY3RcIiE9PXR5cGVvZiBhKXJldHVybiBudWxsO2E9eCYmYVt4XXx8YVtcIkBAaXRlcmF0b3JcIl07cmV0dXJuXCJmdW5jdGlvblwiPT09dHlwZW9mIGE/YTpudWxsfWZ1bmN0aW9uIHooYSl7Zm9yKHZhciBiPVwiaHR0cHM6Ly9yZWFjdGpzLm9yZy9kb2NzL2Vycm9yLWRlY29kZXIuaHRtbD9pbnZhcmlhbnQ9XCIrYSxjPTE7Yzxhcmd1bWVudHMubGVuZ3RoO2MrKyliKz1cIiZhcmdzW109XCIrZW5jb2RlVVJJQ29tcG9uZW50KGFyZ3VtZW50c1tjXSk7cmV0dXJuXCJNaW5pZmllZCBSZWFjdCBlcnJvciAjXCIrYStcIjsgdmlzaXQgXCIrYitcIiBmb3IgdGhlIGZ1bGwgbWVzc2FnZSBvciB1c2UgdGhlIG5vbi1taW5pZmllZCBkZXYgZW52aXJvbm1lbnQgZm9yIGZ1bGwgZXJyb3JzIGFuZCBhZGRpdGlvbmFsIGhlbHBmdWwgd2FybmluZ3MuXCJ9XG52YXIgQT17aXNNb3VudGVkOmZ1bmN0aW9uKCl7cmV0dXJuITF9LGVucXVldWVGb3JjZVVwZGF0ZTpmdW5jdGlvbigpe30sZW5xdWV1ZVJlcGxhY2VTdGF0ZTpmdW5jdGlvbigpe30sZW5xdWV1ZVNldFN0YXRlOmZ1bmN0aW9uKCl7fX0sQj17fTtmdW5jdGlvbiBDKGEsYixjKXt0aGlzLnByb3BzPWE7dGhpcy5jb250ZXh0PWI7dGhpcy5yZWZzPUI7dGhpcy51cGRhdGVyPWN8fEF9Qy5wcm90b3R5cGUuaXNSZWFjdENvbXBvbmVudD17fTtDLnByb3RvdHlwZS5zZXRTdGF0ZT1mdW5jdGlvbihhLGIpe2lmKFwib2JqZWN0XCIhPT10eXBlb2YgYSYmXCJmdW5jdGlvblwiIT09dHlwZW9mIGEmJm51bGwhPWEpdGhyb3cgRXJyb3Ioeig4NSkpO3RoaXMudXBkYXRlci5lbnF1ZXVlU2V0U3RhdGUodGhpcyxhLGIsXCJzZXRTdGF0ZVwiKX07Qy5wcm90b3R5cGUuZm9yY2VVcGRhdGU9ZnVuY3Rpb24oYSl7dGhpcy51cGRhdGVyLmVucXVldWVGb3JjZVVwZGF0ZSh0aGlzLGEsXCJmb3JjZVVwZGF0ZVwiKX07XG5mdW5jdGlvbiBEKCl7fUQucHJvdG90eXBlPUMucHJvdG90eXBlO2Z1bmN0aW9uIEUoYSxiLGMpe3RoaXMucHJvcHM9YTt0aGlzLmNvbnRleHQ9Yjt0aGlzLnJlZnM9Qjt0aGlzLnVwZGF0ZXI9Y3x8QX12YXIgRj1FLnByb3RvdHlwZT1uZXcgRDtGLmNvbnN0cnVjdG9yPUU7bChGLEMucHJvdG90eXBlKTtGLmlzUHVyZVJlYWN0Q29tcG9uZW50PSEwO3ZhciBHPXtjdXJyZW50Om51bGx9LEg9T2JqZWN0LnByb3RvdHlwZS5oYXNPd25Qcm9wZXJ0eSxJPXtrZXk6ITAscmVmOiEwLF9fc2VsZjohMCxfX3NvdXJjZTohMH07XG5mdW5jdGlvbiBKKGEsYixjKXt2YXIgZSxkPXt9LGs9bnVsbCxoPW51bGw7aWYobnVsbCE9Yilmb3IoZSBpbiB2b2lkIDAhPT1iLnJlZiYmKGg9Yi5yZWYpLHZvaWQgMCE9PWIua2V5JiYoaz1cIlwiK2Iua2V5KSxiKUguY2FsbChiLGUpJiYhSS5oYXNPd25Qcm9wZXJ0eShlKSYmKGRbZV09YltlXSk7dmFyIGc9YXJndW1lbnRzLmxlbmd0aC0yO2lmKDE9PT1nKWQuY2hpbGRyZW49YztlbHNlIGlmKDE8Zyl7Zm9yKHZhciBmPUFycmF5KGcpLG09MDttPGc7bSsrKWZbbV09YXJndW1lbnRzW20rMl07ZC5jaGlsZHJlbj1mfWlmKGEmJmEuZGVmYXVsdFByb3BzKWZvcihlIGluIGc9YS5kZWZhdWx0UHJvcHMsZyl2b2lkIDA9PT1kW2VdJiYoZFtlXT1nW2VdKTtyZXR1cm57JCR0eXBlb2Y6bix0eXBlOmEsa2V5OmsscmVmOmgscHJvcHM6ZCxfb3duZXI6Ry5jdXJyZW50fX1cbmZ1bmN0aW9uIEsoYSxiKXtyZXR1cm57JCR0eXBlb2Y6bix0eXBlOmEudHlwZSxrZXk6YixyZWY6YS5yZWYscHJvcHM6YS5wcm9wcyxfb3duZXI6YS5fb3duZXJ9fWZ1bmN0aW9uIEwoYSl7cmV0dXJuXCJvYmplY3RcIj09PXR5cGVvZiBhJiZudWxsIT09YSYmYS4kJHR5cGVvZj09PW59ZnVuY3Rpb24gZXNjYXBlKGEpe3ZhciBiPXtcIj1cIjpcIj0wXCIsXCI6XCI6XCI9MlwifTtyZXR1cm5cIiRcIithLnJlcGxhY2UoL1s9Ol0vZyxmdW5jdGlvbihhKXtyZXR1cm4gYlthXX0pfXZhciBNPS9cXC8rL2c7ZnVuY3Rpb24gTihhLGIpe3JldHVyblwib2JqZWN0XCI9PT10eXBlb2YgYSYmbnVsbCE9PWEmJm51bGwhPWEua2V5P2VzY2FwZShcIlwiK2Eua2V5KTpiLnRvU3RyaW5nKDM2KX1cbmZ1bmN0aW9uIE8oYSxiLGMsZSxkKXt2YXIgaz10eXBlb2YgYTtpZihcInVuZGVmaW5lZFwiPT09a3x8XCJib29sZWFuXCI9PT1rKWE9bnVsbDt2YXIgaD0hMTtpZihudWxsPT09YSloPSEwO2Vsc2Ugc3dpdGNoKGspe2Nhc2UgXCJzdHJpbmdcIjpjYXNlIFwibnVtYmVyXCI6aD0hMDticmVhaztjYXNlIFwib2JqZWN0XCI6c3dpdGNoKGEuJCR0eXBlb2Ype2Nhc2UgbjpjYXNlIHA6aD0hMH19aWYoaClyZXR1cm4gaD1hLGQ9ZChoKSxhPVwiXCI9PT1lP1wiLlwiK04oaCwwKTplLEFycmF5LmlzQXJyYXkoZCk/KGM9XCJcIixudWxsIT1hJiYoYz1hLnJlcGxhY2UoTSxcIiQmL1wiKStcIi9cIiksTyhkLGIsYyxcIlwiLGZ1bmN0aW9uKGEpe3JldHVybiBhfSkpOm51bGwhPWQmJihMKGQpJiYoZD1LKGQsYysoIWQua2V5fHxoJiZoLmtleT09PWQua2V5P1wiXCI6KFwiXCIrZC5rZXkpLnJlcGxhY2UoTSxcIiQmL1wiKStcIi9cIikrYSkpLGIucHVzaChkKSksMTtoPTA7ZT1cIlwiPT09ZT9cIi5cIjplK1wiOlwiO2lmKEFycmF5LmlzQXJyYXkoYSkpZm9yKHZhciBnPVxuMDtnPGEubGVuZ3RoO2crKyl7az1hW2ddO3ZhciBmPWUrTihrLGcpO2grPU8oayxiLGMsZixkKX1lbHNlIGlmKGY9eShhKSxcImZ1bmN0aW9uXCI9PT10eXBlb2YgZilmb3IoYT1mLmNhbGwoYSksZz0wOyEoaz1hLm5leHQoKSkuZG9uZTspaz1rLnZhbHVlLGY9ZStOKGssZysrKSxoKz1PKGssYixjLGYsZCk7ZWxzZSBpZihcIm9iamVjdFwiPT09ayl0aHJvdyBiPVwiXCIrYSxFcnJvcih6KDMxLFwiW29iamVjdCBPYmplY3RdXCI9PT1iP1wib2JqZWN0IHdpdGgga2V5cyB7XCIrT2JqZWN0LmtleXMoYSkuam9pbihcIiwgXCIpK1wifVwiOmIpKTtyZXR1cm4gaH1mdW5jdGlvbiBQKGEsYixjKXtpZihudWxsPT1hKXJldHVybiBhO3ZhciBlPVtdLGQ9MDtPKGEsZSxcIlwiLFwiXCIsZnVuY3Rpb24oYSl7cmV0dXJuIGIuY2FsbChjLGEsZCsrKX0pO3JldHVybiBlfVxuZnVuY3Rpb24gUShhKXtpZigtMT09PWEuX3N0YXR1cyl7dmFyIGI9YS5fcmVzdWx0O2I9YigpO2EuX3N0YXR1cz0wO2EuX3Jlc3VsdD1iO2IudGhlbihmdW5jdGlvbihiKXswPT09YS5fc3RhdHVzJiYoYj1iLmRlZmF1bHQsYS5fc3RhdHVzPTEsYS5fcmVzdWx0PWIpfSxmdW5jdGlvbihiKXswPT09YS5fc3RhdHVzJiYoYS5fc3RhdHVzPTIsYS5fcmVzdWx0PWIpfSl9aWYoMT09PWEuX3N0YXR1cylyZXR1cm4gYS5fcmVzdWx0O3Rocm93IGEuX3Jlc3VsdDt9dmFyIFI9e2N1cnJlbnQ6bnVsbH07ZnVuY3Rpb24gUygpe3ZhciBhPVIuY3VycmVudDtpZihudWxsPT09YSl0aHJvdyBFcnJvcih6KDMyMSkpO3JldHVybiBhfXZhciBUPXtSZWFjdEN1cnJlbnREaXNwYXRjaGVyOlIsUmVhY3RDdXJyZW50QmF0Y2hDb25maWc6e3RyYW5zaXRpb246MH0sUmVhY3RDdXJyZW50T3duZXI6RyxJc1NvbWVSZW5kZXJlckFjdGluZzp7Y3VycmVudDohMX0sYXNzaWduOmx9O1xuZXhwb3J0cy5DaGlsZHJlbj17bWFwOlAsZm9yRWFjaDpmdW5jdGlvbihhLGIsYyl7UChhLGZ1bmN0aW9uKCl7Yi5hcHBseSh0aGlzLGFyZ3VtZW50cyl9LGMpfSxjb3VudDpmdW5jdGlvbihhKXt2YXIgYj0wO1AoYSxmdW5jdGlvbigpe2IrK30pO3JldHVybiBifSx0b0FycmF5OmZ1bmN0aW9uKGEpe3JldHVybiBQKGEsZnVuY3Rpb24oYSl7cmV0dXJuIGF9KXx8W119LG9ubHk6ZnVuY3Rpb24oYSl7aWYoIUwoYSkpdGhyb3cgRXJyb3IoeigxNDMpKTtyZXR1cm4gYX19O2V4cG9ydHMuQ29tcG9uZW50PUM7ZXhwb3J0cy5QdXJlQ29tcG9uZW50PUU7ZXhwb3J0cy5fX1NFQ1JFVF9JTlRFUk5BTFNfRE9fTk9UX1VTRV9PUl9ZT1VfV0lMTF9CRV9GSVJFRD1UO1xuZXhwb3J0cy5jbG9uZUVsZW1lbnQ9ZnVuY3Rpb24oYSxiLGMpe2lmKG51bGw9PT1hfHx2b2lkIDA9PT1hKXRocm93IEVycm9yKHooMjY3LGEpKTt2YXIgZT1sKHt9LGEucHJvcHMpLGQ9YS5rZXksaz1hLnJlZixoPWEuX293bmVyO2lmKG51bGwhPWIpe3ZvaWQgMCE9PWIucmVmJiYoaz1iLnJlZixoPUcuY3VycmVudCk7dm9pZCAwIT09Yi5rZXkmJihkPVwiXCIrYi5rZXkpO2lmKGEudHlwZSYmYS50eXBlLmRlZmF1bHRQcm9wcyl2YXIgZz1hLnR5cGUuZGVmYXVsdFByb3BzO2ZvcihmIGluIGIpSC5jYWxsKGIsZikmJiFJLmhhc093blByb3BlcnR5KGYpJiYoZVtmXT12b2lkIDA9PT1iW2ZdJiZ2b2lkIDAhPT1nP2dbZl06YltmXSl9dmFyIGY9YXJndW1lbnRzLmxlbmd0aC0yO2lmKDE9PT1mKWUuY2hpbGRyZW49YztlbHNlIGlmKDE8Zil7Zz1BcnJheShmKTtmb3IodmFyIG09MDttPGY7bSsrKWdbbV09YXJndW1lbnRzW20rMl07ZS5jaGlsZHJlbj1nfXJldHVybnskJHR5cGVvZjpuLHR5cGU6YS50eXBlLFxua2V5OmQscmVmOmsscHJvcHM6ZSxfb3duZXI6aH19O2V4cG9ydHMuY3JlYXRlQ29udGV4dD1mdW5jdGlvbihhLGIpe3ZvaWQgMD09PWImJihiPW51bGwpO2E9eyQkdHlwZW9mOnIsX2NhbGN1bGF0ZUNoYW5nZWRCaXRzOmIsX2N1cnJlbnRWYWx1ZTphLF9jdXJyZW50VmFsdWUyOmEsX3RocmVhZENvdW50OjAsUHJvdmlkZXI6bnVsbCxDb25zdW1lcjpudWxsfTthLlByb3ZpZGVyPXskJHR5cGVvZjpxLF9jb250ZXh0OmF9O3JldHVybiBhLkNvbnN1bWVyPWF9O2V4cG9ydHMuY3JlYXRlRWxlbWVudD1KO2V4cG9ydHMuY3JlYXRlRmFjdG9yeT1mdW5jdGlvbihhKXt2YXIgYj1KLmJpbmQobnVsbCxhKTtiLnR5cGU9YTtyZXR1cm4gYn07ZXhwb3J0cy5jcmVhdGVSZWY9ZnVuY3Rpb24oKXtyZXR1cm57Y3VycmVudDpudWxsfX07ZXhwb3J0cy5mb3J3YXJkUmVmPWZ1bmN0aW9uKGEpe3JldHVybnskJHR5cGVvZjp0LHJlbmRlcjphfX07ZXhwb3J0cy5pc1ZhbGlkRWxlbWVudD1MO1xuZXhwb3J0cy5sYXp5PWZ1bmN0aW9uKGEpe3JldHVybnskJHR5cGVvZjp2LF9wYXlsb2FkOntfc3RhdHVzOi0xLF9yZXN1bHQ6YX0sX2luaXQ6UX19O2V4cG9ydHMubWVtbz1mdW5jdGlvbihhLGIpe3JldHVybnskJHR5cGVvZjp1LHR5cGU6YSxjb21wYXJlOnZvaWQgMD09PWI/bnVsbDpifX07ZXhwb3J0cy51c2VDYWxsYmFjaz1mdW5jdGlvbihhLGIpe3JldHVybiBTKCkudXNlQ2FsbGJhY2soYSxiKX07ZXhwb3J0cy51c2VDb250ZXh0PWZ1bmN0aW9uKGEsYil7cmV0dXJuIFMoKS51c2VDb250ZXh0KGEsYil9O2V4cG9ydHMudXNlRGVidWdWYWx1ZT1mdW5jdGlvbigpe307ZXhwb3J0cy51c2VFZmZlY3Q9ZnVuY3Rpb24oYSxiKXtyZXR1cm4gUygpLnVzZUVmZmVjdChhLGIpfTtleHBvcnRzLnVzZUltcGVyYXRpdmVIYW5kbGU9ZnVuY3Rpb24oYSxiLGMpe3JldHVybiBTKCkudXNlSW1wZXJhdGl2ZUhhbmRsZShhLGIsYyl9O1xuZXhwb3J0cy51c2VMYXlvdXRFZmZlY3Q9ZnVuY3Rpb24oYSxiKXtyZXR1cm4gUygpLnVzZUxheW91dEVmZmVjdChhLGIpfTtleHBvcnRzLnVzZU1lbW89ZnVuY3Rpb24oYSxiKXtyZXR1cm4gUygpLnVzZU1lbW8oYSxiKX07ZXhwb3J0cy51c2VSZWR1Y2VyPWZ1bmN0aW9uKGEsYixjKXtyZXR1cm4gUygpLnVzZVJlZHVjZXIoYSxiLGMpfTtleHBvcnRzLnVzZVJlZj1mdW5jdGlvbihhKXtyZXR1cm4gUygpLnVzZVJlZihhKX07ZXhwb3J0cy51c2VTdGF0ZT1mdW5jdGlvbihhKXtyZXR1cm4gUygpLnVzZVN0YXRlKGEpfTtleHBvcnRzLnZlcnNpb249XCIxNy4wLjJcIjtcbiIsIi8qKiBAbGljZW5zZSBSZWFjdCB2MTcuMC4yXG4gKiByZWFjdC1kb20ucHJvZHVjdGlvbi5taW4uanNcbiAqXG4gKiBDb3B5cmlnaHQgKGMpIEZhY2Vib29rLCBJbmMuIGFuZCBpdHMgYWZmaWxpYXRlcy5cbiAqXG4gKiBUaGlzIHNvdXJjZSBjb2RlIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBNSVQgbGljZW5zZSBmb3VuZCBpbiB0aGVcbiAqIExJQ0VOU0UgZmlsZSBpbiB0aGUgcm9vdCBkaXJlY3Rvcnkgb2YgdGhpcyBzb3VyY2UgdHJlZS5cbiAqL1xuLypcbiBNb2Rlcm5penIgMy4wLjBwcmUgKEN1c3RvbSBCdWlsZCkgfCBNSVRcbiovXG4ndXNlIHN0cmljdCc7dmFyIGFhPXJlcXVpcmUoXCJyZWFjdFwiKSxtPXJlcXVpcmUoXCJvYmplY3QtYXNzaWduXCIpLHI9cmVxdWlyZShcInNjaGVkdWxlclwiKTtmdW5jdGlvbiB5KGEpe2Zvcih2YXIgYj1cImh0dHBzOi8vcmVhY3Rqcy5vcmcvZG9jcy9lcnJvci1kZWNvZGVyLmh0bWw/aW52YXJpYW50PVwiK2EsYz0xO2M8YXJndW1lbnRzLmxlbmd0aDtjKyspYis9XCImYXJnc1tdPVwiK2VuY29kZVVSSUNvbXBvbmVudChhcmd1bWVudHNbY10pO3JldHVyblwiTWluaWZpZWQgUmVhY3QgZXJyb3IgI1wiK2ErXCI7IHZpc2l0IFwiK2IrXCIgZm9yIHRoZSBmdWxsIG1lc3NhZ2Ugb3IgdXNlIHRoZSBub24tbWluaWZpZWQgZGV2IGVudmlyb25tZW50IGZvciBmdWxsIGVycm9ycyBhbmQgYWRkaXRpb25hbCBoZWxwZnVsIHdhcm5pbmdzLlwifWlmKCFhYSl0aHJvdyBFcnJvcih5KDIyNykpO3ZhciBiYT1uZXcgU2V0LGNhPXt9O2Z1bmN0aW9uIGRhKGEsYil7ZWEoYSxiKTtlYShhK1wiQ2FwdHVyZVwiLGIpfVxuZnVuY3Rpb24gZWEoYSxiKXtjYVthXT1iO2ZvcihhPTA7YTxiLmxlbmd0aDthKyspYmEuYWRkKGJbYV0pfVxudmFyIGZhPSEoXCJ1bmRlZmluZWRcIj09PXR5cGVvZiB3aW5kb3d8fFwidW5kZWZpbmVkXCI9PT10eXBlb2Ygd2luZG93LmRvY3VtZW50fHxcInVuZGVmaW5lZFwiPT09dHlwZW9mIHdpbmRvdy5kb2N1bWVudC5jcmVhdGVFbGVtZW50KSxoYT0vXls6QS1aX2EtelxcdTAwQzAtXFx1MDBENlxcdTAwRDgtXFx1MDBGNlxcdTAwRjgtXFx1MDJGRlxcdTAzNzAtXFx1MDM3RFxcdTAzN0YtXFx1MUZGRlxcdTIwMEMtXFx1MjAwRFxcdTIwNzAtXFx1MjE4RlxcdTJDMDAtXFx1MkZFRlxcdTMwMDEtXFx1RDdGRlxcdUY5MDAtXFx1RkRDRlxcdUZERjAtXFx1RkZGRF1bOkEtWl9hLXpcXHUwMEMwLVxcdTAwRDZcXHUwMEQ4LVxcdTAwRjZcXHUwMEY4LVxcdTAyRkZcXHUwMzcwLVxcdTAzN0RcXHUwMzdGLVxcdTFGRkZcXHUyMDBDLVxcdTIwMERcXHUyMDcwLVxcdTIxOEZcXHUyQzAwLVxcdTJGRUZcXHUzMDAxLVxcdUQ3RkZcXHVGOTAwLVxcdUZEQ0ZcXHVGREYwLVxcdUZGRkRcXC0uMC05XFx1MDBCN1xcdTAzMDAtXFx1MDM2RlxcdTIwM0YtXFx1MjA0MF0qJC8saWE9T2JqZWN0LnByb3RvdHlwZS5oYXNPd25Qcm9wZXJ0eSxcbmphPXt9LGthPXt9O2Z1bmN0aW9uIGxhKGEpe2lmKGlhLmNhbGwoa2EsYSkpcmV0dXJuITA7aWYoaWEuY2FsbChqYSxhKSlyZXR1cm4hMTtpZihoYS50ZXN0KGEpKXJldHVybiBrYVthXT0hMDtqYVthXT0hMDtyZXR1cm4hMX1mdW5jdGlvbiBtYShhLGIsYyxkKXtpZihudWxsIT09YyYmMD09PWMudHlwZSlyZXR1cm4hMTtzd2l0Y2godHlwZW9mIGIpe2Nhc2UgXCJmdW5jdGlvblwiOmNhc2UgXCJzeW1ib2xcIjpyZXR1cm4hMDtjYXNlIFwiYm9vbGVhblwiOmlmKGQpcmV0dXJuITE7aWYobnVsbCE9PWMpcmV0dXJuIWMuYWNjZXB0c0Jvb2xlYW5zO2E9YS50b0xvd2VyQ2FzZSgpLnNsaWNlKDAsNSk7cmV0dXJuXCJkYXRhLVwiIT09YSYmXCJhcmlhLVwiIT09YTtkZWZhdWx0OnJldHVybiExfX1cbmZ1bmN0aW9uIG5hKGEsYixjLGQpe2lmKG51bGw9PT1ifHxcInVuZGVmaW5lZFwiPT09dHlwZW9mIGJ8fG1hKGEsYixjLGQpKXJldHVybiEwO2lmKGQpcmV0dXJuITE7aWYobnVsbCE9PWMpc3dpdGNoKGMudHlwZSl7Y2FzZSAzOnJldHVybiFiO2Nhc2UgNDpyZXR1cm4hMT09PWI7Y2FzZSA1OnJldHVybiBpc05hTihiKTtjYXNlIDY6cmV0dXJuIGlzTmFOKGIpfHwxPmJ9cmV0dXJuITF9ZnVuY3Rpb24gQihhLGIsYyxkLGUsZixnKXt0aGlzLmFjY2VwdHNCb29sZWFucz0yPT09Ynx8Mz09PWJ8fDQ9PT1iO3RoaXMuYXR0cmlidXRlTmFtZT1kO3RoaXMuYXR0cmlidXRlTmFtZXNwYWNlPWU7dGhpcy5tdXN0VXNlUHJvcGVydHk9Yzt0aGlzLnByb3BlcnR5TmFtZT1hO3RoaXMudHlwZT1iO3RoaXMuc2FuaXRpemVVUkw9Zjt0aGlzLnJlbW92ZUVtcHR5U3RyaW5nPWd9dmFyIEQ9e307XG5cImNoaWxkcmVuIGRhbmdlcm91c2x5U2V0SW5uZXJIVE1MIGRlZmF1bHRWYWx1ZSBkZWZhdWx0Q2hlY2tlZCBpbm5lckhUTUwgc3VwcHJlc3NDb250ZW50RWRpdGFibGVXYXJuaW5nIHN1cHByZXNzSHlkcmF0aW9uV2FybmluZyBzdHlsZVwiLnNwbGl0KFwiIFwiKS5mb3JFYWNoKGZ1bmN0aW9uKGEpe0RbYV09bmV3IEIoYSwwLCExLGEsbnVsbCwhMSwhMSl9KTtbW1wiYWNjZXB0Q2hhcnNldFwiLFwiYWNjZXB0LWNoYXJzZXRcIl0sW1wiY2xhc3NOYW1lXCIsXCJjbGFzc1wiXSxbXCJodG1sRm9yXCIsXCJmb3JcIl0sW1wiaHR0cEVxdWl2XCIsXCJodHRwLWVxdWl2XCJdXS5mb3JFYWNoKGZ1bmN0aW9uKGEpe3ZhciBiPWFbMF07RFtiXT1uZXcgQihiLDEsITEsYVsxXSxudWxsLCExLCExKX0pO1tcImNvbnRlbnRFZGl0YWJsZVwiLFwiZHJhZ2dhYmxlXCIsXCJzcGVsbENoZWNrXCIsXCJ2YWx1ZVwiXS5mb3JFYWNoKGZ1bmN0aW9uKGEpe0RbYV09bmV3IEIoYSwyLCExLGEudG9Mb3dlckNhc2UoKSxudWxsLCExLCExKX0pO1xuW1wiYXV0b1JldmVyc2VcIixcImV4dGVybmFsUmVzb3VyY2VzUmVxdWlyZWRcIixcImZvY3VzYWJsZVwiLFwicHJlc2VydmVBbHBoYVwiXS5mb3JFYWNoKGZ1bmN0aW9uKGEpe0RbYV09bmV3IEIoYSwyLCExLGEsbnVsbCwhMSwhMSl9KTtcImFsbG93RnVsbFNjcmVlbiBhc3luYyBhdXRvRm9jdXMgYXV0b1BsYXkgY29udHJvbHMgZGVmYXVsdCBkZWZlciBkaXNhYmxlZCBkaXNhYmxlUGljdHVyZUluUGljdHVyZSBkaXNhYmxlUmVtb3RlUGxheWJhY2sgZm9ybU5vVmFsaWRhdGUgaGlkZGVuIGxvb3Agbm9Nb2R1bGUgbm9WYWxpZGF0ZSBvcGVuIHBsYXlzSW5saW5lIHJlYWRPbmx5IHJlcXVpcmVkIHJldmVyc2VkIHNjb3BlZCBzZWFtbGVzcyBpdGVtU2NvcGVcIi5zcGxpdChcIiBcIikuZm9yRWFjaChmdW5jdGlvbihhKXtEW2FdPW5ldyBCKGEsMywhMSxhLnRvTG93ZXJDYXNlKCksbnVsbCwhMSwhMSl9KTtcbltcImNoZWNrZWRcIixcIm11bHRpcGxlXCIsXCJtdXRlZFwiLFwic2VsZWN0ZWRcIl0uZm9yRWFjaChmdW5jdGlvbihhKXtEW2FdPW5ldyBCKGEsMywhMCxhLG51bGwsITEsITEpfSk7W1wiY2FwdHVyZVwiLFwiZG93bmxvYWRcIl0uZm9yRWFjaChmdW5jdGlvbihhKXtEW2FdPW5ldyBCKGEsNCwhMSxhLG51bGwsITEsITEpfSk7W1wiY29sc1wiLFwicm93c1wiLFwic2l6ZVwiLFwic3BhblwiXS5mb3JFYWNoKGZ1bmN0aW9uKGEpe0RbYV09bmV3IEIoYSw2LCExLGEsbnVsbCwhMSwhMSl9KTtbXCJyb3dTcGFuXCIsXCJzdGFydFwiXS5mb3JFYWNoKGZ1bmN0aW9uKGEpe0RbYV09bmV3IEIoYSw1LCExLGEudG9Mb3dlckNhc2UoKSxudWxsLCExLCExKX0pO3ZhciBvYT0vW1xcLTpdKFthLXpdKS9nO2Z1bmN0aW9uIHBhKGEpe3JldHVybiBhWzFdLnRvVXBwZXJDYXNlKCl9XG5cImFjY2VudC1oZWlnaHQgYWxpZ25tZW50LWJhc2VsaW5lIGFyYWJpYy1mb3JtIGJhc2VsaW5lLXNoaWZ0IGNhcC1oZWlnaHQgY2xpcC1wYXRoIGNsaXAtcnVsZSBjb2xvci1pbnRlcnBvbGF0aW9uIGNvbG9yLWludGVycG9sYXRpb24tZmlsdGVycyBjb2xvci1wcm9maWxlIGNvbG9yLXJlbmRlcmluZyBkb21pbmFudC1iYXNlbGluZSBlbmFibGUtYmFja2dyb3VuZCBmaWxsLW9wYWNpdHkgZmlsbC1ydWxlIGZsb29kLWNvbG9yIGZsb29kLW9wYWNpdHkgZm9udC1mYW1pbHkgZm9udC1zaXplIGZvbnQtc2l6ZS1hZGp1c3QgZm9udC1zdHJldGNoIGZvbnQtc3R5bGUgZm9udC12YXJpYW50IGZvbnQtd2VpZ2h0IGdseXBoLW5hbWUgZ2x5cGgtb3JpZW50YXRpb24taG9yaXpvbnRhbCBnbHlwaC1vcmllbnRhdGlvbi12ZXJ0aWNhbCBob3Jpei1hZHYteCBob3Jpei1vcmlnaW4teCBpbWFnZS1yZW5kZXJpbmcgbGV0dGVyLXNwYWNpbmcgbGlnaHRpbmctY29sb3IgbWFya2VyLWVuZCBtYXJrZXItbWlkIG1hcmtlci1zdGFydCBvdmVybGluZS1wb3NpdGlvbiBvdmVybGluZS10aGlja25lc3MgcGFpbnQtb3JkZXIgcGFub3NlLTEgcG9pbnRlci1ldmVudHMgcmVuZGVyaW5nLWludGVudCBzaGFwZS1yZW5kZXJpbmcgc3RvcC1jb2xvciBzdG9wLW9wYWNpdHkgc3RyaWtldGhyb3VnaC1wb3NpdGlvbiBzdHJpa2V0aHJvdWdoLXRoaWNrbmVzcyBzdHJva2UtZGFzaGFycmF5IHN0cm9rZS1kYXNob2Zmc2V0IHN0cm9rZS1saW5lY2FwIHN0cm9rZS1saW5lam9pbiBzdHJva2UtbWl0ZXJsaW1pdCBzdHJva2Utb3BhY2l0eSBzdHJva2Utd2lkdGggdGV4dC1hbmNob3IgdGV4dC1kZWNvcmF0aW9uIHRleHQtcmVuZGVyaW5nIHVuZGVybGluZS1wb3NpdGlvbiB1bmRlcmxpbmUtdGhpY2tuZXNzIHVuaWNvZGUtYmlkaSB1bmljb2RlLXJhbmdlIHVuaXRzLXBlci1lbSB2LWFscGhhYmV0aWMgdi1oYW5naW5nIHYtaWRlb2dyYXBoaWMgdi1tYXRoZW1hdGljYWwgdmVjdG9yLWVmZmVjdCB2ZXJ0LWFkdi15IHZlcnQtb3JpZ2luLXggdmVydC1vcmlnaW4teSB3b3JkLXNwYWNpbmcgd3JpdGluZy1tb2RlIHhtbG5zOnhsaW5rIHgtaGVpZ2h0XCIuc3BsaXQoXCIgXCIpLmZvckVhY2goZnVuY3Rpb24oYSl7dmFyIGI9YS5yZXBsYWNlKG9hLFxucGEpO0RbYl09bmV3IEIoYiwxLCExLGEsbnVsbCwhMSwhMSl9KTtcInhsaW5rOmFjdHVhdGUgeGxpbms6YXJjcm9sZSB4bGluazpyb2xlIHhsaW5rOnNob3cgeGxpbms6dGl0bGUgeGxpbms6dHlwZVwiLnNwbGl0KFwiIFwiKS5mb3JFYWNoKGZ1bmN0aW9uKGEpe3ZhciBiPWEucmVwbGFjZShvYSxwYSk7RFtiXT1uZXcgQihiLDEsITEsYSxcImh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmtcIiwhMSwhMSl9KTtbXCJ4bWw6YmFzZVwiLFwieG1sOmxhbmdcIixcInhtbDpzcGFjZVwiXS5mb3JFYWNoKGZ1bmN0aW9uKGEpe3ZhciBiPWEucmVwbGFjZShvYSxwYSk7RFtiXT1uZXcgQihiLDEsITEsYSxcImh0dHA6Ly93d3cudzMub3JnL1hNTC8xOTk4L25hbWVzcGFjZVwiLCExLCExKX0pO1tcInRhYkluZGV4XCIsXCJjcm9zc09yaWdpblwiXS5mb3JFYWNoKGZ1bmN0aW9uKGEpe0RbYV09bmV3IEIoYSwxLCExLGEudG9Mb3dlckNhc2UoKSxudWxsLCExLCExKX0pO1xuRC54bGlua0hyZWY9bmV3IEIoXCJ4bGlua0hyZWZcIiwxLCExLFwieGxpbms6aHJlZlwiLFwiaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGlua1wiLCEwLCExKTtbXCJzcmNcIixcImhyZWZcIixcImFjdGlvblwiLFwiZm9ybUFjdGlvblwiXS5mb3JFYWNoKGZ1bmN0aW9uKGEpe0RbYV09bmV3IEIoYSwxLCExLGEudG9Mb3dlckNhc2UoKSxudWxsLCEwLCEwKX0pO1xuZnVuY3Rpb24gcWEoYSxiLGMsZCl7dmFyIGU9RC5oYXNPd25Qcm9wZXJ0eShiKT9EW2JdOm51bGw7dmFyIGY9bnVsbCE9PWU/MD09PWUudHlwZTpkPyExOiEoMjxiLmxlbmd0aCl8fFwib1wiIT09YlswXSYmXCJPXCIhPT1iWzBdfHxcIm5cIiE9PWJbMV0mJlwiTlwiIT09YlsxXT8hMTohMDtmfHwobmEoYixjLGUsZCkmJihjPW51bGwpLGR8fG51bGw9PT1lP2xhKGIpJiYobnVsbD09PWM/YS5yZW1vdmVBdHRyaWJ1dGUoYik6YS5zZXRBdHRyaWJ1dGUoYixcIlwiK2MpKTplLm11c3RVc2VQcm9wZXJ0eT9hW2UucHJvcGVydHlOYW1lXT1udWxsPT09Yz8zPT09ZS50eXBlPyExOlwiXCI6YzooYj1lLmF0dHJpYnV0ZU5hbWUsZD1lLmF0dHJpYnV0ZU5hbWVzcGFjZSxudWxsPT09Yz9hLnJlbW92ZUF0dHJpYnV0ZShiKTooZT1lLnR5cGUsYz0zPT09ZXx8ND09PWUmJiEwPT09Yz9cIlwiOlwiXCIrYyxkP2Euc2V0QXR0cmlidXRlTlMoZCxiLGMpOmEuc2V0QXR0cmlidXRlKGIsYykpKSl9XG52YXIgcmE9YWEuX19TRUNSRVRfSU5URVJOQUxTX0RPX05PVF9VU0VfT1JfWU9VX1dJTExfQkVfRklSRUQsc2E9NjAxMDMsdGE9NjAxMDYsdWE9NjAxMDcsd2E9NjAxMDgseGE9NjAxMTQseWE9NjAxMDksemE9NjAxMTAsQWE9NjAxMTIsQmE9NjAxMTMsQ2E9NjAxMjAsRGE9NjAxMTUsRWE9NjAxMTYsRmE9NjAxMjEsR2E9NjAxMjgsSGE9NjAxMjksSWE9NjAxMzAsSmE9NjAxMzE7XG5pZihcImZ1bmN0aW9uXCI9PT10eXBlb2YgU3ltYm9sJiZTeW1ib2wuZm9yKXt2YXIgRT1TeW1ib2wuZm9yO3NhPUUoXCJyZWFjdC5lbGVtZW50XCIpO3RhPUUoXCJyZWFjdC5wb3J0YWxcIik7dWE9RShcInJlYWN0LmZyYWdtZW50XCIpO3dhPUUoXCJyZWFjdC5zdHJpY3RfbW9kZVwiKTt4YT1FKFwicmVhY3QucHJvZmlsZXJcIik7eWE9RShcInJlYWN0LnByb3ZpZGVyXCIpO3phPUUoXCJyZWFjdC5jb250ZXh0XCIpO0FhPUUoXCJyZWFjdC5mb3J3YXJkX3JlZlwiKTtCYT1FKFwicmVhY3Quc3VzcGVuc2VcIik7Q2E9RShcInJlYWN0LnN1c3BlbnNlX2xpc3RcIik7RGE9RShcInJlYWN0Lm1lbW9cIik7RWE9RShcInJlYWN0LmxhenlcIik7RmE9RShcInJlYWN0LmJsb2NrXCIpO0UoXCJyZWFjdC5zY29wZVwiKTtHYT1FKFwicmVhY3Qub3BhcXVlLmlkXCIpO0hhPUUoXCJyZWFjdC5kZWJ1Z190cmFjZV9tb2RlXCIpO0lhPUUoXCJyZWFjdC5vZmZzY3JlZW5cIik7SmE9RShcInJlYWN0LmxlZ2FjeV9oaWRkZW5cIil9XG52YXIgS2E9XCJmdW5jdGlvblwiPT09dHlwZW9mIFN5bWJvbCYmU3ltYm9sLml0ZXJhdG9yO2Z1bmN0aW9uIExhKGEpe2lmKG51bGw9PT1hfHxcIm9iamVjdFwiIT09dHlwZW9mIGEpcmV0dXJuIG51bGw7YT1LYSYmYVtLYV18fGFbXCJAQGl0ZXJhdG9yXCJdO3JldHVyblwiZnVuY3Rpb25cIj09PXR5cGVvZiBhP2E6bnVsbH12YXIgTWE7ZnVuY3Rpb24gTmEoYSl7aWYodm9pZCAwPT09TWEpdHJ5e3Rocm93IEVycm9yKCk7fWNhdGNoKGMpe3ZhciBiPWMuc3RhY2sudHJpbSgpLm1hdGNoKC9cXG4oICooYXQgKT8pLyk7TWE9YiYmYlsxXXx8XCJcIn1yZXR1cm5cIlxcblwiK01hK2F9dmFyIE9hPSExO1xuZnVuY3Rpb24gUGEoYSxiKXtpZighYXx8T2EpcmV0dXJuXCJcIjtPYT0hMDt2YXIgYz1FcnJvci5wcmVwYXJlU3RhY2tUcmFjZTtFcnJvci5wcmVwYXJlU3RhY2tUcmFjZT12b2lkIDA7dHJ5e2lmKGIpaWYoYj1mdW5jdGlvbigpe3Rocm93IEVycm9yKCk7fSxPYmplY3QuZGVmaW5lUHJvcGVydHkoYi5wcm90b3R5cGUsXCJwcm9wc1wiLHtzZXQ6ZnVuY3Rpb24oKXt0aHJvdyBFcnJvcigpO319KSxcIm9iamVjdFwiPT09dHlwZW9mIFJlZmxlY3QmJlJlZmxlY3QuY29uc3RydWN0KXt0cnl7UmVmbGVjdC5jb25zdHJ1Y3QoYixbXSl9Y2F0Y2goayl7dmFyIGQ9a31SZWZsZWN0LmNvbnN0cnVjdChhLFtdLGIpfWVsc2V7dHJ5e2IuY2FsbCgpfWNhdGNoKGspe2Q9a31hLmNhbGwoYi5wcm90b3R5cGUpfWVsc2V7dHJ5e3Rocm93IEVycm9yKCk7fWNhdGNoKGspe2Q9a31hKCl9fWNhdGNoKGspe2lmKGsmJmQmJlwic3RyaW5nXCI9PT10eXBlb2Ygay5zdGFjayl7Zm9yKHZhciBlPWsuc3RhY2suc3BsaXQoXCJcXG5cIiksXG5mPWQuc3RhY2suc3BsaXQoXCJcXG5cIiksZz1lLmxlbmd0aC0xLGg9Zi5sZW5ndGgtMTsxPD1nJiYwPD1oJiZlW2ddIT09ZltoXTspaC0tO2Zvcig7MTw9ZyYmMDw9aDtnLS0saC0tKWlmKGVbZ10hPT1mW2hdKXtpZigxIT09Z3x8MSE9PWgpe2RvIGlmKGctLSxoLS0sMD5ofHxlW2ddIT09ZltoXSlyZXR1cm5cIlxcblwiK2VbZ10ucmVwbGFjZShcIiBhdCBuZXcgXCIsXCIgYXQgXCIpO3doaWxlKDE8PWcmJjA8PWgpfWJyZWFrfX19ZmluYWxseXtPYT0hMSxFcnJvci5wcmVwYXJlU3RhY2tUcmFjZT1jfXJldHVybihhPWE/YS5kaXNwbGF5TmFtZXx8YS5uYW1lOlwiXCIpP05hKGEpOlwiXCJ9XG5mdW5jdGlvbiBRYShhKXtzd2l0Y2goYS50YWcpe2Nhc2UgNTpyZXR1cm4gTmEoYS50eXBlKTtjYXNlIDE2OnJldHVybiBOYShcIkxhenlcIik7Y2FzZSAxMzpyZXR1cm4gTmEoXCJTdXNwZW5zZVwiKTtjYXNlIDE5OnJldHVybiBOYShcIlN1c3BlbnNlTGlzdFwiKTtjYXNlIDA6Y2FzZSAyOmNhc2UgMTU6cmV0dXJuIGE9UGEoYS50eXBlLCExKSxhO2Nhc2UgMTE6cmV0dXJuIGE9UGEoYS50eXBlLnJlbmRlciwhMSksYTtjYXNlIDIyOnJldHVybiBhPVBhKGEudHlwZS5fcmVuZGVyLCExKSxhO2Nhc2UgMTpyZXR1cm4gYT1QYShhLnR5cGUsITApLGE7ZGVmYXVsdDpyZXR1cm5cIlwifX1cbmZ1bmN0aW9uIFJhKGEpe2lmKG51bGw9PWEpcmV0dXJuIG51bGw7aWYoXCJmdW5jdGlvblwiPT09dHlwZW9mIGEpcmV0dXJuIGEuZGlzcGxheU5hbWV8fGEubmFtZXx8bnVsbDtpZihcInN0cmluZ1wiPT09dHlwZW9mIGEpcmV0dXJuIGE7c3dpdGNoKGEpe2Nhc2UgdWE6cmV0dXJuXCJGcmFnbWVudFwiO2Nhc2UgdGE6cmV0dXJuXCJQb3J0YWxcIjtjYXNlIHhhOnJldHVyblwiUHJvZmlsZXJcIjtjYXNlIHdhOnJldHVyblwiU3RyaWN0TW9kZVwiO2Nhc2UgQmE6cmV0dXJuXCJTdXNwZW5zZVwiO2Nhc2UgQ2E6cmV0dXJuXCJTdXNwZW5zZUxpc3RcIn1pZihcIm9iamVjdFwiPT09dHlwZW9mIGEpc3dpdGNoKGEuJCR0eXBlb2Ype2Nhc2UgemE6cmV0dXJuKGEuZGlzcGxheU5hbWV8fFwiQ29udGV4dFwiKStcIi5Db25zdW1lclwiO2Nhc2UgeWE6cmV0dXJuKGEuX2NvbnRleHQuZGlzcGxheU5hbWV8fFwiQ29udGV4dFwiKStcIi5Qcm92aWRlclwiO2Nhc2UgQWE6dmFyIGI9YS5yZW5kZXI7Yj1iLmRpc3BsYXlOYW1lfHxiLm5hbWV8fFwiXCI7XG5yZXR1cm4gYS5kaXNwbGF5TmFtZXx8KFwiXCIhPT1iP1wiRm9yd2FyZFJlZihcIitiK1wiKVwiOlwiRm9yd2FyZFJlZlwiKTtjYXNlIERhOnJldHVybiBSYShhLnR5cGUpO2Nhc2UgRmE6cmV0dXJuIFJhKGEuX3JlbmRlcik7Y2FzZSBFYTpiPWEuX3BheWxvYWQ7YT1hLl9pbml0O3RyeXtyZXR1cm4gUmEoYShiKSl9Y2F0Y2goYyl7fX1yZXR1cm4gbnVsbH1mdW5jdGlvbiBTYShhKXtzd2l0Y2godHlwZW9mIGEpe2Nhc2UgXCJib29sZWFuXCI6Y2FzZSBcIm51bWJlclwiOmNhc2UgXCJvYmplY3RcIjpjYXNlIFwic3RyaW5nXCI6Y2FzZSBcInVuZGVmaW5lZFwiOnJldHVybiBhO2RlZmF1bHQ6cmV0dXJuXCJcIn19ZnVuY3Rpb24gVGEoYSl7dmFyIGI9YS50eXBlO3JldHVybihhPWEubm9kZU5hbWUpJiZcImlucHV0XCI9PT1hLnRvTG93ZXJDYXNlKCkmJihcImNoZWNrYm94XCI9PT1ifHxcInJhZGlvXCI9PT1iKX1cbmZ1bmN0aW9uIFVhKGEpe3ZhciBiPVRhKGEpP1wiY2hlY2tlZFwiOlwidmFsdWVcIixjPU9iamVjdC5nZXRPd25Qcm9wZXJ0eURlc2NyaXB0b3IoYS5jb25zdHJ1Y3Rvci5wcm90b3R5cGUsYiksZD1cIlwiK2FbYl07aWYoIWEuaGFzT3duUHJvcGVydHkoYikmJlwidW5kZWZpbmVkXCIhPT10eXBlb2YgYyYmXCJmdW5jdGlvblwiPT09dHlwZW9mIGMuZ2V0JiZcImZ1bmN0aW9uXCI9PT10eXBlb2YgYy5zZXQpe3ZhciBlPWMuZ2V0LGY9Yy5zZXQ7T2JqZWN0LmRlZmluZVByb3BlcnR5KGEsYix7Y29uZmlndXJhYmxlOiEwLGdldDpmdW5jdGlvbigpe3JldHVybiBlLmNhbGwodGhpcyl9LHNldDpmdW5jdGlvbihhKXtkPVwiXCIrYTtmLmNhbGwodGhpcyxhKX19KTtPYmplY3QuZGVmaW5lUHJvcGVydHkoYSxiLHtlbnVtZXJhYmxlOmMuZW51bWVyYWJsZX0pO3JldHVybntnZXRWYWx1ZTpmdW5jdGlvbigpe3JldHVybiBkfSxzZXRWYWx1ZTpmdW5jdGlvbihhKXtkPVwiXCIrYX0sc3RvcFRyYWNraW5nOmZ1bmN0aW9uKCl7YS5fdmFsdWVUcmFja2VyPVxubnVsbDtkZWxldGUgYVtiXX19fX1mdW5jdGlvbiBWYShhKXthLl92YWx1ZVRyYWNrZXJ8fChhLl92YWx1ZVRyYWNrZXI9VWEoYSkpfWZ1bmN0aW9uIFdhKGEpe2lmKCFhKXJldHVybiExO3ZhciBiPWEuX3ZhbHVlVHJhY2tlcjtpZighYilyZXR1cm4hMDt2YXIgYz1iLmdldFZhbHVlKCk7dmFyIGQ9XCJcIjthJiYoZD1UYShhKT9hLmNoZWNrZWQ/XCJ0cnVlXCI6XCJmYWxzZVwiOmEudmFsdWUpO2E9ZDtyZXR1cm4gYSE9PWM/KGIuc2V0VmFsdWUoYSksITApOiExfWZ1bmN0aW9uIFhhKGEpe2E9YXx8KFwidW5kZWZpbmVkXCIhPT10eXBlb2YgZG9jdW1lbnQ/ZG9jdW1lbnQ6dm9pZCAwKTtpZihcInVuZGVmaW5lZFwiPT09dHlwZW9mIGEpcmV0dXJuIG51bGw7dHJ5e3JldHVybiBhLmFjdGl2ZUVsZW1lbnR8fGEuYm9keX1jYXRjaChiKXtyZXR1cm4gYS5ib2R5fX1cbmZ1bmN0aW9uIFlhKGEsYil7dmFyIGM9Yi5jaGVja2VkO3JldHVybiBtKHt9LGIse2RlZmF1bHRDaGVja2VkOnZvaWQgMCxkZWZhdWx0VmFsdWU6dm9pZCAwLHZhbHVlOnZvaWQgMCxjaGVja2VkOm51bGwhPWM/YzphLl93cmFwcGVyU3RhdGUuaW5pdGlhbENoZWNrZWR9KX1mdW5jdGlvbiBaYShhLGIpe3ZhciBjPW51bGw9PWIuZGVmYXVsdFZhbHVlP1wiXCI6Yi5kZWZhdWx0VmFsdWUsZD1udWxsIT1iLmNoZWNrZWQ/Yi5jaGVja2VkOmIuZGVmYXVsdENoZWNrZWQ7Yz1TYShudWxsIT1iLnZhbHVlP2IudmFsdWU6Yyk7YS5fd3JhcHBlclN0YXRlPXtpbml0aWFsQ2hlY2tlZDpkLGluaXRpYWxWYWx1ZTpjLGNvbnRyb2xsZWQ6XCJjaGVja2JveFwiPT09Yi50eXBlfHxcInJhZGlvXCI9PT1iLnR5cGU/bnVsbCE9Yi5jaGVja2VkOm51bGwhPWIudmFsdWV9fWZ1bmN0aW9uICRhKGEsYil7Yj1iLmNoZWNrZWQ7bnVsbCE9YiYmcWEoYSxcImNoZWNrZWRcIixiLCExKX1cbmZ1bmN0aW9uIGFiKGEsYil7JGEoYSxiKTt2YXIgYz1TYShiLnZhbHVlKSxkPWIudHlwZTtpZihudWxsIT1jKWlmKFwibnVtYmVyXCI9PT1kKXtpZigwPT09YyYmXCJcIj09PWEudmFsdWV8fGEudmFsdWUhPWMpYS52YWx1ZT1cIlwiK2N9ZWxzZSBhLnZhbHVlIT09XCJcIitjJiYoYS52YWx1ZT1cIlwiK2MpO2Vsc2UgaWYoXCJzdWJtaXRcIj09PWR8fFwicmVzZXRcIj09PWQpe2EucmVtb3ZlQXR0cmlidXRlKFwidmFsdWVcIik7cmV0dXJufWIuaGFzT3duUHJvcGVydHkoXCJ2YWx1ZVwiKT9iYihhLGIudHlwZSxjKTpiLmhhc093blByb3BlcnR5KFwiZGVmYXVsdFZhbHVlXCIpJiZiYihhLGIudHlwZSxTYShiLmRlZmF1bHRWYWx1ZSkpO251bGw9PWIuY2hlY2tlZCYmbnVsbCE9Yi5kZWZhdWx0Q2hlY2tlZCYmKGEuZGVmYXVsdENoZWNrZWQ9ISFiLmRlZmF1bHRDaGVja2VkKX1cbmZ1bmN0aW9uIGNiKGEsYixjKXtpZihiLmhhc093blByb3BlcnR5KFwidmFsdWVcIil8fGIuaGFzT3duUHJvcGVydHkoXCJkZWZhdWx0VmFsdWVcIikpe3ZhciBkPWIudHlwZTtpZighKFwic3VibWl0XCIhPT1kJiZcInJlc2V0XCIhPT1kfHx2b2lkIDAhPT1iLnZhbHVlJiZudWxsIT09Yi52YWx1ZSkpcmV0dXJuO2I9XCJcIithLl93cmFwcGVyU3RhdGUuaW5pdGlhbFZhbHVlO2N8fGI9PT1hLnZhbHVlfHwoYS52YWx1ZT1iKTthLmRlZmF1bHRWYWx1ZT1ifWM9YS5uYW1lO1wiXCIhPT1jJiYoYS5uYW1lPVwiXCIpO2EuZGVmYXVsdENoZWNrZWQ9ISFhLl93cmFwcGVyU3RhdGUuaW5pdGlhbENoZWNrZWQ7XCJcIiE9PWMmJihhLm5hbWU9Yyl9XG5mdW5jdGlvbiBiYihhLGIsYyl7aWYoXCJudW1iZXJcIiE9PWJ8fFhhKGEub3duZXJEb2N1bWVudCkhPT1hKW51bGw9PWM/YS5kZWZhdWx0VmFsdWU9XCJcIithLl93cmFwcGVyU3RhdGUuaW5pdGlhbFZhbHVlOmEuZGVmYXVsdFZhbHVlIT09XCJcIitjJiYoYS5kZWZhdWx0VmFsdWU9XCJcIitjKX1mdW5jdGlvbiBkYihhKXt2YXIgYj1cIlwiO2FhLkNoaWxkcmVuLmZvckVhY2goYSxmdW5jdGlvbihhKXtudWxsIT1hJiYoYis9YSl9KTtyZXR1cm4gYn1mdW5jdGlvbiBlYihhLGIpe2E9bSh7Y2hpbGRyZW46dm9pZCAwfSxiKTtpZihiPWRiKGIuY2hpbGRyZW4pKWEuY2hpbGRyZW49YjtyZXR1cm4gYX1cbmZ1bmN0aW9uIGZiKGEsYixjLGQpe2E9YS5vcHRpb25zO2lmKGIpe2I9e307Zm9yKHZhciBlPTA7ZTxjLmxlbmd0aDtlKyspYltcIiRcIitjW2VdXT0hMDtmb3IoYz0wO2M8YS5sZW5ndGg7YysrKWU9Yi5oYXNPd25Qcm9wZXJ0eShcIiRcIithW2NdLnZhbHVlKSxhW2NdLnNlbGVjdGVkIT09ZSYmKGFbY10uc2VsZWN0ZWQ9ZSksZSYmZCYmKGFbY10uZGVmYXVsdFNlbGVjdGVkPSEwKX1lbHNle2M9XCJcIitTYShjKTtiPW51bGw7Zm9yKGU9MDtlPGEubGVuZ3RoO2UrKyl7aWYoYVtlXS52YWx1ZT09PWMpe2FbZV0uc2VsZWN0ZWQ9ITA7ZCYmKGFbZV0uZGVmYXVsdFNlbGVjdGVkPSEwKTtyZXR1cm59bnVsbCE9PWJ8fGFbZV0uZGlzYWJsZWR8fChiPWFbZV0pfW51bGwhPT1iJiYoYi5zZWxlY3RlZD0hMCl9fVxuZnVuY3Rpb24gZ2IoYSxiKXtpZihudWxsIT1iLmRhbmdlcm91c2x5U2V0SW5uZXJIVE1MKXRocm93IEVycm9yKHkoOTEpKTtyZXR1cm4gbSh7fSxiLHt2YWx1ZTp2b2lkIDAsZGVmYXVsdFZhbHVlOnZvaWQgMCxjaGlsZHJlbjpcIlwiK2EuX3dyYXBwZXJTdGF0ZS5pbml0aWFsVmFsdWV9KX1mdW5jdGlvbiBoYihhLGIpe3ZhciBjPWIudmFsdWU7aWYobnVsbD09Yyl7Yz1iLmNoaWxkcmVuO2I9Yi5kZWZhdWx0VmFsdWU7aWYobnVsbCE9Yyl7aWYobnVsbCE9Yil0aHJvdyBFcnJvcih5KDkyKSk7aWYoQXJyYXkuaXNBcnJheShjKSl7aWYoISgxPj1jLmxlbmd0aCkpdGhyb3cgRXJyb3IoeSg5MykpO2M9Y1swXX1iPWN9bnVsbD09YiYmKGI9XCJcIik7Yz1ifWEuX3dyYXBwZXJTdGF0ZT17aW5pdGlhbFZhbHVlOlNhKGMpfX1cbmZ1bmN0aW9uIGliKGEsYil7dmFyIGM9U2EoYi52YWx1ZSksZD1TYShiLmRlZmF1bHRWYWx1ZSk7bnVsbCE9YyYmKGM9XCJcIitjLGMhPT1hLnZhbHVlJiYoYS52YWx1ZT1jKSxudWxsPT1iLmRlZmF1bHRWYWx1ZSYmYS5kZWZhdWx0VmFsdWUhPT1jJiYoYS5kZWZhdWx0VmFsdWU9YykpO251bGwhPWQmJihhLmRlZmF1bHRWYWx1ZT1cIlwiK2QpfWZ1bmN0aW9uIGpiKGEpe3ZhciBiPWEudGV4dENvbnRlbnQ7Yj09PWEuX3dyYXBwZXJTdGF0ZS5pbml0aWFsVmFsdWUmJlwiXCIhPT1iJiZudWxsIT09YiYmKGEudmFsdWU9Yil9dmFyIGtiPXtodG1sOlwiaHR0cDovL3d3dy53My5vcmcvMTk5OS94aHRtbFwiLG1hdGhtbDpcImh0dHA6Ly93d3cudzMub3JnLzE5OTgvTWF0aC9NYXRoTUxcIixzdmc6XCJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2Z1wifTtcbmZ1bmN0aW9uIGxiKGEpe3N3aXRjaChhKXtjYXNlIFwic3ZnXCI6cmV0dXJuXCJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2Z1wiO2Nhc2UgXCJtYXRoXCI6cmV0dXJuXCJodHRwOi8vd3d3LnczLm9yZy8xOTk4L01hdGgvTWF0aE1MXCI7ZGVmYXVsdDpyZXR1cm5cImh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWxcIn19ZnVuY3Rpb24gbWIoYSxiKXtyZXR1cm4gbnVsbD09YXx8XCJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hodG1sXCI9PT1hP2xiKGIpOlwiaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmdcIj09PWEmJlwiZm9yZWlnbk9iamVjdFwiPT09Yj9cImh0dHA6Ly93d3cudzMub3JnLzE5OTkveGh0bWxcIjphfVxudmFyIG5iLG9iPWZ1bmN0aW9uKGEpe3JldHVyblwidW5kZWZpbmVkXCIhPT10eXBlb2YgTVNBcHAmJk1TQXBwLmV4ZWNVbnNhZmVMb2NhbEZ1bmN0aW9uP2Z1bmN0aW9uKGIsYyxkLGUpe01TQXBwLmV4ZWNVbnNhZmVMb2NhbEZ1bmN0aW9uKGZ1bmN0aW9uKCl7cmV0dXJuIGEoYixjLGQsZSl9KX06YX0oZnVuY3Rpb24oYSxiKXtpZihhLm5hbWVzcGFjZVVSSSE9PWtiLnN2Z3x8XCJpbm5lckhUTUxcImluIGEpYS5pbm5lckhUTUw9YjtlbHNle25iPW5ifHxkb2N1bWVudC5jcmVhdGVFbGVtZW50KFwiZGl2XCIpO25iLmlubmVySFRNTD1cIjxzdmc+XCIrYi52YWx1ZU9mKCkudG9TdHJpbmcoKStcIjwvc3ZnPlwiO2ZvcihiPW5iLmZpcnN0Q2hpbGQ7YS5maXJzdENoaWxkOylhLnJlbW92ZUNoaWxkKGEuZmlyc3RDaGlsZCk7Zm9yKDtiLmZpcnN0Q2hpbGQ7KWEuYXBwZW5kQ2hpbGQoYi5maXJzdENoaWxkKX19KTtcbmZ1bmN0aW9uIHBiKGEsYil7aWYoYil7dmFyIGM9YS5maXJzdENoaWxkO2lmKGMmJmM9PT1hLmxhc3RDaGlsZCYmMz09PWMubm9kZVR5cGUpe2Mubm9kZVZhbHVlPWI7cmV0dXJufX1hLnRleHRDb250ZW50PWJ9XG52YXIgcWI9e2FuaW1hdGlvbkl0ZXJhdGlvbkNvdW50OiEwLGJvcmRlckltYWdlT3V0c2V0OiEwLGJvcmRlckltYWdlU2xpY2U6ITAsYm9yZGVySW1hZ2VXaWR0aDohMCxib3hGbGV4OiEwLGJveEZsZXhHcm91cDohMCxib3hPcmRpbmFsR3JvdXA6ITAsY29sdW1uQ291bnQ6ITAsY29sdW1uczohMCxmbGV4OiEwLGZsZXhHcm93OiEwLGZsZXhQb3NpdGl2ZTohMCxmbGV4U2hyaW5rOiEwLGZsZXhOZWdhdGl2ZTohMCxmbGV4T3JkZXI6ITAsZ3JpZEFyZWE6ITAsZ3JpZFJvdzohMCxncmlkUm93RW5kOiEwLGdyaWRSb3dTcGFuOiEwLGdyaWRSb3dTdGFydDohMCxncmlkQ29sdW1uOiEwLGdyaWRDb2x1bW5FbmQ6ITAsZ3JpZENvbHVtblNwYW46ITAsZ3JpZENvbHVtblN0YXJ0OiEwLGZvbnRXZWlnaHQ6ITAsbGluZUNsYW1wOiEwLGxpbmVIZWlnaHQ6ITAsb3BhY2l0eTohMCxvcmRlcjohMCxvcnBoYW5zOiEwLHRhYlNpemU6ITAsd2lkb3dzOiEwLHpJbmRleDohMCx6b29tOiEwLGZpbGxPcGFjaXR5OiEwLFxuZmxvb2RPcGFjaXR5OiEwLHN0b3BPcGFjaXR5OiEwLHN0cm9rZURhc2hhcnJheTohMCxzdHJva2VEYXNob2Zmc2V0OiEwLHN0cm9rZU1pdGVybGltaXQ6ITAsc3Ryb2tlT3BhY2l0eTohMCxzdHJva2VXaWR0aDohMH0scmI9W1wiV2Via2l0XCIsXCJtc1wiLFwiTW96XCIsXCJPXCJdO09iamVjdC5rZXlzKHFiKS5mb3JFYWNoKGZ1bmN0aW9uKGEpe3JiLmZvckVhY2goZnVuY3Rpb24oYil7Yj1iK2EuY2hhckF0KDApLnRvVXBwZXJDYXNlKCkrYS5zdWJzdHJpbmcoMSk7cWJbYl09cWJbYV19KX0pO2Z1bmN0aW9uIHNiKGEsYixjKXtyZXR1cm4gbnVsbD09Ynx8XCJib29sZWFuXCI9PT10eXBlb2YgYnx8XCJcIj09PWI/XCJcIjpjfHxcIm51bWJlclwiIT09dHlwZW9mIGJ8fDA9PT1ifHxxYi5oYXNPd25Qcm9wZXJ0eShhKSYmcWJbYV0/KFwiXCIrYikudHJpbSgpOmIrXCJweFwifVxuZnVuY3Rpb24gdGIoYSxiKXthPWEuc3R5bGU7Zm9yKHZhciBjIGluIGIpaWYoYi5oYXNPd25Qcm9wZXJ0eShjKSl7dmFyIGQ9MD09PWMuaW5kZXhPZihcIi0tXCIpLGU9c2IoYyxiW2NdLGQpO1wiZmxvYXRcIj09PWMmJihjPVwiY3NzRmxvYXRcIik7ZD9hLnNldFByb3BlcnR5KGMsZSk6YVtjXT1lfX12YXIgdWI9bSh7bWVudWl0ZW06ITB9LHthcmVhOiEwLGJhc2U6ITAsYnI6ITAsY29sOiEwLGVtYmVkOiEwLGhyOiEwLGltZzohMCxpbnB1dDohMCxrZXlnZW46ITAsbGluazohMCxtZXRhOiEwLHBhcmFtOiEwLHNvdXJjZTohMCx0cmFjazohMCx3YnI6ITB9KTtcbmZ1bmN0aW9uIHZiKGEsYil7aWYoYil7aWYodWJbYV0mJihudWxsIT1iLmNoaWxkcmVufHxudWxsIT1iLmRhbmdlcm91c2x5U2V0SW5uZXJIVE1MKSl0aHJvdyBFcnJvcih5KDEzNyxhKSk7aWYobnVsbCE9Yi5kYW5nZXJvdXNseVNldElubmVySFRNTCl7aWYobnVsbCE9Yi5jaGlsZHJlbil0aHJvdyBFcnJvcih5KDYwKSk7aWYoIShcIm9iamVjdFwiPT09dHlwZW9mIGIuZGFuZ2Vyb3VzbHlTZXRJbm5lckhUTUwmJlwiX19odG1sXCJpbiBiLmRhbmdlcm91c2x5U2V0SW5uZXJIVE1MKSl0aHJvdyBFcnJvcih5KDYxKSk7fWlmKG51bGwhPWIuc3R5bGUmJlwib2JqZWN0XCIhPT10eXBlb2YgYi5zdHlsZSl0aHJvdyBFcnJvcih5KDYyKSk7fX1cbmZ1bmN0aW9uIHdiKGEsYil7aWYoLTE9PT1hLmluZGV4T2YoXCItXCIpKXJldHVyblwic3RyaW5nXCI9PT10eXBlb2YgYi5pcztzd2l0Y2goYSl7Y2FzZSBcImFubm90YXRpb24teG1sXCI6Y2FzZSBcImNvbG9yLXByb2ZpbGVcIjpjYXNlIFwiZm9udC1mYWNlXCI6Y2FzZSBcImZvbnQtZmFjZS1zcmNcIjpjYXNlIFwiZm9udC1mYWNlLXVyaVwiOmNhc2UgXCJmb250LWZhY2UtZm9ybWF0XCI6Y2FzZSBcImZvbnQtZmFjZS1uYW1lXCI6Y2FzZSBcIm1pc3NpbmctZ2x5cGhcIjpyZXR1cm4hMTtkZWZhdWx0OnJldHVybiEwfX1mdW5jdGlvbiB4YihhKXthPWEudGFyZ2V0fHxhLnNyY0VsZW1lbnR8fHdpbmRvdzthLmNvcnJlc3BvbmRpbmdVc2VFbGVtZW50JiYoYT1hLmNvcnJlc3BvbmRpbmdVc2VFbGVtZW50KTtyZXR1cm4gMz09PWEubm9kZVR5cGU/YS5wYXJlbnROb2RlOmF9dmFyIHliPW51bGwsemI9bnVsbCxBYj1udWxsO1xuZnVuY3Rpb24gQmIoYSl7aWYoYT1DYihhKSl7aWYoXCJmdW5jdGlvblwiIT09dHlwZW9mIHliKXRocm93IEVycm9yKHkoMjgwKSk7dmFyIGI9YS5zdGF0ZU5vZGU7YiYmKGI9RGIoYikseWIoYS5zdGF0ZU5vZGUsYS50eXBlLGIpKX19ZnVuY3Rpb24gRWIoYSl7emI/QWI/QWIucHVzaChhKTpBYj1bYV06emI9YX1mdW5jdGlvbiBGYigpe2lmKHpiKXt2YXIgYT16YixiPUFiO0FiPXpiPW51bGw7QmIoYSk7aWYoYilmb3IoYT0wO2E8Yi5sZW5ndGg7YSsrKUJiKGJbYV0pfX1mdW5jdGlvbiBHYihhLGIpe3JldHVybiBhKGIpfWZ1bmN0aW9uIEhiKGEsYixjLGQsZSl7cmV0dXJuIGEoYixjLGQsZSl9ZnVuY3Rpb24gSWIoKXt9dmFyIEpiPUdiLEtiPSExLExiPSExO2Z1bmN0aW9uIE1iKCl7aWYobnVsbCE9PXpifHxudWxsIT09QWIpSWIoKSxGYigpfVxuZnVuY3Rpb24gTmIoYSxiLGMpe2lmKExiKXJldHVybiBhKGIsYyk7TGI9ITA7dHJ5e3JldHVybiBKYihhLGIsYyl9ZmluYWxseXtMYj0hMSxNYigpfX1cbmZ1bmN0aW9uIE9iKGEsYil7dmFyIGM9YS5zdGF0ZU5vZGU7aWYobnVsbD09PWMpcmV0dXJuIG51bGw7dmFyIGQ9RGIoYyk7aWYobnVsbD09PWQpcmV0dXJuIG51bGw7Yz1kW2JdO2E6c3dpdGNoKGIpe2Nhc2UgXCJvbkNsaWNrXCI6Y2FzZSBcIm9uQ2xpY2tDYXB0dXJlXCI6Y2FzZSBcIm9uRG91YmxlQ2xpY2tcIjpjYXNlIFwib25Eb3VibGVDbGlja0NhcHR1cmVcIjpjYXNlIFwib25Nb3VzZURvd25cIjpjYXNlIFwib25Nb3VzZURvd25DYXB0dXJlXCI6Y2FzZSBcIm9uTW91c2VNb3ZlXCI6Y2FzZSBcIm9uTW91c2VNb3ZlQ2FwdHVyZVwiOmNhc2UgXCJvbk1vdXNlVXBcIjpjYXNlIFwib25Nb3VzZVVwQ2FwdHVyZVwiOmNhc2UgXCJvbk1vdXNlRW50ZXJcIjooZD0hZC5kaXNhYmxlZCl8fChhPWEudHlwZSxkPSEoXCJidXR0b25cIj09PWF8fFwiaW5wdXRcIj09PWF8fFwic2VsZWN0XCI9PT1hfHxcInRleHRhcmVhXCI9PT1hKSk7YT0hZDticmVhayBhO2RlZmF1bHQ6YT0hMX1pZihhKXJldHVybiBudWxsO2lmKGMmJlwiZnVuY3Rpb25cIiE9PVxudHlwZW9mIGMpdGhyb3cgRXJyb3IoeSgyMzEsYix0eXBlb2YgYykpO3JldHVybiBjfXZhciBQYj0hMTtpZihmYSl0cnl7dmFyIFFiPXt9O09iamVjdC5kZWZpbmVQcm9wZXJ0eShRYixcInBhc3NpdmVcIix7Z2V0OmZ1bmN0aW9uKCl7UGI9ITB9fSk7d2luZG93LmFkZEV2ZW50TGlzdGVuZXIoXCJ0ZXN0XCIsUWIsUWIpO3dpbmRvdy5yZW1vdmVFdmVudExpc3RlbmVyKFwidGVzdFwiLFFiLFFiKX1jYXRjaChhKXtQYj0hMX1mdW5jdGlvbiBSYihhLGIsYyxkLGUsZixnLGgsayl7dmFyIGw9QXJyYXkucHJvdG90eXBlLnNsaWNlLmNhbGwoYXJndW1lbnRzLDMpO3RyeXtiLmFwcGx5KGMsbCl9Y2F0Y2gobil7dGhpcy5vbkVycm9yKG4pfX12YXIgU2I9ITEsVGI9bnVsbCxVYj0hMSxWYj1udWxsLFdiPXtvbkVycm9yOmZ1bmN0aW9uKGEpe1NiPSEwO1RiPWF9fTtmdW5jdGlvbiBYYihhLGIsYyxkLGUsZixnLGgsayl7U2I9ITE7VGI9bnVsbDtSYi5hcHBseShXYixhcmd1bWVudHMpfVxuZnVuY3Rpb24gWWIoYSxiLGMsZCxlLGYsZyxoLGspe1hiLmFwcGx5KHRoaXMsYXJndW1lbnRzKTtpZihTYil7aWYoU2Ipe3ZhciBsPVRiO1NiPSExO1RiPW51bGx9ZWxzZSB0aHJvdyBFcnJvcih5KDE5OCkpO1VifHwoVWI9ITAsVmI9bCl9fWZ1bmN0aW9uIFpiKGEpe3ZhciBiPWEsYz1hO2lmKGEuYWx0ZXJuYXRlKWZvcig7Yi5yZXR1cm47KWI9Yi5yZXR1cm47ZWxzZXthPWI7ZG8gYj1hLDAhPT0oYi5mbGFncyYxMDI2KSYmKGM9Yi5yZXR1cm4pLGE9Yi5yZXR1cm47d2hpbGUoYSl9cmV0dXJuIDM9PT1iLnRhZz9jOm51bGx9ZnVuY3Rpb24gJGIoYSl7aWYoMTM9PT1hLnRhZyl7dmFyIGI9YS5tZW1vaXplZFN0YXRlO251bGw9PT1iJiYoYT1hLmFsdGVybmF0ZSxudWxsIT09YSYmKGI9YS5tZW1vaXplZFN0YXRlKSk7aWYobnVsbCE9PWIpcmV0dXJuIGIuZGVoeWRyYXRlZH1yZXR1cm4gbnVsbH1mdW5jdGlvbiBhYyhhKXtpZihaYihhKSE9PWEpdGhyb3cgRXJyb3IoeSgxODgpKTt9XG5mdW5jdGlvbiBiYyhhKXt2YXIgYj1hLmFsdGVybmF0ZTtpZighYil7Yj1aYihhKTtpZihudWxsPT09Yil0aHJvdyBFcnJvcih5KDE4OCkpO3JldHVybiBiIT09YT9udWxsOmF9Zm9yKHZhciBjPWEsZD1iOzspe3ZhciBlPWMucmV0dXJuO2lmKG51bGw9PT1lKWJyZWFrO3ZhciBmPWUuYWx0ZXJuYXRlO2lmKG51bGw9PT1mKXtkPWUucmV0dXJuO2lmKG51bGwhPT1kKXtjPWQ7Y29udGludWV9YnJlYWt9aWYoZS5jaGlsZD09PWYuY2hpbGQpe2ZvcihmPWUuY2hpbGQ7Zjspe2lmKGY9PT1jKXJldHVybiBhYyhlKSxhO2lmKGY9PT1kKXJldHVybiBhYyhlKSxiO2Y9Zi5zaWJsaW5nfXRocm93IEVycm9yKHkoMTg4KSk7fWlmKGMucmV0dXJuIT09ZC5yZXR1cm4pYz1lLGQ9ZjtlbHNle2Zvcih2YXIgZz0hMSxoPWUuY2hpbGQ7aDspe2lmKGg9PT1jKXtnPSEwO2M9ZTtkPWY7YnJlYWt9aWYoaD09PWQpe2c9ITA7ZD1lO2M9ZjticmVha31oPWguc2libGluZ31pZighZyl7Zm9yKGg9Zi5jaGlsZDtoOyl7aWYoaD09PVxuYyl7Zz0hMDtjPWY7ZD1lO2JyZWFrfWlmKGg9PT1kKXtnPSEwO2Q9ZjtjPWU7YnJlYWt9aD1oLnNpYmxpbmd9aWYoIWcpdGhyb3cgRXJyb3IoeSgxODkpKTt9fWlmKGMuYWx0ZXJuYXRlIT09ZCl0aHJvdyBFcnJvcih5KDE5MCkpO31pZigzIT09Yy50YWcpdGhyb3cgRXJyb3IoeSgxODgpKTtyZXR1cm4gYy5zdGF0ZU5vZGUuY3VycmVudD09PWM/YTpifWZ1bmN0aW9uIGNjKGEpe2E9YmMoYSk7aWYoIWEpcmV0dXJuIG51bGw7Zm9yKHZhciBiPWE7Oyl7aWYoNT09PWIudGFnfHw2PT09Yi50YWcpcmV0dXJuIGI7aWYoYi5jaGlsZCliLmNoaWxkLnJldHVybj1iLGI9Yi5jaGlsZDtlbHNle2lmKGI9PT1hKWJyZWFrO2Zvcig7IWIuc2libGluZzspe2lmKCFiLnJldHVybnx8Yi5yZXR1cm49PT1hKXJldHVybiBudWxsO2I9Yi5yZXR1cm59Yi5zaWJsaW5nLnJldHVybj1iLnJldHVybjtiPWIuc2libGluZ319cmV0dXJuIG51bGx9XG5mdW5jdGlvbiBkYyhhLGIpe2Zvcih2YXIgYz1hLmFsdGVybmF0ZTtudWxsIT09Yjspe2lmKGI9PT1hfHxiPT09YylyZXR1cm4hMDtiPWIucmV0dXJufXJldHVybiExfXZhciBlYyxmYyxnYyxoYyxpYz0hMSxqYz1bXSxrYz1udWxsLGxjPW51bGwsbWM9bnVsbCxuYz1uZXcgTWFwLG9jPW5ldyBNYXAscGM9W10scWM9XCJtb3VzZWRvd24gbW91c2V1cCB0b3VjaGNhbmNlbCB0b3VjaGVuZCB0b3VjaHN0YXJ0IGF1eGNsaWNrIGRibGNsaWNrIHBvaW50ZXJjYW5jZWwgcG9pbnRlcmRvd24gcG9pbnRlcnVwIGRyYWdlbmQgZHJhZ3N0YXJ0IGRyb3AgY29tcG9zaXRpb25lbmQgY29tcG9zaXRpb25zdGFydCBrZXlkb3duIGtleXByZXNzIGtleXVwIGlucHV0IHRleHRJbnB1dCBjb3B5IGN1dCBwYXN0ZSBjbGljayBjaGFuZ2UgY29udGV4dG1lbnUgcmVzZXQgc3VibWl0XCIuc3BsaXQoXCIgXCIpO1xuZnVuY3Rpb24gcmMoYSxiLGMsZCxlKXtyZXR1cm57YmxvY2tlZE9uOmEsZG9tRXZlbnROYW1lOmIsZXZlbnRTeXN0ZW1GbGFnczpjfDE2LG5hdGl2ZUV2ZW50OmUsdGFyZ2V0Q29udGFpbmVyczpbZF19fWZ1bmN0aW9uIHNjKGEsYil7c3dpdGNoKGEpe2Nhc2UgXCJmb2N1c2luXCI6Y2FzZSBcImZvY3Vzb3V0XCI6a2M9bnVsbDticmVhaztjYXNlIFwiZHJhZ2VudGVyXCI6Y2FzZSBcImRyYWdsZWF2ZVwiOmxjPW51bGw7YnJlYWs7Y2FzZSBcIm1vdXNlb3ZlclwiOmNhc2UgXCJtb3VzZW91dFwiOm1jPW51bGw7YnJlYWs7Y2FzZSBcInBvaW50ZXJvdmVyXCI6Y2FzZSBcInBvaW50ZXJvdXRcIjpuYy5kZWxldGUoYi5wb2ludGVySWQpO2JyZWFrO2Nhc2UgXCJnb3Rwb2ludGVyY2FwdHVyZVwiOmNhc2UgXCJsb3N0cG9pbnRlcmNhcHR1cmVcIjpvYy5kZWxldGUoYi5wb2ludGVySWQpfX1cbmZ1bmN0aW9uIHRjKGEsYixjLGQsZSxmKXtpZihudWxsPT09YXx8YS5uYXRpdmVFdmVudCE9PWYpcmV0dXJuIGE9cmMoYixjLGQsZSxmKSxudWxsIT09YiYmKGI9Q2IoYiksbnVsbCE9PWImJmZjKGIpKSxhO2EuZXZlbnRTeXN0ZW1GbGFnc3w9ZDtiPWEudGFyZ2V0Q29udGFpbmVycztudWxsIT09ZSYmLTE9PT1iLmluZGV4T2YoZSkmJmIucHVzaChlKTtyZXR1cm4gYX1cbmZ1bmN0aW9uIHVjKGEsYixjLGQsZSl7c3dpdGNoKGIpe2Nhc2UgXCJmb2N1c2luXCI6cmV0dXJuIGtjPXRjKGtjLGEsYixjLGQsZSksITA7Y2FzZSBcImRyYWdlbnRlclwiOnJldHVybiBsYz10YyhsYyxhLGIsYyxkLGUpLCEwO2Nhc2UgXCJtb3VzZW92ZXJcIjpyZXR1cm4gbWM9dGMobWMsYSxiLGMsZCxlKSwhMDtjYXNlIFwicG9pbnRlcm92ZXJcIjp2YXIgZj1lLnBvaW50ZXJJZDtuYy5zZXQoZix0YyhuYy5nZXQoZil8fG51bGwsYSxiLGMsZCxlKSk7cmV0dXJuITA7Y2FzZSBcImdvdHBvaW50ZXJjYXB0dXJlXCI6cmV0dXJuIGY9ZS5wb2ludGVySWQsb2Muc2V0KGYsdGMob2MuZ2V0KGYpfHxudWxsLGEsYixjLGQsZSkpLCEwfXJldHVybiExfVxuZnVuY3Rpb24gdmMoYSl7dmFyIGI9d2MoYS50YXJnZXQpO2lmKG51bGwhPT1iKXt2YXIgYz1aYihiKTtpZihudWxsIT09YylpZihiPWMudGFnLDEzPT09Yil7aWYoYj0kYihjKSxudWxsIT09Yil7YS5ibG9ja2VkT249YjtoYyhhLmxhbmVQcmlvcml0eSxmdW5jdGlvbigpe3IudW5zdGFibGVfcnVuV2l0aFByaW9yaXR5KGEucHJpb3JpdHksZnVuY3Rpb24oKXtnYyhjKX0pfSk7cmV0dXJufX1lbHNlIGlmKDM9PT1iJiZjLnN0YXRlTm9kZS5oeWRyYXRlKXthLmJsb2NrZWRPbj0zPT09Yy50YWc/Yy5zdGF0ZU5vZGUuY29udGFpbmVySW5mbzpudWxsO3JldHVybn19YS5ibG9ja2VkT249bnVsbH1cbmZ1bmN0aW9uIHhjKGEpe2lmKG51bGwhPT1hLmJsb2NrZWRPbilyZXR1cm4hMTtmb3IodmFyIGI9YS50YXJnZXRDb250YWluZXJzOzA8Yi5sZW5ndGg7KXt2YXIgYz15YyhhLmRvbUV2ZW50TmFtZSxhLmV2ZW50U3lzdGVtRmxhZ3MsYlswXSxhLm5hdGl2ZUV2ZW50KTtpZihudWxsIT09YylyZXR1cm4gYj1DYihjKSxudWxsIT09YiYmZmMoYiksYS5ibG9ja2VkT249YywhMTtiLnNoaWZ0KCl9cmV0dXJuITB9ZnVuY3Rpb24gemMoYSxiLGMpe3hjKGEpJiZjLmRlbGV0ZShiKX1cbmZ1bmN0aW9uIEFjKCl7Zm9yKGljPSExOzA8amMubGVuZ3RoOyl7dmFyIGE9amNbMF07aWYobnVsbCE9PWEuYmxvY2tlZE9uKXthPUNiKGEuYmxvY2tlZE9uKTtudWxsIT09YSYmZWMoYSk7YnJlYWt9Zm9yKHZhciBiPWEudGFyZ2V0Q29udGFpbmVyczswPGIubGVuZ3RoOyl7dmFyIGM9eWMoYS5kb21FdmVudE5hbWUsYS5ldmVudFN5c3RlbUZsYWdzLGJbMF0sYS5uYXRpdmVFdmVudCk7aWYobnVsbCE9PWMpe2EuYmxvY2tlZE9uPWM7YnJlYWt9Yi5zaGlmdCgpfW51bGw9PT1hLmJsb2NrZWRPbiYmamMuc2hpZnQoKX1udWxsIT09a2MmJnhjKGtjKSYmKGtjPW51bGwpO251bGwhPT1sYyYmeGMobGMpJiYobGM9bnVsbCk7bnVsbCE9PW1jJiZ4YyhtYykmJihtYz1udWxsKTtuYy5mb3JFYWNoKHpjKTtvYy5mb3JFYWNoKHpjKX1cbmZ1bmN0aW9uIEJjKGEsYil7YS5ibG9ja2VkT249PT1iJiYoYS5ibG9ja2VkT249bnVsbCxpY3x8KGljPSEwLHIudW5zdGFibGVfc2NoZWR1bGVDYWxsYmFjayhyLnVuc3RhYmxlX05vcm1hbFByaW9yaXR5LEFjKSkpfVxuZnVuY3Rpb24gQ2MoYSl7ZnVuY3Rpb24gYihiKXtyZXR1cm4gQmMoYixhKX1pZigwPGpjLmxlbmd0aCl7QmMoamNbMF0sYSk7Zm9yKHZhciBjPTE7YzxqYy5sZW5ndGg7YysrKXt2YXIgZD1qY1tjXTtkLmJsb2NrZWRPbj09PWEmJihkLmJsb2NrZWRPbj1udWxsKX19bnVsbCE9PWtjJiZCYyhrYyxhKTtudWxsIT09bGMmJkJjKGxjLGEpO251bGwhPT1tYyYmQmMobWMsYSk7bmMuZm9yRWFjaChiKTtvYy5mb3JFYWNoKGIpO2ZvcihjPTA7YzxwYy5sZW5ndGg7YysrKWQ9cGNbY10sZC5ibG9ja2VkT249PT1hJiYoZC5ibG9ja2VkT249bnVsbCk7Zm9yKDswPHBjLmxlbmd0aCYmKGM9cGNbMF0sbnVsbD09PWMuYmxvY2tlZE9uKTspdmMoYyksbnVsbD09PWMuYmxvY2tlZE9uJiZwYy5zaGlmdCgpfVxuZnVuY3Rpb24gRGMoYSxiKXt2YXIgYz17fTtjW2EudG9Mb3dlckNhc2UoKV09Yi50b0xvd2VyQ2FzZSgpO2NbXCJXZWJraXRcIithXT1cIndlYmtpdFwiK2I7Y1tcIk1velwiK2FdPVwibW96XCIrYjtyZXR1cm4gY312YXIgRWM9e2FuaW1hdGlvbmVuZDpEYyhcIkFuaW1hdGlvblwiLFwiQW5pbWF0aW9uRW5kXCIpLGFuaW1hdGlvbml0ZXJhdGlvbjpEYyhcIkFuaW1hdGlvblwiLFwiQW5pbWF0aW9uSXRlcmF0aW9uXCIpLGFuaW1hdGlvbnN0YXJ0OkRjKFwiQW5pbWF0aW9uXCIsXCJBbmltYXRpb25TdGFydFwiKSx0cmFuc2l0aW9uZW5kOkRjKFwiVHJhbnNpdGlvblwiLFwiVHJhbnNpdGlvbkVuZFwiKX0sRmM9e30sR2M9e307XG5mYSYmKEdjPWRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoXCJkaXZcIikuc3R5bGUsXCJBbmltYXRpb25FdmVudFwiaW4gd2luZG93fHwoZGVsZXRlIEVjLmFuaW1hdGlvbmVuZC5hbmltYXRpb24sZGVsZXRlIEVjLmFuaW1hdGlvbml0ZXJhdGlvbi5hbmltYXRpb24sZGVsZXRlIEVjLmFuaW1hdGlvbnN0YXJ0LmFuaW1hdGlvbiksXCJUcmFuc2l0aW9uRXZlbnRcImluIHdpbmRvd3x8ZGVsZXRlIEVjLnRyYW5zaXRpb25lbmQudHJhbnNpdGlvbik7ZnVuY3Rpb24gSGMoYSl7aWYoRmNbYV0pcmV0dXJuIEZjW2FdO2lmKCFFY1thXSlyZXR1cm4gYTt2YXIgYj1FY1thXSxjO2ZvcihjIGluIGIpaWYoYi5oYXNPd25Qcm9wZXJ0eShjKSYmYyBpbiBHYylyZXR1cm4gRmNbYV09YltjXTtyZXR1cm4gYX1cbnZhciBJYz1IYyhcImFuaW1hdGlvbmVuZFwiKSxKYz1IYyhcImFuaW1hdGlvbml0ZXJhdGlvblwiKSxLYz1IYyhcImFuaW1hdGlvbnN0YXJ0XCIpLExjPUhjKFwidHJhbnNpdGlvbmVuZFwiKSxNYz1uZXcgTWFwLE5jPW5ldyBNYXAsT2M9W1wiYWJvcnRcIixcImFib3J0XCIsSWMsXCJhbmltYXRpb25FbmRcIixKYyxcImFuaW1hdGlvbkl0ZXJhdGlvblwiLEtjLFwiYW5pbWF0aW9uU3RhcnRcIixcImNhbnBsYXlcIixcImNhblBsYXlcIixcImNhbnBsYXl0aHJvdWdoXCIsXCJjYW5QbGF5VGhyb3VnaFwiLFwiZHVyYXRpb25jaGFuZ2VcIixcImR1cmF0aW9uQ2hhbmdlXCIsXCJlbXB0aWVkXCIsXCJlbXB0aWVkXCIsXCJlbmNyeXB0ZWRcIixcImVuY3J5cHRlZFwiLFwiZW5kZWRcIixcImVuZGVkXCIsXCJlcnJvclwiLFwiZXJyb3JcIixcImdvdHBvaW50ZXJjYXB0dXJlXCIsXCJnb3RQb2ludGVyQ2FwdHVyZVwiLFwibG9hZFwiLFwibG9hZFwiLFwibG9hZGVkZGF0YVwiLFwibG9hZGVkRGF0YVwiLFwibG9hZGVkbWV0YWRhdGFcIixcImxvYWRlZE1ldGFkYXRhXCIsXCJsb2Fkc3RhcnRcIixcImxvYWRTdGFydFwiLFxuXCJsb3N0cG9pbnRlcmNhcHR1cmVcIixcImxvc3RQb2ludGVyQ2FwdHVyZVwiLFwicGxheWluZ1wiLFwicGxheWluZ1wiLFwicHJvZ3Jlc3NcIixcInByb2dyZXNzXCIsXCJzZWVraW5nXCIsXCJzZWVraW5nXCIsXCJzdGFsbGVkXCIsXCJzdGFsbGVkXCIsXCJzdXNwZW5kXCIsXCJzdXNwZW5kXCIsXCJ0aW1ldXBkYXRlXCIsXCJ0aW1lVXBkYXRlXCIsTGMsXCJ0cmFuc2l0aW9uRW5kXCIsXCJ3YWl0aW5nXCIsXCJ3YWl0aW5nXCJdO2Z1bmN0aW9uIFBjKGEsYil7Zm9yKHZhciBjPTA7YzxhLmxlbmd0aDtjKz0yKXt2YXIgZD1hW2NdLGU9YVtjKzFdO2U9XCJvblwiKyhlWzBdLnRvVXBwZXJDYXNlKCkrZS5zbGljZSgxKSk7TmMuc2V0KGQsYik7TWMuc2V0KGQsZSk7ZGEoZSxbZF0pfX12YXIgUWM9ci51bnN0YWJsZV9ub3c7UWMoKTt2YXIgRj04O1xuZnVuY3Rpb24gUmMoYSl7aWYoMCE9PSgxJmEpKXJldHVybiBGPTE1LDE7aWYoMCE9PSgyJmEpKXJldHVybiBGPTE0LDI7aWYoMCE9PSg0JmEpKXJldHVybiBGPTEzLDQ7dmFyIGI9MjQmYTtpZigwIT09YilyZXR1cm4gRj0xMixiO2lmKDAhPT0oYSYzMikpcmV0dXJuIEY9MTEsMzI7Yj0xOTImYTtpZigwIT09YilyZXR1cm4gRj0xMCxiO2lmKDAhPT0oYSYyNTYpKXJldHVybiBGPTksMjU2O2I9MzU4NCZhO2lmKDAhPT1iKXJldHVybiBGPTgsYjtpZigwIT09KGEmNDA5NikpcmV0dXJuIEY9Nyw0MDk2O2I9NDE4NjExMiZhO2lmKDAhPT1iKXJldHVybiBGPTYsYjtiPTYyOTE0NTYwJmE7aWYoMCE9PWIpcmV0dXJuIEY9NSxiO2lmKGEmNjcxMDg4NjQpcmV0dXJuIEY9NCw2NzEwODg2NDtpZigwIT09KGEmMTM0MjE3NzI4KSlyZXR1cm4gRj0zLDEzNDIxNzcyODtiPTgwNTMwNjM2OCZhO2lmKDAhPT1iKXJldHVybiBGPTIsYjtpZigwIT09KDEwNzM3NDE4MjQmYSkpcmV0dXJuIEY9MSwxMDczNzQxODI0O1xuRj04O3JldHVybiBhfWZ1bmN0aW9uIFNjKGEpe3N3aXRjaChhKXtjYXNlIDk5OnJldHVybiAxNTtjYXNlIDk4OnJldHVybiAxMDtjYXNlIDk3OmNhc2UgOTY6cmV0dXJuIDg7Y2FzZSA5NTpyZXR1cm4gMjtkZWZhdWx0OnJldHVybiAwfX1mdW5jdGlvbiBUYyhhKXtzd2l0Y2goYSl7Y2FzZSAxNTpjYXNlIDE0OnJldHVybiA5OTtjYXNlIDEzOmNhc2UgMTI6Y2FzZSAxMTpjYXNlIDEwOnJldHVybiA5ODtjYXNlIDk6Y2FzZSA4OmNhc2UgNzpjYXNlIDY6Y2FzZSA0OmNhc2UgNTpyZXR1cm4gOTc7Y2FzZSAzOmNhc2UgMjpjYXNlIDE6cmV0dXJuIDk1O2Nhc2UgMDpyZXR1cm4gOTA7ZGVmYXVsdDp0aHJvdyBFcnJvcih5KDM1OCxhKSk7fX1cbmZ1bmN0aW9uIFVjKGEsYil7dmFyIGM9YS5wZW5kaW5nTGFuZXM7aWYoMD09PWMpcmV0dXJuIEY9MDt2YXIgZD0wLGU9MCxmPWEuZXhwaXJlZExhbmVzLGc9YS5zdXNwZW5kZWRMYW5lcyxoPWEucGluZ2VkTGFuZXM7aWYoMCE9PWYpZD1mLGU9Rj0xNTtlbHNlIGlmKGY9YyYxMzQyMTc3MjcsMCE9PWYpe3ZhciBrPWYmfmc7MCE9PWs/KGQ9UmMoayksZT1GKTooaCY9ZiwwIT09aCYmKGQ9UmMoaCksZT1GKSl9ZWxzZSBmPWMmfmcsMCE9PWY/KGQ9UmMoZiksZT1GKTowIT09aCYmKGQ9UmMoaCksZT1GKTtpZigwPT09ZClyZXR1cm4gMDtkPTMxLVZjKGQpO2Q9YyYoKDA+ZD8wOjE8PGQpPDwxKS0xO2lmKDAhPT1iJiZiIT09ZCYmMD09PShiJmcpKXtSYyhiKTtpZihlPD1GKXJldHVybiBiO0Y9ZX1iPWEuZW50YW5nbGVkTGFuZXM7aWYoMCE9PWIpZm9yKGE9YS5lbnRhbmdsZW1lbnRzLGImPWQ7MDxiOyljPTMxLVZjKGIpLGU9MTw8YyxkfD1hW2NdLGImPX5lO3JldHVybiBkfVxuZnVuY3Rpb24gV2MoYSl7YT1hLnBlbmRpbmdMYW5lcyYtMTA3Mzc0MTgyNTtyZXR1cm4gMCE9PWE/YTphJjEwNzM3NDE4MjQ/MTA3Mzc0MTgyNDowfWZ1bmN0aW9uIFhjKGEsYil7c3dpdGNoKGEpe2Nhc2UgMTU6cmV0dXJuIDE7Y2FzZSAxNDpyZXR1cm4gMjtjYXNlIDEyOnJldHVybiBhPVljKDI0Jn5iKSwwPT09YT9YYygxMCxiKTphO2Nhc2UgMTA6cmV0dXJuIGE9WWMoMTkyJn5iKSwwPT09YT9YYyg4LGIpOmE7Y2FzZSA4OnJldHVybiBhPVljKDM1ODQmfmIpLDA9PT1hJiYoYT1ZYyg0MTg2MTEyJn5iKSwwPT09YSYmKGE9NTEyKSksYTtjYXNlIDI6cmV0dXJuIGI9WWMoODA1MzA2MzY4Jn5iKSwwPT09YiYmKGI9MjY4NDM1NDU2KSxifXRocm93IEVycm9yKHkoMzU4LGEpKTt9ZnVuY3Rpb24gWWMoYSl7cmV0dXJuIGEmLWF9ZnVuY3Rpb24gWmMoYSl7Zm9yKHZhciBiPVtdLGM9MDszMT5jO2MrKyliLnB1c2goYSk7cmV0dXJuIGJ9XG5mdW5jdGlvbiAkYyhhLGIsYyl7YS5wZW5kaW5nTGFuZXN8PWI7dmFyIGQ9Yi0xO2Euc3VzcGVuZGVkTGFuZXMmPWQ7YS5waW5nZWRMYW5lcyY9ZDthPWEuZXZlbnRUaW1lcztiPTMxLVZjKGIpO2FbYl09Y312YXIgVmM9TWF0aC5jbHozMj9NYXRoLmNsejMyOmFkLGJkPU1hdGgubG9nLGNkPU1hdGguTE4yO2Z1bmN0aW9uIGFkKGEpe3JldHVybiAwPT09YT8zMjozMS0oYmQoYSkvY2R8MCl8MH12YXIgZGQ9ci51bnN0YWJsZV9Vc2VyQmxvY2tpbmdQcmlvcml0eSxlZD1yLnVuc3RhYmxlX3J1bldpdGhQcmlvcml0eSxmZD0hMDtmdW5jdGlvbiBnZChhLGIsYyxkKXtLYnx8SWIoKTt2YXIgZT1oZCxmPUtiO0tiPSEwO3RyeXtIYihlLGEsYixjLGQpfWZpbmFsbHl7KEtiPWYpfHxNYigpfX1mdW5jdGlvbiBpZChhLGIsYyxkKXtlZChkZCxoZC5iaW5kKG51bGwsYSxiLGMsZCkpfVxuZnVuY3Rpb24gaGQoYSxiLGMsZCl7aWYoZmQpe3ZhciBlO2lmKChlPTA9PT0oYiY0KSkmJjA8amMubGVuZ3RoJiYtMTxxYy5pbmRleE9mKGEpKWE9cmMobnVsbCxhLGIsYyxkKSxqYy5wdXNoKGEpO2Vsc2V7dmFyIGY9eWMoYSxiLGMsZCk7aWYobnVsbD09PWYpZSYmc2MoYSxkKTtlbHNle2lmKGUpe2lmKC0xPHFjLmluZGV4T2YoYSkpe2E9cmMoZixhLGIsYyxkKTtqYy5wdXNoKGEpO3JldHVybn1pZih1YyhmLGEsYixjLGQpKXJldHVybjtzYyhhLGQpfWpkKGEsYixkLG51bGwsYyl9fX19XG5mdW5jdGlvbiB5YyhhLGIsYyxkKXt2YXIgZT14YihkKTtlPXdjKGUpO2lmKG51bGwhPT1lKXt2YXIgZj1aYihlKTtpZihudWxsPT09ZillPW51bGw7ZWxzZXt2YXIgZz1mLnRhZztpZigxMz09PWcpe2U9JGIoZik7aWYobnVsbCE9PWUpcmV0dXJuIGU7ZT1udWxsfWVsc2UgaWYoMz09PWcpe2lmKGYuc3RhdGVOb2RlLmh5ZHJhdGUpcmV0dXJuIDM9PT1mLnRhZz9mLnN0YXRlTm9kZS5jb250YWluZXJJbmZvOm51bGw7ZT1udWxsfWVsc2UgZiE9PWUmJihlPW51bGwpfX1qZChhLGIsZCxlLGMpO3JldHVybiBudWxsfXZhciBrZD1udWxsLGxkPW51bGwsbWQ9bnVsbDtcbmZ1bmN0aW9uIG5kKCl7aWYobWQpcmV0dXJuIG1kO3ZhciBhLGI9bGQsYz1iLmxlbmd0aCxkLGU9XCJ2YWx1ZVwiaW4ga2Q/a2QudmFsdWU6a2QudGV4dENvbnRlbnQsZj1lLmxlbmd0aDtmb3IoYT0wO2E8YyYmYlthXT09PWVbYV07YSsrKTt2YXIgZz1jLWE7Zm9yKGQ9MTtkPD1nJiZiW2MtZF09PT1lW2YtZF07ZCsrKTtyZXR1cm4gbWQ9ZS5zbGljZShhLDE8ZD8xLWQ6dm9pZCAwKX1mdW5jdGlvbiBvZChhKXt2YXIgYj1hLmtleUNvZGU7XCJjaGFyQ29kZVwiaW4gYT8oYT1hLmNoYXJDb2RlLDA9PT1hJiYxMz09PWImJihhPTEzKSk6YT1iOzEwPT09YSYmKGE9MTMpO3JldHVybiAzMjw9YXx8MTM9PT1hP2E6MH1mdW5jdGlvbiBwZCgpe3JldHVybiEwfWZ1bmN0aW9uIHFkKCl7cmV0dXJuITF9XG5mdW5jdGlvbiByZChhKXtmdW5jdGlvbiBiKGIsZCxlLGYsZyl7dGhpcy5fcmVhY3ROYW1lPWI7dGhpcy5fdGFyZ2V0SW5zdD1lO3RoaXMudHlwZT1kO3RoaXMubmF0aXZlRXZlbnQ9Zjt0aGlzLnRhcmdldD1nO3RoaXMuY3VycmVudFRhcmdldD1udWxsO2Zvcih2YXIgYyBpbiBhKWEuaGFzT3duUHJvcGVydHkoYykmJihiPWFbY10sdGhpc1tjXT1iP2IoZik6ZltjXSk7dGhpcy5pc0RlZmF1bHRQcmV2ZW50ZWQ9KG51bGwhPWYuZGVmYXVsdFByZXZlbnRlZD9mLmRlZmF1bHRQcmV2ZW50ZWQ6ITE9PT1mLnJldHVyblZhbHVlKT9wZDpxZDt0aGlzLmlzUHJvcGFnYXRpb25TdG9wcGVkPXFkO3JldHVybiB0aGlzfW0oYi5wcm90b3R5cGUse3ByZXZlbnREZWZhdWx0OmZ1bmN0aW9uKCl7dGhpcy5kZWZhdWx0UHJldmVudGVkPSEwO3ZhciBhPXRoaXMubmF0aXZlRXZlbnQ7YSYmKGEucHJldmVudERlZmF1bHQ/YS5wcmV2ZW50RGVmYXVsdCgpOlwidW5rbm93blwiIT09dHlwZW9mIGEucmV0dXJuVmFsdWUmJlxuKGEucmV0dXJuVmFsdWU9ITEpLHRoaXMuaXNEZWZhdWx0UHJldmVudGVkPXBkKX0sc3RvcFByb3BhZ2F0aW9uOmZ1bmN0aW9uKCl7dmFyIGE9dGhpcy5uYXRpdmVFdmVudDthJiYoYS5zdG9wUHJvcGFnYXRpb24/YS5zdG9wUHJvcGFnYXRpb24oKTpcInVua25vd25cIiE9PXR5cGVvZiBhLmNhbmNlbEJ1YmJsZSYmKGEuY2FuY2VsQnViYmxlPSEwKSx0aGlzLmlzUHJvcGFnYXRpb25TdG9wcGVkPXBkKX0scGVyc2lzdDpmdW5jdGlvbigpe30saXNQZXJzaXN0ZW50OnBkfSk7cmV0dXJuIGJ9XG52YXIgc2Q9e2V2ZW50UGhhc2U6MCxidWJibGVzOjAsY2FuY2VsYWJsZTowLHRpbWVTdGFtcDpmdW5jdGlvbihhKXtyZXR1cm4gYS50aW1lU3RhbXB8fERhdGUubm93KCl9LGRlZmF1bHRQcmV2ZW50ZWQ6MCxpc1RydXN0ZWQ6MH0sdGQ9cmQoc2QpLHVkPW0oe30sc2Qse3ZpZXc6MCxkZXRhaWw6MH0pLHZkPXJkKHVkKSx3ZCx4ZCx5ZCxBZD1tKHt9LHVkLHtzY3JlZW5YOjAsc2NyZWVuWTowLGNsaWVudFg6MCxjbGllbnRZOjAscGFnZVg6MCxwYWdlWTowLGN0cmxLZXk6MCxzaGlmdEtleTowLGFsdEtleTowLG1ldGFLZXk6MCxnZXRNb2RpZmllclN0YXRlOnpkLGJ1dHRvbjowLGJ1dHRvbnM6MCxyZWxhdGVkVGFyZ2V0OmZ1bmN0aW9uKGEpe3JldHVybiB2b2lkIDA9PT1hLnJlbGF0ZWRUYXJnZXQ/YS5mcm9tRWxlbWVudD09PWEuc3JjRWxlbWVudD9hLnRvRWxlbWVudDphLmZyb21FbGVtZW50OmEucmVsYXRlZFRhcmdldH0sbW92ZW1lbnRYOmZ1bmN0aW9uKGEpe2lmKFwibW92ZW1lbnRYXCJpblxuYSlyZXR1cm4gYS5tb3ZlbWVudFg7YSE9PXlkJiYoeWQmJlwibW91c2Vtb3ZlXCI9PT1hLnR5cGU/KHdkPWEuc2NyZWVuWC15ZC5zY3JlZW5YLHhkPWEuc2NyZWVuWS15ZC5zY3JlZW5ZKTp4ZD13ZD0wLHlkPWEpO3JldHVybiB3ZH0sbW92ZW1lbnRZOmZ1bmN0aW9uKGEpe3JldHVyblwibW92ZW1lbnRZXCJpbiBhP2EubW92ZW1lbnRZOnhkfX0pLEJkPXJkKEFkKSxDZD1tKHt9LEFkLHtkYXRhVHJhbnNmZXI6MH0pLERkPXJkKENkKSxFZD1tKHt9LHVkLHtyZWxhdGVkVGFyZ2V0OjB9KSxGZD1yZChFZCksR2Q9bSh7fSxzZCx7YW5pbWF0aW9uTmFtZTowLGVsYXBzZWRUaW1lOjAscHNldWRvRWxlbWVudDowfSksSGQ9cmQoR2QpLElkPW0oe30sc2Qse2NsaXBib2FyZERhdGE6ZnVuY3Rpb24oYSl7cmV0dXJuXCJjbGlwYm9hcmREYXRhXCJpbiBhP2EuY2xpcGJvYXJkRGF0YTp3aW5kb3cuY2xpcGJvYXJkRGF0YX19KSxKZD1yZChJZCksS2Q9bSh7fSxzZCx7ZGF0YTowfSksTGQ9cmQoS2QpLE1kPXtFc2M6XCJFc2NhcGVcIixcblNwYWNlYmFyOlwiIFwiLExlZnQ6XCJBcnJvd0xlZnRcIixVcDpcIkFycm93VXBcIixSaWdodDpcIkFycm93UmlnaHRcIixEb3duOlwiQXJyb3dEb3duXCIsRGVsOlwiRGVsZXRlXCIsV2luOlwiT1NcIixNZW51OlwiQ29udGV4dE1lbnVcIixBcHBzOlwiQ29udGV4dE1lbnVcIixTY3JvbGw6XCJTY3JvbGxMb2NrXCIsTW96UHJpbnRhYmxlS2V5OlwiVW5pZGVudGlmaWVkXCJ9LE5kPXs4OlwiQmFja3NwYWNlXCIsOTpcIlRhYlwiLDEyOlwiQ2xlYXJcIiwxMzpcIkVudGVyXCIsMTY6XCJTaGlmdFwiLDE3OlwiQ29udHJvbFwiLDE4OlwiQWx0XCIsMTk6XCJQYXVzZVwiLDIwOlwiQ2Fwc0xvY2tcIiwyNzpcIkVzY2FwZVwiLDMyOlwiIFwiLDMzOlwiUGFnZVVwXCIsMzQ6XCJQYWdlRG93blwiLDM1OlwiRW5kXCIsMzY6XCJIb21lXCIsMzc6XCJBcnJvd0xlZnRcIiwzODpcIkFycm93VXBcIiwzOTpcIkFycm93UmlnaHRcIiw0MDpcIkFycm93RG93blwiLDQ1OlwiSW5zZXJ0XCIsNDY6XCJEZWxldGVcIiwxMTI6XCJGMVwiLDExMzpcIkYyXCIsMTE0OlwiRjNcIiwxMTU6XCJGNFwiLDExNjpcIkY1XCIsMTE3OlwiRjZcIiwxMTg6XCJGN1wiLFxuMTE5OlwiRjhcIiwxMjA6XCJGOVwiLDEyMTpcIkYxMFwiLDEyMjpcIkYxMVwiLDEyMzpcIkYxMlwiLDE0NDpcIk51bUxvY2tcIiwxNDU6XCJTY3JvbGxMb2NrXCIsMjI0OlwiTWV0YVwifSxPZD17QWx0OlwiYWx0S2V5XCIsQ29udHJvbDpcImN0cmxLZXlcIixNZXRhOlwibWV0YUtleVwiLFNoaWZ0Olwic2hpZnRLZXlcIn07ZnVuY3Rpb24gUGQoYSl7dmFyIGI9dGhpcy5uYXRpdmVFdmVudDtyZXR1cm4gYi5nZXRNb2RpZmllclN0YXRlP2IuZ2V0TW9kaWZpZXJTdGF0ZShhKTooYT1PZFthXSk/ISFiW2FdOiExfWZ1bmN0aW9uIHpkKCl7cmV0dXJuIFBkfVxudmFyIFFkPW0oe30sdWQse2tleTpmdW5jdGlvbihhKXtpZihhLmtleSl7dmFyIGI9TWRbYS5rZXldfHxhLmtleTtpZihcIlVuaWRlbnRpZmllZFwiIT09YilyZXR1cm4gYn1yZXR1cm5cImtleXByZXNzXCI9PT1hLnR5cGU/KGE9b2QoYSksMTM9PT1hP1wiRW50ZXJcIjpTdHJpbmcuZnJvbUNoYXJDb2RlKGEpKTpcImtleWRvd25cIj09PWEudHlwZXx8XCJrZXl1cFwiPT09YS50eXBlP05kW2Eua2V5Q29kZV18fFwiVW5pZGVudGlmaWVkXCI6XCJcIn0sY29kZTowLGxvY2F0aW9uOjAsY3RybEtleTowLHNoaWZ0S2V5OjAsYWx0S2V5OjAsbWV0YUtleTowLHJlcGVhdDowLGxvY2FsZTowLGdldE1vZGlmaWVyU3RhdGU6emQsY2hhckNvZGU6ZnVuY3Rpb24oYSl7cmV0dXJuXCJrZXlwcmVzc1wiPT09YS50eXBlP29kKGEpOjB9LGtleUNvZGU6ZnVuY3Rpb24oYSl7cmV0dXJuXCJrZXlkb3duXCI9PT1hLnR5cGV8fFwia2V5dXBcIj09PWEudHlwZT9hLmtleUNvZGU6MH0sd2hpY2g6ZnVuY3Rpb24oYSl7cmV0dXJuXCJrZXlwcmVzc1wiPT09XG5hLnR5cGU/b2QoYSk6XCJrZXlkb3duXCI9PT1hLnR5cGV8fFwia2V5dXBcIj09PWEudHlwZT9hLmtleUNvZGU6MH19KSxSZD1yZChRZCksU2Q9bSh7fSxBZCx7cG9pbnRlcklkOjAsd2lkdGg6MCxoZWlnaHQ6MCxwcmVzc3VyZTowLHRhbmdlbnRpYWxQcmVzc3VyZTowLHRpbHRYOjAsdGlsdFk6MCx0d2lzdDowLHBvaW50ZXJUeXBlOjAsaXNQcmltYXJ5OjB9KSxUZD1yZChTZCksVWQ9bSh7fSx1ZCx7dG91Y2hlczowLHRhcmdldFRvdWNoZXM6MCxjaGFuZ2VkVG91Y2hlczowLGFsdEtleTowLG1ldGFLZXk6MCxjdHJsS2V5OjAsc2hpZnRLZXk6MCxnZXRNb2RpZmllclN0YXRlOnpkfSksVmQ9cmQoVWQpLFdkPW0oe30sc2Qse3Byb3BlcnR5TmFtZTowLGVsYXBzZWRUaW1lOjAscHNldWRvRWxlbWVudDowfSksWGQ9cmQoV2QpLFlkPW0oe30sQWQse2RlbHRhWDpmdW5jdGlvbihhKXtyZXR1cm5cImRlbHRhWFwiaW4gYT9hLmRlbHRhWDpcIndoZWVsRGVsdGFYXCJpbiBhPy1hLndoZWVsRGVsdGFYOjB9LFxuZGVsdGFZOmZ1bmN0aW9uKGEpe3JldHVyblwiZGVsdGFZXCJpbiBhP2EuZGVsdGFZOlwid2hlZWxEZWx0YVlcImluIGE/LWEud2hlZWxEZWx0YVk6XCJ3aGVlbERlbHRhXCJpbiBhPy1hLndoZWVsRGVsdGE6MH0sZGVsdGFaOjAsZGVsdGFNb2RlOjB9KSxaZD1yZChZZCksJGQ9WzksMTMsMjcsMzJdLGFlPWZhJiZcIkNvbXBvc2l0aW9uRXZlbnRcImluIHdpbmRvdyxiZT1udWxsO2ZhJiZcImRvY3VtZW50TW9kZVwiaW4gZG9jdW1lbnQmJihiZT1kb2N1bWVudC5kb2N1bWVudE1vZGUpO3ZhciBjZT1mYSYmXCJUZXh0RXZlbnRcImluIHdpbmRvdyYmIWJlLGRlPWZhJiYoIWFlfHxiZSYmODxiZSYmMTE+PWJlKSxlZT1TdHJpbmcuZnJvbUNoYXJDb2RlKDMyKSxmZT0hMTtcbmZ1bmN0aW9uIGdlKGEsYil7c3dpdGNoKGEpe2Nhc2UgXCJrZXl1cFwiOnJldHVybi0xIT09JGQuaW5kZXhPZihiLmtleUNvZGUpO2Nhc2UgXCJrZXlkb3duXCI6cmV0dXJuIDIyOSE9PWIua2V5Q29kZTtjYXNlIFwia2V5cHJlc3NcIjpjYXNlIFwibW91c2Vkb3duXCI6Y2FzZSBcImZvY3Vzb3V0XCI6cmV0dXJuITA7ZGVmYXVsdDpyZXR1cm4hMX19ZnVuY3Rpb24gaGUoYSl7YT1hLmRldGFpbDtyZXR1cm5cIm9iamVjdFwiPT09dHlwZW9mIGEmJlwiZGF0YVwiaW4gYT9hLmRhdGE6bnVsbH12YXIgaWU9ITE7ZnVuY3Rpb24gamUoYSxiKXtzd2l0Y2goYSl7Y2FzZSBcImNvbXBvc2l0aW9uZW5kXCI6cmV0dXJuIGhlKGIpO2Nhc2UgXCJrZXlwcmVzc1wiOmlmKDMyIT09Yi53aGljaClyZXR1cm4gbnVsbDtmZT0hMDtyZXR1cm4gZWU7Y2FzZSBcInRleHRJbnB1dFwiOnJldHVybiBhPWIuZGF0YSxhPT09ZWUmJmZlP251bGw6YTtkZWZhdWx0OnJldHVybiBudWxsfX1cbmZ1bmN0aW9uIGtlKGEsYil7aWYoaWUpcmV0dXJuXCJjb21wb3NpdGlvbmVuZFwiPT09YXx8IWFlJiZnZShhLGIpPyhhPW5kKCksbWQ9bGQ9a2Q9bnVsbCxpZT0hMSxhKTpudWxsO3N3aXRjaChhKXtjYXNlIFwicGFzdGVcIjpyZXR1cm4gbnVsbDtjYXNlIFwia2V5cHJlc3NcIjppZighKGIuY3RybEtleXx8Yi5hbHRLZXl8fGIubWV0YUtleSl8fGIuY3RybEtleSYmYi5hbHRLZXkpe2lmKGIuY2hhciYmMTxiLmNoYXIubGVuZ3RoKXJldHVybiBiLmNoYXI7aWYoYi53aGljaClyZXR1cm4gU3RyaW5nLmZyb21DaGFyQ29kZShiLndoaWNoKX1yZXR1cm4gbnVsbDtjYXNlIFwiY29tcG9zaXRpb25lbmRcIjpyZXR1cm4gZGUmJlwia29cIiE9PWIubG9jYWxlP251bGw6Yi5kYXRhO2RlZmF1bHQ6cmV0dXJuIG51bGx9fVxudmFyIGxlPXtjb2xvcjohMCxkYXRlOiEwLGRhdGV0aW1lOiEwLFwiZGF0ZXRpbWUtbG9jYWxcIjohMCxlbWFpbDohMCxtb250aDohMCxudW1iZXI6ITAscGFzc3dvcmQ6ITAscmFuZ2U6ITAsc2VhcmNoOiEwLHRlbDohMCx0ZXh0OiEwLHRpbWU6ITAsdXJsOiEwLHdlZWs6ITB9O2Z1bmN0aW9uIG1lKGEpe3ZhciBiPWEmJmEubm9kZU5hbWUmJmEubm9kZU5hbWUudG9Mb3dlckNhc2UoKTtyZXR1cm5cImlucHV0XCI9PT1iPyEhbGVbYS50eXBlXTpcInRleHRhcmVhXCI9PT1iPyEwOiExfWZ1bmN0aW9uIG5lKGEsYixjLGQpe0ViKGQpO2I9b2UoYixcIm9uQ2hhbmdlXCIpOzA8Yi5sZW5ndGgmJihjPW5ldyB0ZChcIm9uQ2hhbmdlXCIsXCJjaGFuZ2VcIixudWxsLGMsZCksYS5wdXNoKHtldmVudDpjLGxpc3RlbmVyczpifSkpfXZhciBwZT1udWxsLHFlPW51bGw7ZnVuY3Rpb24gcmUoYSl7c2UoYSwwKX1mdW5jdGlvbiB0ZShhKXt2YXIgYj11ZShhKTtpZihXYShiKSlyZXR1cm4gYX1cbmZ1bmN0aW9uIHZlKGEsYil7aWYoXCJjaGFuZ2VcIj09PWEpcmV0dXJuIGJ9dmFyIHdlPSExO2lmKGZhKXt2YXIgeGU7aWYoZmEpe3ZhciB5ZT1cIm9uaW5wdXRcImluIGRvY3VtZW50O2lmKCF5ZSl7dmFyIHplPWRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoXCJkaXZcIik7emUuc2V0QXR0cmlidXRlKFwib25pbnB1dFwiLFwicmV0dXJuO1wiKTt5ZT1cImZ1bmN0aW9uXCI9PT10eXBlb2YgemUub25pbnB1dH14ZT15ZX1lbHNlIHhlPSExO3dlPXhlJiYoIWRvY3VtZW50LmRvY3VtZW50TW9kZXx8OTxkb2N1bWVudC5kb2N1bWVudE1vZGUpfWZ1bmN0aW9uIEFlKCl7cGUmJihwZS5kZXRhY2hFdmVudChcIm9ucHJvcGVydHljaGFuZ2VcIixCZSkscWU9cGU9bnVsbCl9ZnVuY3Rpb24gQmUoYSl7aWYoXCJ2YWx1ZVwiPT09YS5wcm9wZXJ0eU5hbWUmJnRlKHFlKSl7dmFyIGI9W107bmUoYixxZSxhLHhiKGEpKTthPXJlO2lmKEtiKWEoYik7ZWxzZXtLYj0hMDt0cnl7R2IoYSxiKX1maW5hbGx5e0tiPSExLE1iKCl9fX19XG5mdW5jdGlvbiBDZShhLGIsYyl7XCJmb2N1c2luXCI9PT1hPyhBZSgpLHBlPWIscWU9YyxwZS5hdHRhY2hFdmVudChcIm9ucHJvcGVydHljaGFuZ2VcIixCZSkpOlwiZm9jdXNvdXRcIj09PWEmJkFlKCl9ZnVuY3Rpb24gRGUoYSl7aWYoXCJzZWxlY3Rpb25jaGFuZ2VcIj09PWF8fFwia2V5dXBcIj09PWF8fFwia2V5ZG93blwiPT09YSlyZXR1cm4gdGUocWUpfWZ1bmN0aW9uIEVlKGEsYil7aWYoXCJjbGlja1wiPT09YSlyZXR1cm4gdGUoYil9ZnVuY3Rpb24gRmUoYSxiKXtpZihcImlucHV0XCI9PT1hfHxcImNoYW5nZVwiPT09YSlyZXR1cm4gdGUoYil9ZnVuY3Rpb24gR2UoYSxiKXtyZXR1cm4gYT09PWImJigwIT09YXx8MS9hPT09MS9iKXx8YSE9PWEmJmIhPT1ifXZhciBIZT1cImZ1bmN0aW9uXCI9PT10eXBlb2YgT2JqZWN0LmlzP09iamVjdC5pczpHZSxJZT1PYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5O1xuZnVuY3Rpb24gSmUoYSxiKXtpZihIZShhLGIpKXJldHVybiEwO2lmKFwib2JqZWN0XCIhPT10eXBlb2YgYXx8bnVsbD09PWF8fFwib2JqZWN0XCIhPT10eXBlb2YgYnx8bnVsbD09PWIpcmV0dXJuITE7dmFyIGM9T2JqZWN0LmtleXMoYSksZD1PYmplY3Qua2V5cyhiKTtpZihjLmxlbmd0aCE9PWQubGVuZ3RoKXJldHVybiExO2ZvcihkPTA7ZDxjLmxlbmd0aDtkKyspaWYoIUllLmNhbGwoYixjW2RdKXx8IUhlKGFbY1tkXV0sYltjW2RdXSkpcmV0dXJuITE7cmV0dXJuITB9ZnVuY3Rpb24gS2UoYSl7Zm9yKDthJiZhLmZpcnN0Q2hpbGQ7KWE9YS5maXJzdENoaWxkO3JldHVybiBhfVxuZnVuY3Rpb24gTGUoYSxiKXt2YXIgYz1LZShhKTthPTA7Zm9yKHZhciBkO2M7KXtpZigzPT09Yy5ub2RlVHlwZSl7ZD1hK2MudGV4dENvbnRlbnQubGVuZ3RoO2lmKGE8PWImJmQ+PWIpcmV0dXJue25vZGU6YyxvZmZzZXQ6Yi1hfTthPWR9YTp7Zm9yKDtjOyl7aWYoYy5uZXh0U2libGluZyl7Yz1jLm5leHRTaWJsaW5nO2JyZWFrIGF9Yz1jLnBhcmVudE5vZGV9Yz12b2lkIDB9Yz1LZShjKX19ZnVuY3Rpb24gTWUoYSxiKXtyZXR1cm4gYSYmYj9hPT09Yj8hMDphJiYzPT09YS5ub2RlVHlwZT8hMTpiJiYzPT09Yi5ub2RlVHlwZT9NZShhLGIucGFyZW50Tm9kZSk6XCJjb250YWluc1wiaW4gYT9hLmNvbnRhaW5zKGIpOmEuY29tcGFyZURvY3VtZW50UG9zaXRpb24/ISEoYS5jb21wYXJlRG9jdW1lbnRQb3NpdGlvbihiKSYxNik6ITE6ITF9XG5mdW5jdGlvbiBOZSgpe2Zvcih2YXIgYT13aW5kb3csYj1YYSgpO2IgaW5zdGFuY2VvZiBhLkhUTUxJRnJhbWVFbGVtZW50Oyl7dHJ5e3ZhciBjPVwic3RyaW5nXCI9PT10eXBlb2YgYi5jb250ZW50V2luZG93LmxvY2F0aW9uLmhyZWZ9Y2F0Y2goZCl7Yz0hMX1pZihjKWE9Yi5jb250ZW50V2luZG93O2Vsc2UgYnJlYWs7Yj1YYShhLmRvY3VtZW50KX1yZXR1cm4gYn1mdW5jdGlvbiBPZShhKXt2YXIgYj1hJiZhLm5vZGVOYW1lJiZhLm5vZGVOYW1lLnRvTG93ZXJDYXNlKCk7cmV0dXJuIGImJihcImlucHV0XCI9PT1iJiYoXCJ0ZXh0XCI9PT1hLnR5cGV8fFwic2VhcmNoXCI9PT1hLnR5cGV8fFwidGVsXCI9PT1hLnR5cGV8fFwidXJsXCI9PT1hLnR5cGV8fFwicGFzc3dvcmRcIj09PWEudHlwZSl8fFwidGV4dGFyZWFcIj09PWJ8fFwidHJ1ZVwiPT09YS5jb250ZW50RWRpdGFibGUpfVxudmFyIFBlPWZhJiZcImRvY3VtZW50TW9kZVwiaW4gZG9jdW1lbnQmJjExPj1kb2N1bWVudC5kb2N1bWVudE1vZGUsUWU9bnVsbCxSZT1udWxsLFNlPW51bGwsVGU9ITE7XG5mdW5jdGlvbiBVZShhLGIsYyl7dmFyIGQ9Yy53aW5kb3c9PT1jP2MuZG9jdW1lbnQ6OT09PWMubm9kZVR5cGU/YzpjLm93bmVyRG9jdW1lbnQ7VGV8fG51bGw9PVFlfHxRZSE9PVhhKGQpfHwoZD1RZSxcInNlbGVjdGlvblN0YXJ0XCJpbiBkJiZPZShkKT9kPXtzdGFydDpkLnNlbGVjdGlvblN0YXJ0LGVuZDpkLnNlbGVjdGlvbkVuZH06KGQ9KGQub3duZXJEb2N1bWVudCYmZC5vd25lckRvY3VtZW50LmRlZmF1bHRWaWV3fHx3aW5kb3cpLmdldFNlbGVjdGlvbigpLGQ9e2FuY2hvck5vZGU6ZC5hbmNob3JOb2RlLGFuY2hvck9mZnNldDpkLmFuY2hvck9mZnNldCxmb2N1c05vZGU6ZC5mb2N1c05vZGUsZm9jdXNPZmZzZXQ6ZC5mb2N1c09mZnNldH0pLFNlJiZKZShTZSxkKXx8KFNlPWQsZD1vZShSZSxcIm9uU2VsZWN0XCIpLDA8ZC5sZW5ndGgmJihiPW5ldyB0ZChcIm9uU2VsZWN0XCIsXCJzZWxlY3RcIixudWxsLGIsYyksYS5wdXNoKHtldmVudDpiLGxpc3RlbmVyczpkfSksYi50YXJnZXQ9UWUpKSl9XG5QYyhcImNhbmNlbCBjYW5jZWwgY2xpY2sgY2xpY2sgY2xvc2UgY2xvc2UgY29udGV4dG1lbnUgY29udGV4dE1lbnUgY29weSBjb3B5IGN1dCBjdXQgYXV4Y2xpY2sgYXV4Q2xpY2sgZGJsY2xpY2sgZG91YmxlQ2xpY2sgZHJhZ2VuZCBkcmFnRW5kIGRyYWdzdGFydCBkcmFnU3RhcnQgZHJvcCBkcm9wIGZvY3VzaW4gZm9jdXMgZm9jdXNvdXQgYmx1ciBpbnB1dCBpbnB1dCBpbnZhbGlkIGludmFsaWQga2V5ZG93biBrZXlEb3duIGtleXByZXNzIGtleVByZXNzIGtleXVwIGtleVVwIG1vdXNlZG93biBtb3VzZURvd24gbW91c2V1cCBtb3VzZVVwIHBhc3RlIHBhc3RlIHBhdXNlIHBhdXNlIHBsYXkgcGxheSBwb2ludGVyY2FuY2VsIHBvaW50ZXJDYW5jZWwgcG9pbnRlcmRvd24gcG9pbnRlckRvd24gcG9pbnRlcnVwIHBvaW50ZXJVcCByYXRlY2hhbmdlIHJhdGVDaGFuZ2UgcmVzZXQgcmVzZXQgc2Vla2VkIHNlZWtlZCBzdWJtaXQgc3VibWl0IHRvdWNoY2FuY2VsIHRvdWNoQ2FuY2VsIHRvdWNoZW5kIHRvdWNoRW5kIHRvdWNoc3RhcnQgdG91Y2hTdGFydCB2b2x1bWVjaGFuZ2Ugdm9sdW1lQ2hhbmdlXCIuc3BsaXQoXCIgXCIpLFxuMCk7UGMoXCJkcmFnIGRyYWcgZHJhZ2VudGVyIGRyYWdFbnRlciBkcmFnZXhpdCBkcmFnRXhpdCBkcmFnbGVhdmUgZHJhZ0xlYXZlIGRyYWdvdmVyIGRyYWdPdmVyIG1vdXNlbW92ZSBtb3VzZU1vdmUgbW91c2VvdXQgbW91c2VPdXQgbW91c2VvdmVyIG1vdXNlT3ZlciBwb2ludGVybW92ZSBwb2ludGVyTW92ZSBwb2ludGVyb3V0IHBvaW50ZXJPdXQgcG9pbnRlcm92ZXIgcG9pbnRlck92ZXIgc2Nyb2xsIHNjcm9sbCB0b2dnbGUgdG9nZ2xlIHRvdWNobW92ZSB0b3VjaE1vdmUgd2hlZWwgd2hlZWxcIi5zcGxpdChcIiBcIiksMSk7UGMoT2MsMik7Zm9yKHZhciBWZT1cImNoYW5nZSBzZWxlY3Rpb25jaGFuZ2UgdGV4dElucHV0IGNvbXBvc2l0aW9uc3RhcnQgY29tcG9zaXRpb25lbmQgY29tcG9zaXRpb251cGRhdGVcIi5zcGxpdChcIiBcIiksV2U9MDtXZTxWZS5sZW5ndGg7V2UrKylOYy5zZXQoVmVbV2VdLDApO2VhKFwib25Nb3VzZUVudGVyXCIsW1wibW91c2VvdXRcIixcIm1vdXNlb3ZlclwiXSk7XG5lYShcIm9uTW91c2VMZWF2ZVwiLFtcIm1vdXNlb3V0XCIsXCJtb3VzZW92ZXJcIl0pO2VhKFwib25Qb2ludGVyRW50ZXJcIixbXCJwb2ludGVyb3V0XCIsXCJwb2ludGVyb3ZlclwiXSk7ZWEoXCJvblBvaW50ZXJMZWF2ZVwiLFtcInBvaW50ZXJvdXRcIixcInBvaW50ZXJvdmVyXCJdKTtkYShcIm9uQ2hhbmdlXCIsXCJjaGFuZ2UgY2xpY2sgZm9jdXNpbiBmb2N1c291dCBpbnB1dCBrZXlkb3duIGtleXVwIHNlbGVjdGlvbmNoYW5nZVwiLnNwbGl0KFwiIFwiKSk7ZGEoXCJvblNlbGVjdFwiLFwiZm9jdXNvdXQgY29udGV4dG1lbnUgZHJhZ2VuZCBmb2N1c2luIGtleWRvd24ga2V5dXAgbW91c2Vkb3duIG1vdXNldXAgc2VsZWN0aW9uY2hhbmdlXCIuc3BsaXQoXCIgXCIpKTtkYShcIm9uQmVmb3JlSW5wdXRcIixbXCJjb21wb3NpdGlvbmVuZFwiLFwia2V5cHJlc3NcIixcInRleHRJbnB1dFwiLFwicGFzdGVcIl0pO2RhKFwib25Db21wb3NpdGlvbkVuZFwiLFwiY29tcG9zaXRpb25lbmQgZm9jdXNvdXQga2V5ZG93biBrZXlwcmVzcyBrZXl1cCBtb3VzZWRvd25cIi5zcGxpdChcIiBcIikpO1xuZGEoXCJvbkNvbXBvc2l0aW9uU3RhcnRcIixcImNvbXBvc2l0aW9uc3RhcnQgZm9jdXNvdXQga2V5ZG93biBrZXlwcmVzcyBrZXl1cCBtb3VzZWRvd25cIi5zcGxpdChcIiBcIikpO2RhKFwib25Db21wb3NpdGlvblVwZGF0ZVwiLFwiY29tcG9zaXRpb251cGRhdGUgZm9jdXNvdXQga2V5ZG93biBrZXlwcmVzcyBrZXl1cCBtb3VzZWRvd25cIi5zcGxpdChcIiBcIikpO3ZhciBYZT1cImFib3J0IGNhbnBsYXkgY2FucGxheXRocm91Z2ggZHVyYXRpb25jaGFuZ2UgZW1wdGllZCBlbmNyeXB0ZWQgZW5kZWQgZXJyb3IgbG9hZGVkZGF0YSBsb2FkZWRtZXRhZGF0YSBsb2Fkc3RhcnQgcGF1c2UgcGxheSBwbGF5aW5nIHByb2dyZXNzIHJhdGVjaGFuZ2Ugc2Vla2VkIHNlZWtpbmcgc3RhbGxlZCBzdXNwZW5kIHRpbWV1cGRhdGUgdm9sdW1lY2hhbmdlIHdhaXRpbmdcIi5zcGxpdChcIiBcIiksWWU9bmV3IFNldChcImNhbmNlbCBjbG9zZSBpbnZhbGlkIGxvYWQgc2Nyb2xsIHRvZ2dsZVwiLnNwbGl0KFwiIFwiKS5jb25jYXQoWGUpKTtcbmZ1bmN0aW9uIFplKGEsYixjKXt2YXIgZD1hLnR5cGV8fFwidW5rbm93bi1ldmVudFwiO2EuY3VycmVudFRhcmdldD1jO1liKGQsYix2b2lkIDAsYSk7YS5jdXJyZW50VGFyZ2V0PW51bGx9XG5mdW5jdGlvbiBzZShhLGIpe2I9MCE9PShiJjQpO2Zvcih2YXIgYz0wO2M8YS5sZW5ndGg7YysrKXt2YXIgZD1hW2NdLGU9ZC5ldmVudDtkPWQubGlzdGVuZXJzO2E6e3ZhciBmPXZvaWQgMDtpZihiKWZvcih2YXIgZz1kLmxlbmd0aC0xOzA8PWc7Zy0tKXt2YXIgaD1kW2ddLGs9aC5pbnN0YW5jZSxsPWguY3VycmVudFRhcmdldDtoPWgubGlzdGVuZXI7aWYoayE9PWYmJmUuaXNQcm9wYWdhdGlvblN0b3BwZWQoKSlicmVhayBhO1plKGUsaCxsKTtmPWt9ZWxzZSBmb3IoZz0wO2c8ZC5sZW5ndGg7ZysrKXtoPWRbZ107az1oLmluc3RhbmNlO2w9aC5jdXJyZW50VGFyZ2V0O2g9aC5saXN0ZW5lcjtpZihrIT09ZiYmZS5pc1Byb3BhZ2F0aW9uU3RvcHBlZCgpKWJyZWFrIGE7WmUoZSxoLGwpO2Y9a319fWlmKFViKXRocm93IGE9VmIsVWI9ITEsVmI9bnVsbCxhO31cbmZ1bmN0aW9uIEcoYSxiKXt2YXIgYz0kZShiKSxkPWErXCJfX2J1YmJsZVwiO2MuaGFzKGQpfHwoYWYoYixhLDIsITEpLGMuYWRkKGQpKX12YXIgYmY9XCJfcmVhY3RMaXN0ZW5pbmdcIitNYXRoLnJhbmRvbSgpLnRvU3RyaW5nKDM2KS5zbGljZSgyKTtmdW5jdGlvbiBjZihhKXthW2JmXXx8KGFbYmZdPSEwLGJhLmZvckVhY2goZnVuY3Rpb24oYil7WWUuaGFzKGIpfHxkZihiLCExLGEsbnVsbCk7ZGYoYiwhMCxhLG51bGwpfSkpfVxuZnVuY3Rpb24gZGYoYSxiLGMsZCl7dmFyIGU9NDxhcmd1bWVudHMubGVuZ3RoJiZ2b2lkIDAhPT1hcmd1bWVudHNbNF0/YXJndW1lbnRzWzRdOjAsZj1jO1wic2VsZWN0aW9uY2hhbmdlXCI9PT1hJiY5IT09Yy5ub2RlVHlwZSYmKGY9Yy5vd25lckRvY3VtZW50KTtpZihudWxsIT09ZCYmIWImJlllLmhhcyhhKSl7aWYoXCJzY3JvbGxcIiE9PWEpcmV0dXJuO2V8PTI7Zj1kfXZhciBnPSRlKGYpLGg9YStcIl9fXCIrKGI/XCJjYXB0dXJlXCI6XCJidWJibGVcIik7Zy5oYXMoaCl8fChiJiYoZXw9NCksYWYoZixhLGUsYiksZy5hZGQoaCkpfVxuZnVuY3Rpb24gYWYoYSxiLGMsZCl7dmFyIGU9TmMuZ2V0KGIpO3N3aXRjaCh2b2lkIDA9PT1lPzI6ZSl7Y2FzZSAwOmU9Z2Q7YnJlYWs7Y2FzZSAxOmU9aWQ7YnJlYWs7ZGVmYXVsdDplPWhkfWM9ZS5iaW5kKG51bGwsYixjLGEpO2U9dm9pZCAwOyFQYnx8XCJ0b3VjaHN0YXJ0XCIhPT1iJiZcInRvdWNobW92ZVwiIT09YiYmXCJ3aGVlbFwiIT09Ynx8KGU9ITApO2Q/dm9pZCAwIT09ZT9hLmFkZEV2ZW50TGlzdGVuZXIoYixjLHtjYXB0dXJlOiEwLHBhc3NpdmU6ZX0pOmEuYWRkRXZlbnRMaXN0ZW5lcihiLGMsITApOnZvaWQgMCE9PWU/YS5hZGRFdmVudExpc3RlbmVyKGIsYyx7cGFzc2l2ZTplfSk6YS5hZGRFdmVudExpc3RlbmVyKGIsYywhMSl9XG5mdW5jdGlvbiBqZChhLGIsYyxkLGUpe3ZhciBmPWQ7aWYoMD09PShiJjEpJiYwPT09KGImMikmJm51bGwhPT1kKWE6Zm9yKDs7KXtpZihudWxsPT09ZClyZXR1cm47dmFyIGc9ZC50YWc7aWYoMz09PWd8fDQ9PT1nKXt2YXIgaD1kLnN0YXRlTm9kZS5jb250YWluZXJJbmZvO2lmKGg9PT1lfHw4PT09aC5ub2RlVHlwZSYmaC5wYXJlbnROb2RlPT09ZSlicmVhaztpZig0PT09Zylmb3IoZz1kLnJldHVybjtudWxsIT09Zzspe3ZhciBrPWcudGFnO2lmKDM9PT1rfHw0PT09aylpZihrPWcuc3RhdGVOb2RlLmNvbnRhaW5lckluZm8saz09PWV8fDg9PT1rLm5vZGVUeXBlJiZrLnBhcmVudE5vZGU9PT1lKXJldHVybjtnPWcucmV0dXJufWZvcig7bnVsbCE9PWg7KXtnPXdjKGgpO2lmKG51bGw9PT1nKXJldHVybjtrPWcudGFnO2lmKDU9PT1rfHw2PT09ayl7ZD1mPWc7Y29udGludWUgYX1oPWgucGFyZW50Tm9kZX19ZD1kLnJldHVybn1OYihmdW5jdGlvbigpe3ZhciBkPWYsZT14YihjKSxnPVtdO1xuYTp7dmFyIGg9TWMuZ2V0KGEpO2lmKHZvaWQgMCE9PWgpe3ZhciBrPXRkLHg9YTtzd2l0Y2goYSl7Y2FzZSBcImtleXByZXNzXCI6aWYoMD09PW9kKGMpKWJyZWFrIGE7Y2FzZSBcImtleWRvd25cIjpjYXNlIFwia2V5dXBcIjprPVJkO2JyZWFrO2Nhc2UgXCJmb2N1c2luXCI6eD1cImZvY3VzXCI7az1GZDticmVhaztjYXNlIFwiZm9jdXNvdXRcIjp4PVwiYmx1clwiO2s9RmQ7YnJlYWs7Y2FzZSBcImJlZm9yZWJsdXJcIjpjYXNlIFwiYWZ0ZXJibHVyXCI6az1GZDticmVhaztjYXNlIFwiY2xpY2tcIjppZigyPT09Yy5idXR0b24pYnJlYWsgYTtjYXNlIFwiYXV4Y2xpY2tcIjpjYXNlIFwiZGJsY2xpY2tcIjpjYXNlIFwibW91c2Vkb3duXCI6Y2FzZSBcIm1vdXNlbW92ZVwiOmNhc2UgXCJtb3VzZXVwXCI6Y2FzZSBcIm1vdXNlb3V0XCI6Y2FzZSBcIm1vdXNlb3ZlclwiOmNhc2UgXCJjb250ZXh0bWVudVwiOms9QmQ7YnJlYWs7Y2FzZSBcImRyYWdcIjpjYXNlIFwiZHJhZ2VuZFwiOmNhc2UgXCJkcmFnZW50ZXJcIjpjYXNlIFwiZHJhZ2V4aXRcIjpjYXNlIFwiZHJhZ2xlYXZlXCI6Y2FzZSBcImRyYWdvdmVyXCI6Y2FzZSBcImRyYWdzdGFydFwiOmNhc2UgXCJkcm9wXCI6az1cbkRkO2JyZWFrO2Nhc2UgXCJ0b3VjaGNhbmNlbFwiOmNhc2UgXCJ0b3VjaGVuZFwiOmNhc2UgXCJ0b3VjaG1vdmVcIjpjYXNlIFwidG91Y2hzdGFydFwiOms9VmQ7YnJlYWs7Y2FzZSBJYzpjYXNlIEpjOmNhc2UgS2M6az1IZDticmVhaztjYXNlIExjOms9WGQ7YnJlYWs7Y2FzZSBcInNjcm9sbFwiOms9dmQ7YnJlYWs7Y2FzZSBcIndoZWVsXCI6az1aZDticmVhaztjYXNlIFwiY29weVwiOmNhc2UgXCJjdXRcIjpjYXNlIFwicGFzdGVcIjprPUpkO2JyZWFrO2Nhc2UgXCJnb3Rwb2ludGVyY2FwdHVyZVwiOmNhc2UgXCJsb3N0cG9pbnRlcmNhcHR1cmVcIjpjYXNlIFwicG9pbnRlcmNhbmNlbFwiOmNhc2UgXCJwb2ludGVyZG93blwiOmNhc2UgXCJwb2ludGVybW92ZVwiOmNhc2UgXCJwb2ludGVyb3V0XCI6Y2FzZSBcInBvaW50ZXJvdmVyXCI6Y2FzZSBcInBvaW50ZXJ1cFwiOms9VGR9dmFyIHc9MCE9PShiJjQpLHo9IXcmJlwic2Nyb2xsXCI9PT1hLHU9dz9udWxsIT09aD9oK1wiQ2FwdHVyZVwiOm51bGw6aDt3PVtdO2Zvcih2YXIgdD1kLHE7bnVsbCE9PVxudDspe3E9dDt2YXIgdj1xLnN0YXRlTm9kZTs1PT09cS50YWcmJm51bGwhPT12JiYocT12LG51bGwhPT11JiYodj1PYih0LHUpLG51bGwhPXYmJncucHVzaChlZih0LHYscSkpKSk7aWYoeilicmVhazt0PXQucmV0dXJufTA8dy5sZW5ndGgmJihoPW5ldyBrKGgseCxudWxsLGMsZSksZy5wdXNoKHtldmVudDpoLGxpc3RlbmVyczp3fSkpfX1pZigwPT09KGImNykpe2E6e2g9XCJtb3VzZW92ZXJcIj09PWF8fFwicG9pbnRlcm92ZXJcIj09PWE7az1cIm1vdXNlb3V0XCI9PT1hfHxcInBvaW50ZXJvdXRcIj09PWE7aWYoaCYmMD09PShiJjE2KSYmKHg9Yy5yZWxhdGVkVGFyZ2V0fHxjLmZyb21FbGVtZW50KSYmKHdjKHgpfHx4W2ZmXSkpYnJlYWsgYTtpZihrfHxoKXtoPWUud2luZG93PT09ZT9lOihoPWUub3duZXJEb2N1bWVudCk/aC5kZWZhdWx0Vmlld3x8aC5wYXJlbnRXaW5kb3c6d2luZG93O2lmKGspe2lmKHg9Yy5yZWxhdGVkVGFyZ2V0fHxjLnRvRWxlbWVudCxrPWQseD14P3djKHgpOm51bGwsbnVsbCE9PVxueCYmKHo9WmIoeCkseCE9PXp8fDUhPT14LnRhZyYmNiE9PXgudGFnKSl4PW51bGx9ZWxzZSBrPW51bGwseD1kO2lmKGshPT14KXt3PUJkO3Y9XCJvbk1vdXNlTGVhdmVcIjt1PVwib25Nb3VzZUVudGVyXCI7dD1cIm1vdXNlXCI7aWYoXCJwb2ludGVyb3V0XCI9PT1hfHxcInBvaW50ZXJvdmVyXCI9PT1hKXc9VGQsdj1cIm9uUG9pbnRlckxlYXZlXCIsdT1cIm9uUG9pbnRlckVudGVyXCIsdD1cInBvaW50ZXJcIjt6PW51bGw9PWs/aDp1ZShrKTtxPW51bGw9PXg/aDp1ZSh4KTtoPW5ldyB3KHYsdCtcImxlYXZlXCIsayxjLGUpO2gudGFyZ2V0PXo7aC5yZWxhdGVkVGFyZ2V0PXE7dj1udWxsO3djKGUpPT09ZCYmKHc9bmV3IHcodSx0K1wiZW50ZXJcIix4LGMsZSksdy50YXJnZXQ9cSx3LnJlbGF0ZWRUYXJnZXQ9eix2PXcpO3o9djtpZihrJiZ4KWI6e3c9azt1PXg7dD0wO2ZvcihxPXc7cTtxPWdmKHEpKXQrKztxPTA7Zm9yKHY9dTt2O3Y9Z2YodikpcSsrO2Zvcig7MDx0LXE7KXc9Z2YodyksdC0tO2Zvcig7MDxxLXQ7KXU9XG5nZih1KSxxLS07Zm9yKDt0LS07KXtpZih3PT09dXx8bnVsbCE9PXUmJnc9PT11LmFsdGVybmF0ZSlicmVhayBiO3c9Z2Yodyk7dT1nZih1KX13PW51bGx9ZWxzZSB3PW51bGw7bnVsbCE9PWsmJmhmKGcsaCxrLHcsITEpO251bGwhPT14JiZudWxsIT09eiYmaGYoZyx6LHgsdywhMCl9fX1hOntoPWQ/dWUoZCk6d2luZG93O2s9aC5ub2RlTmFtZSYmaC5ub2RlTmFtZS50b0xvd2VyQ2FzZSgpO2lmKFwic2VsZWN0XCI9PT1rfHxcImlucHV0XCI9PT1rJiZcImZpbGVcIj09PWgudHlwZSl2YXIgSj12ZTtlbHNlIGlmKG1lKGgpKWlmKHdlKUo9RmU7ZWxzZXtKPURlO3ZhciBLPUNlfWVsc2Uoaz1oLm5vZGVOYW1lKSYmXCJpbnB1dFwiPT09ay50b0xvd2VyQ2FzZSgpJiYoXCJjaGVja2JveFwiPT09aC50eXBlfHxcInJhZGlvXCI9PT1oLnR5cGUpJiYoSj1FZSk7aWYoSiYmKEo9SihhLGQpKSl7bmUoZyxKLGMsZSk7YnJlYWsgYX1LJiZLKGEsaCxkKTtcImZvY3Vzb3V0XCI9PT1hJiYoSz1oLl93cmFwcGVyU3RhdGUpJiZcbksuY29udHJvbGxlZCYmXCJudW1iZXJcIj09PWgudHlwZSYmYmIoaCxcIm51bWJlclwiLGgudmFsdWUpfUs9ZD91ZShkKTp3aW5kb3c7c3dpdGNoKGEpe2Nhc2UgXCJmb2N1c2luXCI6aWYobWUoSyl8fFwidHJ1ZVwiPT09Sy5jb250ZW50RWRpdGFibGUpUWU9SyxSZT1kLFNlPW51bGw7YnJlYWs7Y2FzZSBcImZvY3Vzb3V0XCI6U2U9UmU9UWU9bnVsbDticmVhaztjYXNlIFwibW91c2Vkb3duXCI6VGU9ITA7YnJlYWs7Y2FzZSBcImNvbnRleHRtZW51XCI6Y2FzZSBcIm1vdXNldXBcIjpjYXNlIFwiZHJhZ2VuZFwiOlRlPSExO1VlKGcsYyxlKTticmVhaztjYXNlIFwic2VsZWN0aW9uY2hhbmdlXCI6aWYoUGUpYnJlYWs7Y2FzZSBcImtleWRvd25cIjpjYXNlIFwia2V5dXBcIjpVZShnLGMsZSl9dmFyIFE7aWYoYWUpYjp7c3dpdGNoKGEpe2Nhc2UgXCJjb21wb3NpdGlvbnN0YXJ0XCI6dmFyIEw9XCJvbkNvbXBvc2l0aW9uU3RhcnRcIjticmVhayBiO2Nhc2UgXCJjb21wb3NpdGlvbmVuZFwiOkw9XCJvbkNvbXBvc2l0aW9uRW5kXCI7YnJlYWsgYjtcbmNhc2UgXCJjb21wb3NpdGlvbnVwZGF0ZVwiOkw9XCJvbkNvbXBvc2l0aW9uVXBkYXRlXCI7YnJlYWsgYn1MPXZvaWQgMH1lbHNlIGllP2dlKGEsYykmJihMPVwib25Db21wb3NpdGlvbkVuZFwiKTpcImtleWRvd25cIj09PWEmJjIyOT09PWMua2V5Q29kZSYmKEw9XCJvbkNvbXBvc2l0aW9uU3RhcnRcIik7TCYmKGRlJiZcImtvXCIhPT1jLmxvY2FsZSYmKGllfHxcIm9uQ29tcG9zaXRpb25TdGFydFwiIT09TD9cIm9uQ29tcG9zaXRpb25FbmRcIj09PUwmJmllJiYoUT1uZCgpKTooa2Q9ZSxsZD1cInZhbHVlXCJpbiBrZD9rZC52YWx1ZTprZC50ZXh0Q29udGVudCxpZT0hMCkpLEs9b2UoZCxMKSwwPEsubGVuZ3RoJiYoTD1uZXcgTGQoTCxhLG51bGwsYyxlKSxnLnB1c2goe2V2ZW50OkwsbGlzdGVuZXJzOkt9KSxRP0wuZGF0YT1ROihRPWhlKGMpLG51bGwhPT1RJiYoTC5kYXRhPVEpKSkpO2lmKFE9Y2U/amUoYSxjKTprZShhLGMpKWQ9b2UoZCxcIm9uQmVmb3JlSW5wdXRcIiksMDxkLmxlbmd0aCYmKGU9bmV3IExkKFwib25CZWZvcmVJbnB1dFwiLFxuXCJiZWZvcmVpbnB1dFwiLG51bGwsYyxlKSxnLnB1c2goe2V2ZW50OmUsbGlzdGVuZXJzOmR9KSxlLmRhdGE9USl9c2UoZyxiKX0pfWZ1bmN0aW9uIGVmKGEsYixjKXtyZXR1cm57aW5zdGFuY2U6YSxsaXN0ZW5lcjpiLGN1cnJlbnRUYXJnZXQ6Y319ZnVuY3Rpb24gb2UoYSxiKXtmb3IodmFyIGM9YitcIkNhcHR1cmVcIixkPVtdO251bGwhPT1hOyl7dmFyIGU9YSxmPWUuc3RhdGVOb2RlOzU9PT1lLnRhZyYmbnVsbCE9PWYmJihlPWYsZj1PYihhLGMpLG51bGwhPWYmJmQudW5zaGlmdChlZihhLGYsZSkpLGY9T2IoYSxiKSxudWxsIT1mJiZkLnB1c2goZWYoYSxmLGUpKSk7YT1hLnJldHVybn1yZXR1cm4gZH1mdW5jdGlvbiBnZihhKXtpZihudWxsPT09YSlyZXR1cm4gbnVsbDtkbyBhPWEucmV0dXJuO3doaWxlKGEmJjUhPT1hLnRhZyk7cmV0dXJuIGE/YTpudWxsfVxuZnVuY3Rpb24gaGYoYSxiLGMsZCxlKXtmb3IodmFyIGY9Yi5fcmVhY3ROYW1lLGc9W107bnVsbCE9PWMmJmMhPT1kOyl7dmFyIGg9YyxrPWguYWx0ZXJuYXRlLGw9aC5zdGF0ZU5vZGU7aWYobnVsbCE9PWsmJms9PT1kKWJyZWFrOzU9PT1oLnRhZyYmbnVsbCE9PWwmJihoPWwsZT8oaz1PYihjLGYpLG51bGwhPWsmJmcudW5zaGlmdChlZihjLGssaCkpKTplfHwoaz1PYihjLGYpLG51bGwhPWsmJmcucHVzaChlZihjLGssaCkpKSk7Yz1jLnJldHVybn0wIT09Zy5sZW5ndGgmJmEucHVzaCh7ZXZlbnQ6YixsaXN0ZW5lcnM6Z30pfWZ1bmN0aW9uIGpmKCl7fXZhciBrZj1udWxsLGxmPW51bGw7ZnVuY3Rpb24gbWYoYSxiKXtzd2l0Y2goYSl7Y2FzZSBcImJ1dHRvblwiOmNhc2UgXCJpbnB1dFwiOmNhc2UgXCJzZWxlY3RcIjpjYXNlIFwidGV4dGFyZWFcIjpyZXR1cm4hIWIuYXV0b0ZvY3VzfXJldHVybiExfVxuZnVuY3Rpb24gbmYoYSxiKXtyZXR1cm5cInRleHRhcmVhXCI9PT1hfHxcIm9wdGlvblwiPT09YXx8XCJub3NjcmlwdFwiPT09YXx8XCJzdHJpbmdcIj09PXR5cGVvZiBiLmNoaWxkcmVufHxcIm51bWJlclwiPT09dHlwZW9mIGIuY2hpbGRyZW58fFwib2JqZWN0XCI9PT10eXBlb2YgYi5kYW5nZXJvdXNseVNldElubmVySFRNTCYmbnVsbCE9PWIuZGFuZ2Vyb3VzbHlTZXRJbm5lckhUTUwmJm51bGwhPWIuZGFuZ2Vyb3VzbHlTZXRJbm5lckhUTUwuX19odG1sfXZhciBvZj1cImZ1bmN0aW9uXCI9PT10eXBlb2Ygc2V0VGltZW91dD9zZXRUaW1lb3V0OnZvaWQgMCxwZj1cImZ1bmN0aW9uXCI9PT10eXBlb2YgY2xlYXJUaW1lb3V0P2NsZWFyVGltZW91dDp2b2lkIDA7ZnVuY3Rpb24gcWYoYSl7MT09PWEubm9kZVR5cGU/YS50ZXh0Q29udGVudD1cIlwiOjk9PT1hLm5vZGVUeXBlJiYoYT1hLmJvZHksbnVsbCE9YSYmKGEudGV4dENvbnRlbnQ9XCJcIikpfVxuZnVuY3Rpb24gcmYoYSl7Zm9yKDtudWxsIT1hO2E9YS5uZXh0U2libGluZyl7dmFyIGI9YS5ub2RlVHlwZTtpZigxPT09Ynx8Mz09PWIpYnJlYWt9cmV0dXJuIGF9ZnVuY3Rpb24gc2YoYSl7YT1hLnByZXZpb3VzU2libGluZztmb3IodmFyIGI9MDthOyl7aWYoOD09PWEubm9kZVR5cGUpe3ZhciBjPWEuZGF0YTtpZihcIiRcIj09PWN8fFwiJCFcIj09PWN8fFwiJD9cIj09PWMpe2lmKDA9PT1iKXJldHVybiBhO2ItLX1lbHNlXCIvJFwiPT09YyYmYisrfWE9YS5wcmV2aW91c1NpYmxpbmd9cmV0dXJuIG51bGx9dmFyIHRmPTA7ZnVuY3Rpb24gdWYoYSl7cmV0dXJueyQkdHlwZW9mOkdhLHRvU3RyaW5nOmEsdmFsdWVPZjphfX12YXIgdmY9TWF0aC5yYW5kb20oKS50b1N0cmluZygzNikuc2xpY2UoMiksd2Y9XCJfX3JlYWN0RmliZXIkXCIrdmYseGY9XCJfX3JlYWN0UHJvcHMkXCIrdmYsZmY9XCJfX3JlYWN0Q29udGFpbmVyJFwiK3ZmLHlmPVwiX19yZWFjdEV2ZW50cyRcIit2ZjtcbmZ1bmN0aW9uIHdjKGEpe3ZhciBiPWFbd2ZdO2lmKGIpcmV0dXJuIGI7Zm9yKHZhciBjPWEucGFyZW50Tm9kZTtjOyl7aWYoYj1jW2ZmXXx8Y1t3Zl0pe2M9Yi5hbHRlcm5hdGU7aWYobnVsbCE9PWIuY2hpbGR8fG51bGwhPT1jJiZudWxsIT09Yy5jaGlsZClmb3IoYT1zZihhKTtudWxsIT09YTspe2lmKGM9YVt3Zl0pcmV0dXJuIGM7YT1zZihhKX1yZXR1cm4gYn1hPWM7Yz1hLnBhcmVudE5vZGV9cmV0dXJuIG51bGx9ZnVuY3Rpb24gQ2IoYSl7YT1hW3dmXXx8YVtmZl07cmV0dXJuIWF8fDUhPT1hLnRhZyYmNiE9PWEudGFnJiYxMyE9PWEudGFnJiYzIT09YS50YWc/bnVsbDphfWZ1bmN0aW9uIHVlKGEpe2lmKDU9PT1hLnRhZ3x8Nj09PWEudGFnKXJldHVybiBhLnN0YXRlTm9kZTt0aHJvdyBFcnJvcih5KDMzKSk7fWZ1bmN0aW9uIERiKGEpe3JldHVybiBhW3hmXXx8bnVsbH1cbmZ1bmN0aW9uICRlKGEpe3ZhciBiPWFbeWZdO3ZvaWQgMD09PWImJihiPWFbeWZdPW5ldyBTZXQpO3JldHVybiBifXZhciB6Zj1bXSxBZj0tMTtmdW5jdGlvbiBCZihhKXtyZXR1cm57Y3VycmVudDphfX1mdW5jdGlvbiBIKGEpezA+QWZ8fChhLmN1cnJlbnQ9emZbQWZdLHpmW0FmXT1udWxsLEFmLS0pfWZ1bmN0aW9uIEkoYSxiKXtBZisrO3pmW0FmXT1hLmN1cnJlbnQ7YS5jdXJyZW50PWJ9dmFyIENmPXt9LE09QmYoQ2YpLE49QmYoITEpLERmPUNmO1xuZnVuY3Rpb24gRWYoYSxiKXt2YXIgYz1hLnR5cGUuY29udGV4dFR5cGVzO2lmKCFjKXJldHVybiBDZjt2YXIgZD1hLnN0YXRlTm9kZTtpZihkJiZkLl9fcmVhY3RJbnRlcm5hbE1lbW9pemVkVW5tYXNrZWRDaGlsZENvbnRleHQ9PT1iKXJldHVybiBkLl9fcmVhY3RJbnRlcm5hbE1lbW9pemVkTWFza2VkQ2hpbGRDb250ZXh0O3ZhciBlPXt9LGY7Zm9yKGYgaW4gYyllW2ZdPWJbZl07ZCYmKGE9YS5zdGF0ZU5vZGUsYS5fX3JlYWN0SW50ZXJuYWxNZW1vaXplZFVubWFza2VkQ2hpbGRDb250ZXh0PWIsYS5fX3JlYWN0SW50ZXJuYWxNZW1vaXplZE1hc2tlZENoaWxkQ29udGV4dD1lKTtyZXR1cm4gZX1mdW5jdGlvbiBGZihhKXthPWEuY2hpbGRDb250ZXh0VHlwZXM7cmV0dXJuIG51bGwhPT1hJiZ2b2lkIDAhPT1hfWZ1bmN0aW9uIEdmKCl7SChOKTtIKE0pfWZ1bmN0aW9uIEhmKGEsYixjKXtpZihNLmN1cnJlbnQhPT1DZil0aHJvdyBFcnJvcih5KDE2OCkpO0koTSxiKTtJKE4sYyl9XG5mdW5jdGlvbiBJZihhLGIsYyl7dmFyIGQ9YS5zdGF0ZU5vZGU7YT1iLmNoaWxkQ29udGV4dFR5cGVzO2lmKFwiZnVuY3Rpb25cIiE9PXR5cGVvZiBkLmdldENoaWxkQ29udGV4dClyZXR1cm4gYztkPWQuZ2V0Q2hpbGRDb250ZXh0KCk7Zm9yKHZhciBlIGluIGQpaWYoIShlIGluIGEpKXRocm93IEVycm9yKHkoMTA4LFJhKGIpfHxcIlVua25vd25cIixlKSk7cmV0dXJuIG0oe30sYyxkKX1mdW5jdGlvbiBKZihhKXthPShhPWEuc3RhdGVOb2RlKSYmYS5fX3JlYWN0SW50ZXJuYWxNZW1vaXplZE1lcmdlZENoaWxkQ29udGV4dHx8Q2Y7RGY9TS5jdXJyZW50O0koTSxhKTtJKE4sTi5jdXJyZW50KTtyZXR1cm4hMH1mdW5jdGlvbiBLZihhLGIsYyl7dmFyIGQ9YS5zdGF0ZU5vZGU7aWYoIWQpdGhyb3cgRXJyb3IoeSgxNjkpKTtjPyhhPUlmKGEsYixEZiksZC5fX3JlYWN0SW50ZXJuYWxNZW1vaXplZE1lcmdlZENoaWxkQ29udGV4dD1hLEgoTiksSChNKSxJKE0sYSkpOkgoTik7SShOLGMpfVxudmFyIExmPW51bGwsTWY9bnVsbCxOZj1yLnVuc3RhYmxlX3J1bldpdGhQcmlvcml0eSxPZj1yLnVuc3RhYmxlX3NjaGVkdWxlQ2FsbGJhY2ssUGY9ci51bnN0YWJsZV9jYW5jZWxDYWxsYmFjayxRZj1yLnVuc3RhYmxlX3Nob3VsZFlpZWxkLFJmPXIudW5zdGFibGVfcmVxdWVzdFBhaW50LFNmPXIudW5zdGFibGVfbm93LFRmPXIudW5zdGFibGVfZ2V0Q3VycmVudFByaW9yaXR5TGV2ZWwsVWY9ci51bnN0YWJsZV9JbW1lZGlhdGVQcmlvcml0eSxWZj1yLnVuc3RhYmxlX1VzZXJCbG9ja2luZ1ByaW9yaXR5LFdmPXIudW5zdGFibGVfTm9ybWFsUHJpb3JpdHksWGY9ci51bnN0YWJsZV9Mb3dQcmlvcml0eSxZZj1yLnVuc3RhYmxlX0lkbGVQcmlvcml0eSxaZj17fSwkZj12b2lkIDAhPT1SZj9SZjpmdW5jdGlvbigpe30sYWc9bnVsbCxiZz1udWxsLGNnPSExLGRnPVNmKCksTz0xRTQ+ZGc/U2Y6ZnVuY3Rpb24oKXtyZXR1cm4gU2YoKS1kZ307XG5mdW5jdGlvbiBlZygpe3N3aXRjaChUZigpKXtjYXNlIFVmOnJldHVybiA5OTtjYXNlIFZmOnJldHVybiA5ODtjYXNlIFdmOnJldHVybiA5NztjYXNlIFhmOnJldHVybiA5NjtjYXNlIFlmOnJldHVybiA5NTtkZWZhdWx0OnRocm93IEVycm9yKHkoMzMyKSk7fX1mdW5jdGlvbiBmZyhhKXtzd2l0Y2goYSl7Y2FzZSA5OTpyZXR1cm4gVWY7Y2FzZSA5ODpyZXR1cm4gVmY7Y2FzZSA5NzpyZXR1cm4gV2Y7Y2FzZSA5NjpyZXR1cm4gWGY7Y2FzZSA5NTpyZXR1cm4gWWY7ZGVmYXVsdDp0aHJvdyBFcnJvcih5KDMzMikpO319ZnVuY3Rpb24gZ2coYSxiKXthPWZnKGEpO3JldHVybiBOZihhLGIpfWZ1bmN0aW9uIGhnKGEsYixjKXthPWZnKGEpO3JldHVybiBPZihhLGIsYyl9ZnVuY3Rpb24gaWcoKXtpZihudWxsIT09Ymcpe3ZhciBhPWJnO2JnPW51bGw7UGYoYSl9amcoKX1cbmZ1bmN0aW9uIGpnKCl7aWYoIWNnJiZudWxsIT09YWcpe2NnPSEwO3ZhciBhPTA7dHJ5e3ZhciBiPWFnO2dnKDk5LGZ1bmN0aW9uKCl7Zm9yKDthPGIubGVuZ3RoO2ErKyl7dmFyIGM9YlthXTtkbyBjPWMoITApO3doaWxlKG51bGwhPT1jKX19KTthZz1udWxsfWNhdGNoKGMpe3Rocm93IG51bGwhPT1hZyYmKGFnPWFnLnNsaWNlKGErMSkpLE9mKFVmLGlnKSxjO31maW5hbGx5e2NnPSExfX19dmFyIGtnPXJhLlJlYWN0Q3VycmVudEJhdGNoQ29uZmlnO2Z1bmN0aW9uIGxnKGEsYil7aWYoYSYmYS5kZWZhdWx0UHJvcHMpe2I9bSh7fSxiKTthPWEuZGVmYXVsdFByb3BzO2Zvcih2YXIgYyBpbiBhKXZvaWQgMD09PWJbY10mJihiW2NdPWFbY10pO3JldHVybiBifXJldHVybiBifXZhciBtZz1CZihudWxsKSxuZz1udWxsLG9nPW51bGwscGc9bnVsbDtmdW5jdGlvbiBxZygpe3BnPW9nPW5nPW51bGx9XG5mdW5jdGlvbiByZyhhKXt2YXIgYj1tZy5jdXJyZW50O0gobWcpO2EudHlwZS5fY29udGV4dC5fY3VycmVudFZhbHVlPWJ9ZnVuY3Rpb24gc2coYSxiKXtmb3IoO251bGwhPT1hOyl7dmFyIGM9YS5hbHRlcm5hdGU7aWYoKGEuY2hpbGRMYW5lcyZiKT09PWIpaWYobnVsbD09PWN8fChjLmNoaWxkTGFuZXMmYik9PT1iKWJyZWFrO2Vsc2UgYy5jaGlsZExhbmVzfD1iO2Vsc2UgYS5jaGlsZExhbmVzfD1iLG51bGwhPT1jJiYoYy5jaGlsZExhbmVzfD1iKTthPWEucmV0dXJufX1mdW5jdGlvbiB0ZyhhLGIpe25nPWE7cGc9b2c9bnVsbDthPWEuZGVwZW5kZW5jaWVzO251bGwhPT1hJiZudWxsIT09YS5maXJzdENvbnRleHQmJigwIT09KGEubGFuZXMmYikmJih1Zz0hMCksYS5maXJzdENvbnRleHQ9bnVsbCl9XG5mdW5jdGlvbiB2ZyhhLGIpe2lmKHBnIT09YSYmITEhPT1iJiYwIT09Yil7aWYoXCJudW1iZXJcIiE9PXR5cGVvZiBifHwxMDczNzQxODIzPT09YilwZz1hLGI9MTA3Mzc0MTgyMztiPXtjb250ZXh0OmEsb2JzZXJ2ZWRCaXRzOmIsbmV4dDpudWxsfTtpZihudWxsPT09b2cpe2lmKG51bGw9PT1uZyl0aHJvdyBFcnJvcih5KDMwOCkpO29nPWI7bmcuZGVwZW5kZW5jaWVzPXtsYW5lczowLGZpcnN0Q29udGV4dDpiLHJlc3BvbmRlcnM6bnVsbH19ZWxzZSBvZz1vZy5uZXh0PWJ9cmV0dXJuIGEuX2N1cnJlbnRWYWx1ZX12YXIgd2c9ITE7ZnVuY3Rpb24geGcoYSl7YS51cGRhdGVRdWV1ZT17YmFzZVN0YXRlOmEubWVtb2l6ZWRTdGF0ZSxmaXJzdEJhc2VVcGRhdGU6bnVsbCxsYXN0QmFzZVVwZGF0ZTpudWxsLHNoYXJlZDp7cGVuZGluZzpudWxsfSxlZmZlY3RzOm51bGx9fVxuZnVuY3Rpb24geWcoYSxiKXthPWEudXBkYXRlUXVldWU7Yi51cGRhdGVRdWV1ZT09PWEmJihiLnVwZGF0ZVF1ZXVlPXtiYXNlU3RhdGU6YS5iYXNlU3RhdGUsZmlyc3RCYXNlVXBkYXRlOmEuZmlyc3RCYXNlVXBkYXRlLGxhc3RCYXNlVXBkYXRlOmEubGFzdEJhc2VVcGRhdGUsc2hhcmVkOmEuc2hhcmVkLGVmZmVjdHM6YS5lZmZlY3RzfSl9ZnVuY3Rpb24gemcoYSxiKXtyZXR1cm57ZXZlbnRUaW1lOmEsbGFuZTpiLHRhZzowLHBheWxvYWQ6bnVsbCxjYWxsYmFjazpudWxsLG5leHQ6bnVsbH19ZnVuY3Rpb24gQWcoYSxiKXthPWEudXBkYXRlUXVldWU7aWYobnVsbCE9PWEpe2E9YS5zaGFyZWQ7dmFyIGM9YS5wZW5kaW5nO251bGw9PT1jP2IubmV4dD1iOihiLm5leHQ9Yy5uZXh0LGMubmV4dD1iKTthLnBlbmRpbmc9Yn19XG5mdW5jdGlvbiBCZyhhLGIpe3ZhciBjPWEudXBkYXRlUXVldWUsZD1hLmFsdGVybmF0ZTtpZihudWxsIT09ZCYmKGQ9ZC51cGRhdGVRdWV1ZSxjPT09ZCkpe3ZhciBlPW51bGwsZj1udWxsO2M9Yy5maXJzdEJhc2VVcGRhdGU7aWYobnVsbCE9PWMpe2Rve3ZhciBnPXtldmVudFRpbWU6Yy5ldmVudFRpbWUsbGFuZTpjLmxhbmUsdGFnOmMudGFnLHBheWxvYWQ6Yy5wYXlsb2FkLGNhbGxiYWNrOmMuY2FsbGJhY2ssbmV4dDpudWxsfTtudWxsPT09Zj9lPWY9ZzpmPWYubmV4dD1nO2M9Yy5uZXh0fXdoaWxlKG51bGwhPT1jKTtudWxsPT09Zj9lPWY9YjpmPWYubmV4dD1ifWVsc2UgZT1mPWI7Yz17YmFzZVN0YXRlOmQuYmFzZVN0YXRlLGZpcnN0QmFzZVVwZGF0ZTplLGxhc3RCYXNlVXBkYXRlOmYsc2hhcmVkOmQuc2hhcmVkLGVmZmVjdHM6ZC5lZmZlY3RzfTthLnVwZGF0ZVF1ZXVlPWM7cmV0dXJufWE9Yy5sYXN0QmFzZVVwZGF0ZTtudWxsPT09YT9jLmZpcnN0QmFzZVVwZGF0ZT1iOmEubmV4dD1cbmI7Yy5sYXN0QmFzZVVwZGF0ZT1ifVxuZnVuY3Rpb24gQ2coYSxiLGMsZCl7dmFyIGU9YS51cGRhdGVRdWV1ZTt3Zz0hMTt2YXIgZj1lLmZpcnN0QmFzZVVwZGF0ZSxnPWUubGFzdEJhc2VVcGRhdGUsaD1lLnNoYXJlZC5wZW5kaW5nO2lmKG51bGwhPT1oKXtlLnNoYXJlZC5wZW5kaW5nPW51bGw7dmFyIGs9aCxsPWsubmV4dDtrLm5leHQ9bnVsbDtudWxsPT09Zz9mPWw6Zy5uZXh0PWw7Zz1rO3ZhciBuPWEuYWx0ZXJuYXRlO2lmKG51bGwhPT1uKXtuPW4udXBkYXRlUXVldWU7dmFyIEE9bi5sYXN0QmFzZVVwZGF0ZTtBIT09ZyYmKG51bGw9PT1BP24uZmlyc3RCYXNlVXBkYXRlPWw6QS5uZXh0PWwsbi5sYXN0QmFzZVVwZGF0ZT1rKX19aWYobnVsbCE9PWYpe0E9ZS5iYXNlU3RhdGU7Zz0wO249bD1rPW51bGw7ZG97aD1mLmxhbmU7dmFyIHA9Zi5ldmVudFRpbWU7aWYoKGQmaCk9PT1oKXtudWxsIT09biYmKG49bi5uZXh0PXtldmVudFRpbWU6cCxsYW5lOjAsdGFnOmYudGFnLHBheWxvYWQ6Zi5wYXlsb2FkLGNhbGxiYWNrOmYuY2FsbGJhY2ssXG5uZXh0Om51bGx9KTthOnt2YXIgQz1hLHg9ZjtoPWI7cD1jO3N3aXRjaCh4LnRhZyl7Y2FzZSAxOkM9eC5wYXlsb2FkO2lmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBDKXtBPUMuY2FsbChwLEEsaCk7YnJlYWsgYX1BPUM7YnJlYWsgYTtjYXNlIDM6Qy5mbGFncz1DLmZsYWdzJi00MDk3fDY0O2Nhc2UgMDpDPXgucGF5bG9hZDtoPVwiZnVuY3Rpb25cIj09PXR5cGVvZiBDP0MuY2FsbChwLEEsaCk6QztpZihudWxsPT09aHx8dm9pZCAwPT09aClicmVhayBhO0E9bSh7fSxBLGgpO2JyZWFrIGE7Y2FzZSAyOndnPSEwfX1udWxsIT09Zi5jYWxsYmFjayYmKGEuZmxhZ3N8PTMyLGg9ZS5lZmZlY3RzLG51bGw9PT1oP2UuZWZmZWN0cz1bZl06aC5wdXNoKGYpKX1lbHNlIHA9e2V2ZW50VGltZTpwLGxhbmU6aCx0YWc6Zi50YWcscGF5bG9hZDpmLnBheWxvYWQsY2FsbGJhY2s6Zi5jYWxsYmFjayxuZXh0Om51bGx9LG51bGw9PT1uPyhsPW49cCxrPUEpOm49bi5uZXh0PXAsZ3w9aDtmPWYubmV4dDtpZihudWxsPT09XG5mKWlmKGg9ZS5zaGFyZWQucGVuZGluZyxudWxsPT09aClicmVhaztlbHNlIGY9aC5uZXh0LGgubmV4dD1udWxsLGUubGFzdEJhc2VVcGRhdGU9aCxlLnNoYXJlZC5wZW5kaW5nPW51bGx9d2hpbGUoMSk7bnVsbD09PW4mJihrPUEpO2UuYmFzZVN0YXRlPWs7ZS5maXJzdEJhc2VVcGRhdGU9bDtlLmxhc3RCYXNlVXBkYXRlPW47RGd8PWc7YS5sYW5lcz1nO2EubWVtb2l6ZWRTdGF0ZT1BfX1mdW5jdGlvbiBFZyhhLGIsYyl7YT1iLmVmZmVjdHM7Yi5lZmZlY3RzPW51bGw7aWYobnVsbCE9PWEpZm9yKGI9MDtiPGEubGVuZ3RoO2IrKyl7dmFyIGQ9YVtiXSxlPWQuY2FsbGJhY2s7aWYobnVsbCE9PWUpe2QuY2FsbGJhY2s9bnVsbDtkPWM7aWYoXCJmdW5jdGlvblwiIT09dHlwZW9mIGUpdGhyb3cgRXJyb3IoeSgxOTEsZSkpO2UuY2FsbChkKX19fXZhciBGZz0obmV3IGFhLkNvbXBvbmVudCkucmVmcztcbmZ1bmN0aW9uIEdnKGEsYixjLGQpe2I9YS5tZW1vaXplZFN0YXRlO2M9YyhkLGIpO2M9bnVsbD09PWN8fHZvaWQgMD09PWM/YjptKHt9LGIsYyk7YS5tZW1vaXplZFN0YXRlPWM7MD09PWEubGFuZXMmJihhLnVwZGF0ZVF1ZXVlLmJhc2VTdGF0ZT1jKX1cbnZhciBLZz17aXNNb3VudGVkOmZ1bmN0aW9uKGEpe3JldHVybihhPWEuX3JlYWN0SW50ZXJuYWxzKT9aYihhKT09PWE6ITF9LGVucXVldWVTZXRTdGF0ZTpmdW5jdGlvbihhLGIsYyl7YT1hLl9yZWFjdEludGVybmFsczt2YXIgZD1IZygpLGU9SWcoYSksZj16ZyhkLGUpO2YucGF5bG9hZD1iO3ZvaWQgMCE9PWMmJm51bGwhPT1jJiYoZi5jYWxsYmFjaz1jKTtBZyhhLGYpO0pnKGEsZSxkKX0sZW5xdWV1ZVJlcGxhY2VTdGF0ZTpmdW5jdGlvbihhLGIsYyl7YT1hLl9yZWFjdEludGVybmFsczt2YXIgZD1IZygpLGU9SWcoYSksZj16ZyhkLGUpO2YudGFnPTE7Zi5wYXlsb2FkPWI7dm9pZCAwIT09YyYmbnVsbCE9PWMmJihmLmNhbGxiYWNrPWMpO0FnKGEsZik7SmcoYSxlLGQpfSxlbnF1ZXVlRm9yY2VVcGRhdGU6ZnVuY3Rpb24oYSxiKXthPWEuX3JlYWN0SW50ZXJuYWxzO3ZhciBjPUhnKCksZD1JZyhhKSxlPXpnKGMsZCk7ZS50YWc9Mjt2b2lkIDAhPT1iJiZudWxsIT09YiYmKGUuY2FsbGJhY2s9XG5iKTtBZyhhLGUpO0pnKGEsZCxjKX19O2Z1bmN0aW9uIExnKGEsYixjLGQsZSxmLGcpe2E9YS5zdGF0ZU5vZGU7cmV0dXJuXCJmdW5jdGlvblwiPT09dHlwZW9mIGEuc2hvdWxkQ29tcG9uZW50VXBkYXRlP2Euc2hvdWxkQ29tcG9uZW50VXBkYXRlKGQsZixnKTpiLnByb3RvdHlwZSYmYi5wcm90b3R5cGUuaXNQdXJlUmVhY3RDb21wb25lbnQ/IUplKGMsZCl8fCFKZShlLGYpOiEwfVxuZnVuY3Rpb24gTWcoYSxiLGMpe3ZhciBkPSExLGU9Q2Y7dmFyIGY9Yi5jb250ZXh0VHlwZTtcIm9iamVjdFwiPT09dHlwZW9mIGYmJm51bGwhPT1mP2Y9dmcoZik6KGU9RmYoYik/RGY6TS5jdXJyZW50LGQ9Yi5jb250ZXh0VHlwZXMsZj0oZD1udWxsIT09ZCYmdm9pZCAwIT09ZCk/RWYoYSxlKTpDZik7Yj1uZXcgYihjLGYpO2EubWVtb2l6ZWRTdGF0ZT1udWxsIT09Yi5zdGF0ZSYmdm9pZCAwIT09Yi5zdGF0ZT9iLnN0YXRlOm51bGw7Yi51cGRhdGVyPUtnO2Euc3RhdGVOb2RlPWI7Yi5fcmVhY3RJbnRlcm5hbHM9YTtkJiYoYT1hLnN0YXRlTm9kZSxhLl9fcmVhY3RJbnRlcm5hbE1lbW9pemVkVW5tYXNrZWRDaGlsZENvbnRleHQ9ZSxhLl9fcmVhY3RJbnRlcm5hbE1lbW9pemVkTWFza2VkQ2hpbGRDb250ZXh0PWYpO3JldHVybiBifVxuZnVuY3Rpb24gTmcoYSxiLGMsZCl7YT1iLnN0YXRlO1wiZnVuY3Rpb25cIj09PXR5cGVvZiBiLmNvbXBvbmVudFdpbGxSZWNlaXZlUHJvcHMmJmIuY29tcG9uZW50V2lsbFJlY2VpdmVQcm9wcyhjLGQpO1wiZnVuY3Rpb25cIj09PXR5cGVvZiBiLlVOU0FGRV9jb21wb25lbnRXaWxsUmVjZWl2ZVByb3BzJiZiLlVOU0FGRV9jb21wb25lbnRXaWxsUmVjZWl2ZVByb3BzKGMsZCk7Yi5zdGF0ZSE9PWEmJktnLmVucXVldWVSZXBsYWNlU3RhdGUoYixiLnN0YXRlLG51bGwpfVxuZnVuY3Rpb24gT2coYSxiLGMsZCl7dmFyIGU9YS5zdGF0ZU5vZGU7ZS5wcm9wcz1jO2Uuc3RhdGU9YS5tZW1vaXplZFN0YXRlO2UucmVmcz1GZzt4ZyhhKTt2YXIgZj1iLmNvbnRleHRUeXBlO1wib2JqZWN0XCI9PT10eXBlb2YgZiYmbnVsbCE9PWY/ZS5jb250ZXh0PXZnKGYpOihmPUZmKGIpP0RmOk0uY3VycmVudCxlLmNvbnRleHQ9RWYoYSxmKSk7Q2coYSxjLGUsZCk7ZS5zdGF0ZT1hLm1lbW9pemVkU3RhdGU7Zj1iLmdldERlcml2ZWRTdGF0ZUZyb21Qcm9wcztcImZ1bmN0aW9uXCI9PT10eXBlb2YgZiYmKEdnKGEsYixmLGMpLGUuc3RhdGU9YS5tZW1vaXplZFN0YXRlKTtcImZ1bmN0aW9uXCI9PT10eXBlb2YgYi5nZXREZXJpdmVkU3RhdGVGcm9tUHJvcHN8fFwiZnVuY3Rpb25cIj09PXR5cGVvZiBlLmdldFNuYXBzaG90QmVmb3JlVXBkYXRlfHxcImZ1bmN0aW9uXCIhPT10eXBlb2YgZS5VTlNBRkVfY29tcG9uZW50V2lsbE1vdW50JiZcImZ1bmN0aW9uXCIhPT10eXBlb2YgZS5jb21wb25lbnRXaWxsTW91bnR8fFxuKGI9ZS5zdGF0ZSxcImZ1bmN0aW9uXCI9PT10eXBlb2YgZS5jb21wb25lbnRXaWxsTW91bnQmJmUuY29tcG9uZW50V2lsbE1vdW50KCksXCJmdW5jdGlvblwiPT09dHlwZW9mIGUuVU5TQUZFX2NvbXBvbmVudFdpbGxNb3VudCYmZS5VTlNBRkVfY29tcG9uZW50V2lsbE1vdW50KCksYiE9PWUuc3RhdGUmJktnLmVucXVldWVSZXBsYWNlU3RhdGUoZSxlLnN0YXRlLG51bGwpLENnKGEsYyxlLGQpLGUuc3RhdGU9YS5tZW1vaXplZFN0YXRlKTtcImZ1bmN0aW9uXCI9PT10eXBlb2YgZS5jb21wb25lbnREaWRNb3VudCYmKGEuZmxhZ3N8PTQpfXZhciBQZz1BcnJheS5pc0FycmF5O1xuZnVuY3Rpb24gUWcoYSxiLGMpe2E9Yy5yZWY7aWYobnVsbCE9PWEmJlwiZnVuY3Rpb25cIiE9PXR5cGVvZiBhJiZcIm9iamVjdFwiIT09dHlwZW9mIGEpe2lmKGMuX293bmVyKXtjPWMuX293bmVyO2lmKGMpe2lmKDEhPT1jLnRhZyl0aHJvdyBFcnJvcih5KDMwOSkpO3ZhciBkPWMuc3RhdGVOb2RlfWlmKCFkKXRocm93IEVycm9yKHkoMTQ3LGEpKTt2YXIgZT1cIlwiK2E7aWYobnVsbCE9PWImJm51bGwhPT1iLnJlZiYmXCJmdW5jdGlvblwiPT09dHlwZW9mIGIucmVmJiZiLnJlZi5fc3RyaW5nUmVmPT09ZSlyZXR1cm4gYi5yZWY7Yj1mdW5jdGlvbihhKXt2YXIgYj1kLnJlZnM7Yj09PUZnJiYoYj1kLnJlZnM9e30pO251bGw9PT1hP2RlbGV0ZSBiW2VdOmJbZV09YX07Yi5fc3RyaW5nUmVmPWU7cmV0dXJuIGJ9aWYoXCJzdHJpbmdcIiE9PXR5cGVvZiBhKXRocm93IEVycm9yKHkoMjg0KSk7aWYoIWMuX293bmVyKXRocm93IEVycm9yKHkoMjkwLGEpKTt9cmV0dXJuIGF9XG5mdW5jdGlvbiBSZyhhLGIpe2lmKFwidGV4dGFyZWFcIiE9PWEudHlwZSl0aHJvdyBFcnJvcih5KDMxLFwiW29iamVjdCBPYmplY3RdXCI9PT1PYmplY3QucHJvdG90eXBlLnRvU3RyaW5nLmNhbGwoYik/XCJvYmplY3Qgd2l0aCBrZXlzIHtcIitPYmplY3Qua2V5cyhiKS5qb2luKFwiLCBcIikrXCJ9XCI6YikpO31cbmZ1bmN0aW9uIFNnKGEpe2Z1bmN0aW9uIGIoYixjKXtpZihhKXt2YXIgZD1iLmxhc3RFZmZlY3Q7bnVsbCE9PWQ/KGQubmV4dEVmZmVjdD1jLGIubGFzdEVmZmVjdD1jKTpiLmZpcnN0RWZmZWN0PWIubGFzdEVmZmVjdD1jO2MubmV4dEVmZmVjdD1udWxsO2MuZmxhZ3M9OH19ZnVuY3Rpb24gYyhjLGQpe2lmKCFhKXJldHVybiBudWxsO2Zvcig7bnVsbCE9PWQ7KWIoYyxkKSxkPWQuc2libGluZztyZXR1cm4gbnVsbH1mdW5jdGlvbiBkKGEsYil7Zm9yKGE9bmV3IE1hcDtudWxsIT09YjspbnVsbCE9PWIua2V5P2Euc2V0KGIua2V5LGIpOmEuc2V0KGIuaW5kZXgsYiksYj1iLnNpYmxpbmc7cmV0dXJuIGF9ZnVuY3Rpb24gZShhLGIpe2E9VGcoYSxiKTthLmluZGV4PTA7YS5zaWJsaW5nPW51bGw7cmV0dXJuIGF9ZnVuY3Rpb24gZihiLGMsZCl7Yi5pbmRleD1kO2lmKCFhKXJldHVybiBjO2Q9Yi5hbHRlcm5hdGU7aWYobnVsbCE9PWQpcmV0dXJuIGQ9ZC5pbmRleCxkPGM/KGIuZmxhZ3M9MixcbmMpOmQ7Yi5mbGFncz0yO3JldHVybiBjfWZ1bmN0aW9uIGcoYil7YSYmbnVsbD09PWIuYWx0ZXJuYXRlJiYoYi5mbGFncz0yKTtyZXR1cm4gYn1mdW5jdGlvbiBoKGEsYixjLGQpe2lmKG51bGw9PT1ifHw2IT09Yi50YWcpcmV0dXJuIGI9VWcoYyxhLm1vZGUsZCksYi5yZXR1cm49YSxiO2I9ZShiLGMpO2IucmV0dXJuPWE7cmV0dXJuIGJ9ZnVuY3Rpb24gayhhLGIsYyxkKXtpZihudWxsIT09YiYmYi5lbGVtZW50VHlwZT09PWMudHlwZSlyZXR1cm4gZD1lKGIsYy5wcm9wcyksZC5yZWY9UWcoYSxiLGMpLGQucmV0dXJuPWEsZDtkPVZnKGMudHlwZSxjLmtleSxjLnByb3BzLG51bGwsYS5tb2RlLGQpO2QucmVmPVFnKGEsYixjKTtkLnJldHVybj1hO3JldHVybiBkfWZ1bmN0aW9uIGwoYSxiLGMsZCl7aWYobnVsbD09PWJ8fDQhPT1iLnRhZ3x8Yi5zdGF0ZU5vZGUuY29udGFpbmVySW5mbyE9PWMuY29udGFpbmVySW5mb3x8Yi5zdGF0ZU5vZGUuaW1wbGVtZW50YXRpb24hPT1jLmltcGxlbWVudGF0aW9uKXJldHVybiBiPVxuV2coYyxhLm1vZGUsZCksYi5yZXR1cm49YSxiO2I9ZShiLGMuY2hpbGRyZW58fFtdKTtiLnJldHVybj1hO3JldHVybiBifWZ1bmN0aW9uIG4oYSxiLGMsZCxmKXtpZihudWxsPT09Ynx8NyE9PWIudGFnKXJldHVybiBiPVhnKGMsYS5tb2RlLGQsZiksYi5yZXR1cm49YSxiO2I9ZShiLGMpO2IucmV0dXJuPWE7cmV0dXJuIGJ9ZnVuY3Rpb24gQShhLGIsYyl7aWYoXCJzdHJpbmdcIj09PXR5cGVvZiBifHxcIm51bWJlclwiPT09dHlwZW9mIGIpcmV0dXJuIGI9VWcoXCJcIitiLGEubW9kZSxjKSxiLnJldHVybj1hLGI7aWYoXCJvYmplY3RcIj09PXR5cGVvZiBiJiZudWxsIT09Yil7c3dpdGNoKGIuJCR0eXBlb2Ype2Nhc2Ugc2E6cmV0dXJuIGM9VmcoYi50eXBlLGIua2V5LGIucHJvcHMsbnVsbCxhLm1vZGUsYyksYy5yZWY9UWcoYSxudWxsLGIpLGMucmV0dXJuPWEsYztjYXNlIHRhOnJldHVybiBiPVdnKGIsYS5tb2RlLGMpLGIucmV0dXJuPWEsYn1pZihQZyhiKXx8TGEoYikpcmV0dXJuIGI9WGcoYixcbmEubW9kZSxjLG51bGwpLGIucmV0dXJuPWEsYjtSZyhhLGIpfXJldHVybiBudWxsfWZ1bmN0aW9uIHAoYSxiLGMsZCl7dmFyIGU9bnVsbCE9PWI/Yi5rZXk6bnVsbDtpZihcInN0cmluZ1wiPT09dHlwZW9mIGN8fFwibnVtYmVyXCI9PT10eXBlb2YgYylyZXR1cm4gbnVsbCE9PWU/bnVsbDpoKGEsYixcIlwiK2MsZCk7aWYoXCJvYmplY3RcIj09PXR5cGVvZiBjJiZudWxsIT09Yyl7c3dpdGNoKGMuJCR0eXBlb2Ype2Nhc2Ugc2E6cmV0dXJuIGMua2V5PT09ZT9jLnR5cGU9PT11YT9uKGEsYixjLnByb3BzLmNoaWxkcmVuLGQsZSk6ayhhLGIsYyxkKTpudWxsO2Nhc2UgdGE6cmV0dXJuIGMua2V5PT09ZT9sKGEsYixjLGQpOm51bGx9aWYoUGcoYyl8fExhKGMpKXJldHVybiBudWxsIT09ZT9udWxsOm4oYSxiLGMsZCxudWxsKTtSZyhhLGMpfXJldHVybiBudWxsfWZ1bmN0aW9uIEMoYSxiLGMsZCxlKXtpZihcInN0cmluZ1wiPT09dHlwZW9mIGR8fFwibnVtYmVyXCI9PT10eXBlb2YgZClyZXR1cm4gYT1hLmdldChjKXx8XG5udWxsLGgoYixhLFwiXCIrZCxlKTtpZihcIm9iamVjdFwiPT09dHlwZW9mIGQmJm51bGwhPT1kKXtzd2l0Y2goZC4kJHR5cGVvZil7Y2FzZSBzYTpyZXR1cm4gYT1hLmdldChudWxsPT09ZC5rZXk/YzpkLmtleSl8fG51bGwsZC50eXBlPT09dWE/bihiLGEsZC5wcm9wcy5jaGlsZHJlbixlLGQua2V5KTprKGIsYSxkLGUpO2Nhc2UgdGE6cmV0dXJuIGE9YS5nZXQobnVsbD09PWQua2V5P2M6ZC5rZXkpfHxudWxsLGwoYixhLGQsZSl9aWYoUGcoZCl8fExhKGQpKXJldHVybiBhPWEuZ2V0KGMpfHxudWxsLG4oYixhLGQsZSxudWxsKTtSZyhiLGQpfXJldHVybiBudWxsfWZ1bmN0aW9uIHgoZSxnLGgsayl7Zm9yKHZhciBsPW51bGwsdD1udWxsLHU9Zyx6PWc9MCxxPW51bGw7bnVsbCE9PXUmJno8aC5sZW5ndGg7eisrKXt1LmluZGV4Pno/KHE9dSx1PW51bGwpOnE9dS5zaWJsaW5nO3ZhciBuPXAoZSx1LGhbel0sayk7aWYobnVsbD09PW4pe251bGw9PT11JiYodT1xKTticmVha31hJiZ1JiZudWxsPT09XG5uLmFsdGVybmF0ZSYmYihlLHUpO2c9ZihuLGcseik7bnVsbD09PXQ/bD1uOnQuc2libGluZz1uO3Q9bjt1PXF9aWYoej09PWgubGVuZ3RoKXJldHVybiBjKGUsdSksbDtpZihudWxsPT09dSl7Zm9yKDt6PGgubGVuZ3RoO3orKyl1PUEoZSxoW3pdLGspLG51bGwhPT11JiYoZz1mKHUsZyx6KSxudWxsPT09dD9sPXU6dC5zaWJsaW5nPXUsdD11KTtyZXR1cm4gbH1mb3IodT1kKGUsdSk7ejxoLmxlbmd0aDt6KyspcT1DKHUsZSx6LGhbel0sayksbnVsbCE9PXEmJihhJiZudWxsIT09cS5hbHRlcm5hdGUmJnUuZGVsZXRlKG51bGw9PT1xLmtleT96OnEua2V5KSxnPWYocSxnLHopLG51bGw9PT10P2w9cTp0LnNpYmxpbmc9cSx0PXEpO2EmJnUuZm9yRWFjaChmdW5jdGlvbihhKXtyZXR1cm4gYihlLGEpfSk7cmV0dXJuIGx9ZnVuY3Rpb24gdyhlLGcsaCxrKXt2YXIgbD1MYShoKTtpZihcImZ1bmN0aW9uXCIhPT10eXBlb2YgbCl0aHJvdyBFcnJvcih5KDE1MCkpO2g9bC5jYWxsKGgpO2lmKG51bGw9PVxuaCl0aHJvdyBFcnJvcih5KDE1MSkpO2Zvcih2YXIgdD1sPW51bGwsdT1nLHo9Zz0wLHE9bnVsbCxuPWgubmV4dCgpO251bGwhPT11JiYhbi5kb25lO3orKyxuPWgubmV4dCgpKXt1LmluZGV4Pno/KHE9dSx1PW51bGwpOnE9dS5zaWJsaW5nO3ZhciB3PXAoZSx1LG4udmFsdWUsayk7aWYobnVsbD09PXcpe251bGw9PT11JiYodT1xKTticmVha31hJiZ1JiZudWxsPT09dy5hbHRlcm5hdGUmJmIoZSx1KTtnPWYodyxnLHopO251bGw9PT10P2w9dzp0LnNpYmxpbmc9dzt0PXc7dT1xfWlmKG4uZG9uZSlyZXR1cm4gYyhlLHUpLGw7aWYobnVsbD09PXUpe2Zvcig7IW4uZG9uZTt6Kyssbj1oLm5leHQoKSluPUEoZSxuLnZhbHVlLGspLG51bGwhPT1uJiYoZz1mKG4sZyx6KSxudWxsPT09dD9sPW46dC5zaWJsaW5nPW4sdD1uKTtyZXR1cm4gbH1mb3IodT1kKGUsdSk7IW4uZG9uZTt6Kyssbj1oLm5leHQoKSluPUModSxlLHosbi52YWx1ZSxrKSxudWxsIT09biYmKGEmJm51bGwhPT1uLmFsdGVybmF0ZSYmXG51LmRlbGV0ZShudWxsPT09bi5rZXk/ejpuLmtleSksZz1mKG4sZyx6KSxudWxsPT09dD9sPW46dC5zaWJsaW5nPW4sdD1uKTthJiZ1LmZvckVhY2goZnVuY3Rpb24oYSl7cmV0dXJuIGIoZSxhKX0pO3JldHVybiBsfXJldHVybiBmdW5jdGlvbihhLGQsZixoKXt2YXIgaz1cIm9iamVjdFwiPT09dHlwZW9mIGYmJm51bGwhPT1mJiZmLnR5cGU9PT11YSYmbnVsbD09PWYua2V5O2smJihmPWYucHJvcHMuY2hpbGRyZW4pO3ZhciBsPVwib2JqZWN0XCI9PT10eXBlb2YgZiYmbnVsbCE9PWY7aWYobClzd2l0Y2goZi4kJHR5cGVvZil7Y2FzZSBzYTphOntsPWYua2V5O2ZvcihrPWQ7bnVsbCE9PWs7KXtpZihrLmtleT09PWwpe3N3aXRjaChrLnRhZyl7Y2FzZSA3OmlmKGYudHlwZT09PXVhKXtjKGEsay5zaWJsaW5nKTtkPWUoayxmLnByb3BzLmNoaWxkcmVuKTtkLnJldHVybj1hO2E9ZDticmVhayBhfWJyZWFrO2RlZmF1bHQ6aWYoay5lbGVtZW50VHlwZT09PWYudHlwZSl7YyhhLGsuc2libGluZyk7XG5kPWUoayxmLnByb3BzKTtkLnJlZj1RZyhhLGssZik7ZC5yZXR1cm49YTthPWQ7YnJlYWsgYX19YyhhLGspO2JyZWFrfWVsc2UgYihhLGspO2s9ay5zaWJsaW5nfWYudHlwZT09PXVhPyhkPVhnKGYucHJvcHMuY2hpbGRyZW4sYS5tb2RlLGgsZi5rZXkpLGQucmV0dXJuPWEsYT1kKTooaD1WZyhmLnR5cGUsZi5rZXksZi5wcm9wcyxudWxsLGEubW9kZSxoKSxoLnJlZj1RZyhhLGQsZiksaC5yZXR1cm49YSxhPWgpfXJldHVybiBnKGEpO2Nhc2UgdGE6YTp7Zm9yKGs9Zi5rZXk7bnVsbCE9PWQ7KXtpZihkLmtleT09PWspaWYoND09PWQudGFnJiZkLnN0YXRlTm9kZS5jb250YWluZXJJbmZvPT09Zi5jb250YWluZXJJbmZvJiZkLnN0YXRlTm9kZS5pbXBsZW1lbnRhdGlvbj09PWYuaW1wbGVtZW50YXRpb24pe2MoYSxkLnNpYmxpbmcpO2Q9ZShkLGYuY2hpbGRyZW58fFtdKTtkLnJldHVybj1hO2E9ZDticmVhayBhfWVsc2V7YyhhLGQpO2JyZWFrfWVsc2UgYihhLGQpO2Q9ZC5zaWJsaW5nfWQ9XG5XZyhmLGEubW9kZSxoKTtkLnJldHVybj1hO2E9ZH1yZXR1cm4gZyhhKX1pZihcInN0cmluZ1wiPT09dHlwZW9mIGZ8fFwibnVtYmVyXCI9PT10eXBlb2YgZilyZXR1cm4gZj1cIlwiK2YsbnVsbCE9PWQmJjY9PT1kLnRhZz8oYyhhLGQuc2libGluZyksZD1lKGQsZiksZC5yZXR1cm49YSxhPWQpOihjKGEsZCksZD1VZyhmLGEubW9kZSxoKSxkLnJldHVybj1hLGE9ZCksZyhhKTtpZihQZyhmKSlyZXR1cm4geChhLGQsZixoKTtpZihMYShmKSlyZXR1cm4gdyhhLGQsZixoKTtsJiZSZyhhLGYpO2lmKFwidW5kZWZpbmVkXCI9PT10eXBlb2YgZiYmIWspc3dpdGNoKGEudGFnKXtjYXNlIDE6Y2FzZSAyMjpjYXNlIDA6Y2FzZSAxMTpjYXNlIDE1OnRocm93IEVycm9yKHkoMTUyLFJhKGEudHlwZSl8fFwiQ29tcG9uZW50XCIpKTt9cmV0dXJuIGMoYSxkKX19dmFyIFlnPVNnKCEwKSxaZz1TZyghMSksJGc9e30sYWg9QmYoJGcpLGJoPUJmKCRnKSxjaD1CZigkZyk7XG5mdW5jdGlvbiBkaChhKXtpZihhPT09JGcpdGhyb3cgRXJyb3IoeSgxNzQpKTtyZXR1cm4gYX1mdW5jdGlvbiBlaChhLGIpe0koY2gsYik7SShiaCxhKTtJKGFoLCRnKTthPWIubm9kZVR5cGU7c3dpdGNoKGEpe2Nhc2UgOTpjYXNlIDExOmI9KGI9Yi5kb2N1bWVudEVsZW1lbnQpP2IubmFtZXNwYWNlVVJJOm1iKG51bGwsXCJcIik7YnJlYWs7ZGVmYXVsdDphPTg9PT1hP2IucGFyZW50Tm9kZTpiLGI9YS5uYW1lc3BhY2VVUkl8fG51bGwsYT1hLnRhZ05hbWUsYj1tYihiLGEpfUgoYWgpO0koYWgsYil9ZnVuY3Rpb24gZmgoKXtIKGFoKTtIKGJoKTtIKGNoKX1mdW5jdGlvbiBnaChhKXtkaChjaC5jdXJyZW50KTt2YXIgYj1kaChhaC5jdXJyZW50KTt2YXIgYz1tYihiLGEudHlwZSk7YiE9PWMmJihJKGJoLGEpLEkoYWgsYykpfWZ1bmN0aW9uIGhoKGEpe2JoLmN1cnJlbnQ9PT1hJiYoSChhaCksSChiaCkpfXZhciBQPUJmKDApO1xuZnVuY3Rpb24gaWgoYSl7Zm9yKHZhciBiPWE7bnVsbCE9PWI7KXtpZigxMz09PWIudGFnKXt2YXIgYz1iLm1lbW9pemVkU3RhdGU7aWYobnVsbCE9PWMmJihjPWMuZGVoeWRyYXRlZCxudWxsPT09Y3x8XCIkP1wiPT09Yy5kYXRhfHxcIiQhXCI9PT1jLmRhdGEpKXJldHVybiBifWVsc2UgaWYoMTk9PT1iLnRhZyYmdm9pZCAwIT09Yi5tZW1vaXplZFByb3BzLnJldmVhbE9yZGVyKXtpZigwIT09KGIuZmxhZ3MmNjQpKXJldHVybiBifWVsc2UgaWYobnVsbCE9PWIuY2hpbGQpe2IuY2hpbGQucmV0dXJuPWI7Yj1iLmNoaWxkO2NvbnRpbnVlfWlmKGI9PT1hKWJyZWFrO2Zvcig7bnVsbD09PWIuc2libGluZzspe2lmKG51bGw9PT1iLnJldHVybnx8Yi5yZXR1cm49PT1hKXJldHVybiBudWxsO2I9Yi5yZXR1cm59Yi5zaWJsaW5nLnJldHVybj1iLnJldHVybjtiPWIuc2libGluZ31yZXR1cm4gbnVsbH12YXIgamg9bnVsbCxraD1udWxsLGxoPSExO1xuZnVuY3Rpb24gbWgoYSxiKXt2YXIgYz1uaCg1LG51bGwsbnVsbCwwKTtjLmVsZW1lbnRUeXBlPVwiREVMRVRFRFwiO2MudHlwZT1cIkRFTEVURURcIjtjLnN0YXRlTm9kZT1iO2MucmV0dXJuPWE7Yy5mbGFncz04O251bGwhPT1hLmxhc3RFZmZlY3Q/KGEubGFzdEVmZmVjdC5uZXh0RWZmZWN0PWMsYS5sYXN0RWZmZWN0PWMpOmEuZmlyc3RFZmZlY3Q9YS5sYXN0RWZmZWN0PWN9ZnVuY3Rpb24gb2goYSxiKXtzd2l0Y2goYS50YWcpe2Nhc2UgNTp2YXIgYz1hLnR5cGU7Yj0xIT09Yi5ub2RlVHlwZXx8Yy50b0xvd2VyQ2FzZSgpIT09Yi5ub2RlTmFtZS50b0xvd2VyQ2FzZSgpP251bGw6YjtyZXR1cm4gbnVsbCE9PWI/KGEuc3RhdGVOb2RlPWIsITApOiExO2Nhc2UgNjpyZXR1cm4gYj1cIlwiPT09YS5wZW5kaW5nUHJvcHN8fDMhPT1iLm5vZGVUeXBlP251bGw6YixudWxsIT09Yj8oYS5zdGF0ZU5vZGU9YiwhMCk6ITE7Y2FzZSAxMzpyZXR1cm4hMTtkZWZhdWx0OnJldHVybiExfX1cbmZ1bmN0aW9uIHBoKGEpe2lmKGxoKXt2YXIgYj1raDtpZihiKXt2YXIgYz1iO2lmKCFvaChhLGIpKXtiPXJmKGMubmV4dFNpYmxpbmcpO2lmKCFifHwhb2goYSxiKSl7YS5mbGFncz1hLmZsYWdzJi0xMDI1fDI7bGg9ITE7amg9YTtyZXR1cm59bWgoamgsYyl9amg9YTtraD1yZihiLmZpcnN0Q2hpbGQpfWVsc2UgYS5mbGFncz1hLmZsYWdzJi0xMDI1fDIsbGg9ITEsamg9YX19ZnVuY3Rpb24gcWgoYSl7Zm9yKGE9YS5yZXR1cm47bnVsbCE9PWEmJjUhPT1hLnRhZyYmMyE9PWEudGFnJiYxMyE9PWEudGFnOylhPWEucmV0dXJuO2poPWF9XG5mdW5jdGlvbiByaChhKXtpZihhIT09amgpcmV0dXJuITE7aWYoIWxoKXJldHVybiBxaChhKSxsaD0hMCwhMTt2YXIgYj1hLnR5cGU7aWYoNSE9PWEudGFnfHxcImhlYWRcIiE9PWImJlwiYm9keVwiIT09YiYmIW5mKGIsYS5tZW1vaXplZFByb3BzKSlmb3IoYj1raDtiOyltaChhLGIpLGI9cmYoYi5uZXh0U2libGluZyk7cWgoYSk7aWYoMTM9PT1hLnRhZyl7YT1hLm1lbW9pemVkU3RhdGU7YT1udWxsIT09YT9hLmRlaHlkcmF0ZWQ6bnVsbDtpZighYSl0aHJvdyBFcnJvcih5KDMxNykpO2E6e2E9YS5uZXh0U2libGluZztmb3IoYj0wO2E7KXtpZig4PT09YS5ub2RlVHlwZSl7dmFyIGM9YS5kYXRhO2lmKFwiLyRcIj09PWMpe2lmKDA9PT1iKXtraD1yZihhLm5leHRTaWJsaW5nKTticmVhayBhfWItLX1lbHNlXCIkXCIhPT1jJiZcIiQhXCIhPT1jJiZcIiQ/XCIhPT1jfHxiKyt9YT1hLm5leHRTaWJsaW5nfWtoPW51bGx9fWVsc2Uga2g9amg/cmYoYS5zdGF0ZU5vZGUubmV4dFNpYmxpbmcpOm51bGw7cmV0dXJuITB9XG5mdW5jdGlvbiBzaCgpe2toPWpoPW51bGw7bGg9ITF9dmFyIHRoPVtdO2Z1bmN0aW9uIHVoKCl7Zm9yKHZhciBhPTA7YTx0aC5sZW5ndGg7YSsrKXRoW2FdLl93b3JrSW5Qcm9ncmVzc1ZlcnNpb25QcmltYXJ5PW51bGw7dGgubGVuZ3RoPTB9dmFyIHZoPXJhLlJlYWN0Q3VycmVudERpc3BhdGNoZXIsd2g9cmEuUmVhY3RDdXJyZW50QmF0Y2hDb25maWcseGg9MCxSPW51bGwsUz1udWxsLFQ9bnVsbCx5aD0hMSx6aD0hMTtmdW5jdGlvbiBBaCgpe3Rocm93IEVycm9yKHkoMzIxKSk7fWZ1bmN0aW9uIEJoKGEsYil7aWYobnVsbD09PWIpcmV0dXJuITE7Zm9yKHZhciBjPTA7YzxiLmxlbmd0aCYmYzxhLmxlbmd0aDtjKyspaWYoIUhlKGFbY10sYltjXSkpcmV0dXJuITE7cmV0dXJuITB9XG5mdW5jdGlvbiBDaChhLGIsYyxkLGUsZil7eGg9ZjtSPWI7Yi5tZW1vaXplZFN0YXRlPW51bGw7Yi51cGRhdGVRdWV1ZT1udWxsO2IubGFuZXM9MDt2aC5jdXJyZW50PW51bGw9PT1hfHxudWxsPT09YS5tZW1vaXplZFN0YXRlP0RoOkVoO2E9YyhkLGUpO2lmKHpoKXtmPTA7ZG97emg9ITE7aWYoISgyNT5mKSl0aHJvdyBFcnJvcih5KDMwMSkpO2YrPTE7VD1TPW51bGw7Yi51cGRhdGVRdWV1ZT1udWxsO3ZoLmN1cnJlbnQ9Rmg7YT1jKGQsZSl9d2hpbGUoemgpfXZoLmN1cnJlbnQ9R2g7Yj1udWxsIT09UyYmbnVsbCE9PVMubmV4dDt4aD0wO1Q9Uz1SPW51bGw7eWg9ITE7aWYoYil0aHJvdyBFcnJvcih5KDMwMCkpO3JldHVybiBhfWZ1bmN0aW9uIEhoKCl7dmFyIGE9e21lbW9pemVkU3RhdGU6bnVsbCxiYXNlU3RhdGU6bnVsbCxiYXNlUXVldWU6bnVsbCxxdWV1ZTpudWxsLG5leHQ6bnVsbH07bnVsbD09PVQ/Ui5tZW1vaXplZFN0YXRlPVQ9YTpUPVQubmV4dD1hO3JldHVybiBUfVxuZnVuY3Rpb24gSWgoKXtpZihudWxsPT09Uyl7dmFyIGE9Ui5hbHRlcm5hdGU7YT1udWxsIT09YT9hLm1lbW9pemVkU3RhdGU6bnVsbH1lbHNlIGE9Uy5uZXh0O3ZhciBiPW51bGw9PT1UP1IubWVtb2l6ZWRTdGF0ZTpULm5leHQ7aWYobnVsbCE9PWIpVD1iLFM9YTtlbHNle2lmKG51bGw9PT1hKXRocm93IEVycm9yKHkoMzEwKSk7Uz1hO2E9e21lbW9pemVkU3RhdGU6Uy5tZW1vaXplZFN0YXRlLGJhc2VTdGF0ZTpTLmJhc2VTdGF0ZSxiYXNlUXVldWU6Uy5iYXNlUXVldWUscXVldWU6Uy5xdWV1ZSxuZXh0Om51bGx9O251bGw9PT1UP1IubWVtb2l6ZWRTdGF0ZT1UPWE6VD1ULm5leHQ9YX1yZXR1cm4gVH1mdW5jdGlvbiBKaChhLGIpe3JldHVyblwiZnVuY3Rpb25cIj09PXR5cGVvZiBiP2IoYSk6Yn1cbmZ1bmN0aW9uIEtoKGEpe3ZhciBiPUloKCksYz1iLnF1ZXVlO2lmKG51bGw9PT1jKXRocm93IEVycm9yKHkoMzExKSk7Yy5sYXN0UmVuZGVyZWRSZWR1Y2VyPWE7dmFyIGQ9UyxlPWQuYmFzZVF1ZXVlLGY9Yy5wZW5kaW5nO2lmKG51bGwhPT1mKXtpZihudWxsIT09ZSl7dmFyIGc9ZS5uZXh0O2UubmV4dD1mLm5leHQ7Zi5uZXh0PWd9ZC5iYXNlUXVldWU9ZT1mO2MucGVuZGluZz1udWxsfWlmKG51bGwhPT1lKXtlPWUubmV4dDtkPWQuYmFzZVN0YXRlO3ZhciBoPWc9Zj1udWxsLGs9ZTtkb3t2YXIgbD1rLmxhbmU7aWYoKHhoJmwpPT09bCludWxsIT09aCYmKGg9aC5uZXh0PXtsYW5lOjAsYWN0aW9uOmsuYWN0aW9uLGVhZ2VyUmVkdWNlcjprLmVhZ2VyUmVkdWNlcixlYWdlclN0YXRlOmsuZWFnZXJTdGF0ZSxuZXh0Om51bGx9KSxkPWsuZWFnZXJSZWR1Y2VyPT09YT9rLmVhZ2VyU3RhdGU6YShkLGsuYWN0aW9uKTtlbHNle3ZhciBuPXtsYW5lOmwsYWN0aW9uOmsuYWN0aW9uLGVhZ2VyUmVkdWNlcjprLmVhZ2VyUmVkdWNlcixcbmVhZ2VyU3RhdGU6ay5lYWdlclN0YXRlLG5leHQ6bnVsbH07bnVsbD09PWg/KGc9aD1uLGY9ZCk6aD1oLm5leHQ9bjtSLmxhbmVzfD1sO0RnfD1sfWs9ay5uZXh0fXdoaWxlKG51bGwhPT1rJiZrIT09ZSk7bnVsbD09PWg/Zj1kOmgubmV4dD1nO0hlKGQsYi5tZW1vaXplZFN0YXRlKXx8KHVnPSEwKTtiLm1lbW9pemVkU3RhdGU9ZDtiLmJhc2VTdGF0ZT1mO2IuYmFzZVF1ZXVlPWg7Yy5sYXN0UmVuZGVyZWRTdGF0ZT1kfXJldHVybltiLm1lbW9pemVkU3RhdGUsYy5kaXNwYXRjaF19XG5mdW5jdGlvbiBMaChhKXt2YXIgYj1JaCgpLGM9Yi5xdWV1ZTtpZihudWxsPT09Yyl0aHJvdyBFcnJvcih5KDMxMSkpO2MubGFzdFJlbmRlcmVkUmVkdWNlcj1hO3ZhciBkPWMuZGlzcGF0Y2gsZT1jLnBlbmRpbmcsZj1iLm1lbW9pemVkU3RhdGU7aWYobnVsbCE9PWUpe2MucGVuZGluZz1udWxsO3ZhciBnPWU9ZS5uZXh0O2RvIGY9YShmLGcuYWN0aW9uKSxnPWcubmV4dDt3aGlsZShnIT09ZSk7SGUoZixiLm1lbW9pemVkU3RhdGUpfHwodWc9ITApO2IubWVtb2l6ZWRTdGF0ZT1mO251bGw9PT1iLmJhc2VRdWV1ZSYmKGIuYmFzZVN0YXRlPWYpO2MubGFzdFJlbmRlcmVkU3RhdGU9Zn1yZXR1cm5bZixkXX1cbmZ1bmN0aW9uIE1oKGEsYixjKXt2YXIgZD1iLl9nZXRWZXJzaW9uO2Q9ZChiLl9zb3VyY2UpO3ZhciBlPWIuX3dvcmtJblByb2dyZXNzVmVyc2lvblByaW1hcnk7aWYobnVsbCE9PWUpYT1lPT09ZDtlbHNlIGlmKGE9YS5tdXRhYmxlUmVhZExhbmVzLGE9KHhoJmEpPT09YSliLl93b3JrSW5Qcm9ncmVzc1ZlcnNpb25QcmltYXJ5PWQsdGgucHVzaChiKTtpZihhKXJldHVybiBjKGIuX3NvdXJjZSk7dGgucHVzaChiKTt0aHJvdyBFcnJvcih5KDM1MCkpO31cbmZ1bmN0aW9uIE5oKGEsYixjLGQpe3ZhciBlPVU7aWYobnVsbD09PWUpdGhyb3cgRXJyb3IoeSgzNDkpKTt2YXIgZj1iLl9nZXRWZXJzaW9uLGc9ZihiLl9zb3VyY2UpLGg9dmguY3VycmVudCxrPWgudXNlU3RhdGUoZnVuY3Rpb24oKXtyZXR1cm4gTWgoZSxiLGMpfSksbD1rWzFdLG49a1swXTtrPVQ7dmFyIEE9YS5tZW1vaXplZFN0YXRlLHA9QS5yZWZzLEM9cC5nZXRTbmFwc2hvdCx4PUEuc291cmNlO0E9QS5zdWJzY3JpYmU7dmFyIHc9UjthLm1lbW9pemVkU3RhdGU9e3JlZnM6cCxzb3VyY2U6YixzdWJzY3JpYmU6ZH07aC51c2VFZmZlY3QoZnVuY3Rpb24oKXtwLmdldFNuYXBzaG90PWM7cC5zZXRTbmFwc2hvdD1sO3ZhciBhPWYoYi5fc291cmNlKTtpZighSGUoZyxhKSl7YT1jKGIuX3NvdXJjZSk7SGUobixhKXx8KGwoYSksYT1JZyh3KSxlLm11dGFibGVSZWFkTGFuZXN8PWEmZS5wZW5kaW5nTGFuZXMpO2E9ZS5tdXRhYmxlUmVhZExhbmVzO2UuZW50YW5nbGVkTGFuZXN8PWE7Zm9yKHZhciBkPVxuZS5lbnRhbmdsZW1lbnRzLGg9YTswPGg7KXt2YXIgaz0zMS1WYyhoKSx2PTE8PGs7ZFtrXXw9YTtoJj1+dn19fSxbYyxiLGRdKTtoLnVzZUVmZmVjdChmdW5jdGlvbigpe3JldHVybiBkKGIuX3NvdXJjZSxmdW5jdGlvbigpe3ZhciBhPXAuZ2V0U25hcHNob3QsYz1wLnNldFNuYXBzaG90O3RyeXtjKGEoYi5fc291cmNlKSk7dmFyIGQ9SWcodyk7ZS5tdXRhYmxlUmVhZExhbmVzfD1kJmUucGVuZGluZ0xhbmVzfWNhdGNoKHEpe2MoZnVuY3Rpb24oKXt0aHJvdyBxO30pfX0pfSxbYixkXSk7SGUoQyxjKSYmSGUoeCxiKSYmSGUoQSxkKXx8KGE9e3BlbmRpbmc6bnVsbCxkaXNwYXRjaDpudWxsLGxhc3RSZW5kZXJlZFJlZHVjZXI6SmgsbGFzdFJlbmRlcmVkU3RhdGU6bn0sYS5kaXNwYXRjaD1sPU9oLmJpbmQobnVsbCxSLGEpLGsucXVldWU9YSxrLmJhc2VRdWV1ZT1udWxsLG49TWgoZSxiLGMpLGsubWVtb2l6ZWRTdGF0ZT1rLmJhc2VTdGF0ZT1uKTtyZXR1cm4gbn1cbmZ1bmN0aW9uIFBoKGEsYixjKXt2YXIgZD1JaCgpO3JldHVybiBOaChkLGEsYixjKX1mdW5jdGlvbiBRaChhKXt2YXIgYj1IaCgpO1wiZnVuY3Rpb25cIj09PXR5cGVvZiBhJiYoYT1hKCkpO2IubWVtb2l6ZWRTdGF0ZT1iLmJhc2VTdGF0ZT1hO2E9Yi5xdWV1ZT17cGVuZGluZzpudWxsLGRpc3BhdGNoOm51bGwsbGFzdFJlbmRlcmVkUmVkdWNlcjpKaCxsYXN0UmVuZGVyZWRTdGF0ZTphfTthPWEuZGlzcGF0Y2g9T2guYmluZChudWxsLFIsYSk7cmV0dXJuW2IubWVtb2l6ZWRTdGF0ZSxhXX1cbmZ1bmN0aW9uIFJoKGEsYixjLGQpe2E9e3RhZzphLGNyZWF0ZTpiLGRlc3Ryb3k6YyxkZXBzOmQsbmV4dDpudWxsfTtiPVIudXBkYXRlUXVldWU7bnVsbD09PWI/KGI9e2xhc3RFZmZlY3Q6bnVsbH0sUi51cGRhdGVRdWV1ZT1iLGIubGFzdEVmZmVjdD1hLm5leHQ9YSk6KGM9Yi5sYXN0RWZmZWN0LG51bGw9PT1jP2IubGFzdEVmZmVjdD1hLm5leHQ9YTooZD1jLm5leHQsYy5uZXh0PWEsYS5uZXh0PWQsYi5sYXN0RWZmZWN0PWEpKTtyZXR1cm4gYX1mdW5jdGlvbiBTaChhKXt2YXIgYj1IaCgpO2E9e2N1cnJlbnQ6YX07cmV0dXJuIGIubWVtb2l6ZWRTdGF0ZT1hfWZ1bmN0aW9uIFRoKCl7cmV0dXJuIEloKCkubWVtb2l6ZWRTdGF0ZX1mdW5jdGlvbiBVaChhLGIsYyxkKXt2YXIgZT1IaCgpO1IuZmxhZ3N8PWE7ZS5tZW1vaXplZFN0YXRlPVJoKDF8YixjLHZvaWQgMCx2b2lkIDA9PT1kP251bGw6ZCl9XG5mdW5jdGlvbiBWaChhLGIsYyxkKXt2YXIgZT1JaCgpO2Q9dm9pZCAwPT09ZD9udWxsOmQ7dmFyIGY9dm9pZCAwO2lmKG51bGwhPT1TKXt2YXIgZz1TLm1lbW9pemVkU3RhdGU7Zj1nLmRlc3Ryb3k7aWYobnVsbCE9PWQmJkJoKGQsZy5kZXBzKSl7UmgoYixjLGYsZCk7cmV0dXJufX1SLmZsYWdzfD1hO2UubWVtb2l6ZWRTdGF0ZT1SaCgxfGIsYyxmLGQpfWZ1bmN0aW9uIFdoKGEsYil7cmV0dXJuIFVoKDUxNiw0LGEsYil9ZnVuY3Rpb24gWGgoYSxiKXtyZXR1cm4gVmgoNTE2LDQsYSxiKX1mdW5jdGlvbiBZaChhLGIpe3JldHVybiBWaCg0LDIsYSxiKX1mdW5jdGlvbiBaaChhLGIpe2lmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBiKXJldHVybiBhPWEoKSxiKGEpLGZ1bmN0aW9uKCl7YihudWxsKX07aWYobnVsbCE9PWImJnZvaWQgMCE9PWIpcmV0dXJuIGE9YSgpLGIuY3VycmVudD1hLGZ1bmN0aW9uKCl7Yi5jdXJyZW50PW51bGx9fVxuZnVuY3Rpb24gJGgoYSxiLGMpe2M9bnVsbCE9PWMmJnZvaWQgMCE9PWM/Yy5jb25jYXQoW2FdKTpudWxsO3JldHVybiBWaCg0LDIsWmguYmluZChudWxsLGIsYSksYyl9ZnVuY3Rpb24gYWkoKXt9ZnVuY3Rpb24gYmkoYSxiKXt2YXIgYz1JaCgpO2I9dm9pZCAwPT09Yj9udWxsOmI7dmFyIGQ9Yy5tZW1vaXplZFN0YXRlO2lmKG51bGwhPT1kJiZudWxsIT09YiYmQmgoYixkWzFdKSlyZXR1cm4gZFswXTtjLm1lbW9pemVkU3RhdGU9W2EsYl07cmV0dXJuIGF9ZnVuY3Rpb24gY2koYSxiKXt2YXIgYz1JaCgpO2I9dm9pZCAwPT09Yj9udWxsOmI7dmFyIGQ9Yy5tZW1vaXplZFN0YXRlO2lmKG51bGwhPT1kJiZudWxsIT09YiYmQmgoYixkWzFdKSlyZXR1cm4gZFswXTthPWEoKTtjLm1lbW9pemVkU3RhdGU9W2EsYl07cmV0dXJuIGF9XG5mdW5jdGlvbiBkaShhLGIpe3ZhciBjPWVnKCk7Z2coOTg+Yz85ODpjLGZ1bmN0aW9uKCl7YSghMCl9KTtnZyg5NzxjPzk3OmMsZnVuY3Rpb24oKXt2YXIgYz13aC50cmFuc2l0aW9uO3doLnRyYW5zaXRpb249MTt0cnl7YSghMSksYigpfWZpbmFsbHl7d2gudHJhbnNpdGlvbj1jfX0pfVxuZnVuY3Rpb24gT2goYSxiLGMpe3ZhciBkPUhnKCksZT1JZyhhKSxmPXtsYW5lOmUsYWN0aW9uOmMsZWFnZXJSZWR1Y2VyOm51bGwsZWFnZXJTdGF0ZTpudWxsLG5leHQ6bnVsbH0sZz1iLnBlbmRpbmc7bnVsbD09PWc/Zi5uZXh0PWY6KGYubmV4dD1nLm5leHQsZy5uZXh0PWYpO2IucGVuZGluZz1mO2c9YS5hbHRlcm5hdGU7aWYoYT09PVJ8fG51bGwhPT1nJiZnPT09Uil6aD15aD0hMDtlbHNle2lmKDA9PT1hLmxhbmVzJiYobnVsbD09PWd8fDA9PT1nLmxhbmVzKSYmKGc9Yi5sYXN0UmVuZGVyZWRSZWR1Y2VyLG51bGwhPT1nKSl0cnl7dmFyIGg9Yi5sYXN0UmVuZGVyZWRTdGF0ZSxrPWcoaCxjKTtmLmVhZ2VyUmVkdWNlcj1nO2YuZWFnZXJTdGF0ZT1rO2lmKEhlKGssaCkpcmV0dXJufWNhdGNoKGwpe31maW5hbGx5e31KZyhhLGUsZCl9fVxudmFyIEdoPXtyZWFkQ29udGV4dDp2Zyx1c2VDYWxsYmFjazpBaCx1c2VDb250ZXh0OkFoLHVzZUVmZmVjdDpBaCx1c2VJbXBlcmF0aXZlSGFuZGxlOkFoLHVzZUxheW91dEVmZmVjdDpBaCx1c2VNZW1vOkFoLHVzZVJlZHVjZXI6QWgsdXNlUmVmOkFoLHVzZVN0YXRlOkFoLHVzZURlYnVnVmFsdWU6QWgsdXNlRGVmZXJyZWRWYWx1ZTpBaCx1c2VUcmFuc2l0aW9uOkFoLHVzZU11dGFibGVTb3VyY2U6QWgsdXNlT3BhcXVlSWRlbnRpZmllcjpBaCx1bnN0YWJsZV9pc05ld1JlY29uY2lsZXI6ITF9LERoPXtyZWFkQ29udGV4dDp2Zyx1c2VDYWxsYmFjazpmdW5jdGlvbihhLGIpe0hoKCkubWVtb2l6ZWRTdGF0ZT1bYSx2b2lkIDA9PT1iP251bGw6Yl07cmV0dXJuIGF9LHVzZUNvbnRleHQ6dmcsdXNlRWZmZWN0OldoLHVzZUltcGVyYXRpdmVIYW5kbGU6ZnVuY3Rpb24oYSxiLGMpe2M9bnVsbCE9PWMmJnZvaWQgMCE9PWM/Yy5jb25jYXQoW2FdKTpudWxsO3JldHVybiBVaCg0LDIsWmguYmluZChudWxsLFxuYixhKSxjKX0sdXNlTGF5b3V0RWZmZWN0OmZ1bmN0aW9uKGEsYil7cmV0dXJuIFVoKDQsMixhLGIpfSx1c2VNZW1vOmZ1bmN0aW9uKGEsYil7dmFyIGM9SGgoKTtiPXZvaWQgMD09PWI/bnVsbDpiO2E9YSgpO2MubWVtb2l6ZWRTdGF0ZT1bYSxiXTtyZXR1cm4gYX0sdXNlUmVkdWNlcjpmdW5jdGlvbihhLGIsYyl7dmFyIGQ9SGgoKTtiPXZvaWQgMCE9PWM/YyhiKTpiO2QubWVtb2l6ZWRTdGF0ZT1kLmJhc2VTdGF0ZT1iO2E9ZC5xdWV1ZT17cGVuZGluZzpudWxsLGRpc3BhdGNoOm51bGwsbGFzdFJlbmRlcmVkUmVkdWNlcjphLGxhc3RSZW5kZXJlZFN0YXRlOmJ9O2E9YS5kaXNwYXRjaD1PaC5iaW5kKG51bGwsUixhKTtyZXR1cm5bZC5tZW1vaXplZFN0YXRlLGFdfSx1c2VSZWY6U2gsdXNlU3RhdGU6UWgsdXNlRGVidWdWYWx1ZTphaSx1c2VEZWZlcnJlZFZhbHVlOmZ1bmN0aW9uKGEpe3ZhciBiPVFoKGEpLGM9YlswXSxkPWJbMV07V2goZnVuY3Rpb24oKXt2YXIgYj13aC50cmFuc2l0aW9uO1xud2gudHJhbnNpdGlvbj0xO3RyeXtkKGEpfWZpbmFsbHl7d2gudHJhbnNpdGlvbj1ifX0sW2FdKTtyZXR1cm4gY30sdXNlVHJhbnNpdGlvbjpmdW5jdGlvbigpe3ZhciBhPVFoKCExKSxiPWFbMF07YT1kaS5iaW5kKG51bGwsYVsxXSk7U2goYSk7cmV0dXJuW2EsYl19LHVzZU11dGFibGVTb3VyY2U6ZnVuY3Rpb24oYSxiLGMpe3ZhciBkPUhoKCk7ZC5tZW1vaXplZFN0YXRlPXtyZWZzOntnZXRTbmFwc2hvdDpiLHNldFNuYXBzaG90Om51bGx9LHNvdXJjZTphLHN1YnNjcmliZTpjfTtyZXR1cm4gTmgoZCxhLGIsYyl9LHVzZU9wYXF1ZUlkZW50aWZpZXI6ZnVuY3Rpb24oKXtpZihsaCl7dmFyIGE9ITEsYj11ZihmdW5jdGlvbigpe2F8fChhPSEwLGMoXCJyOlwiKyh0ZisrKS50b1N0cmluZygzNikpKTt0aHJvdyBFcnJvcih5KDM1NSkpO30pLGM9UWgoYilbMV07MD09PShSLm1vZGUmMikmJihSLmZsYWdzfD01MTYsUmgoNSxmdW5jdGlvbigpe2MoXCJyOlwiKyh0ZisrKS50b1N0cmluZygzNikpfSxcbnZvaWQgMCxudWxsKSk7cmV0dXJuIGJ9Yj1cInI6XCIrKHRmKyspLnRvU3RyaW5nKDM2KTtRaChiKTtyZXR1cm4gYn0sdW5zdGFibGVfaXNOZXdSZWNvbmNpbGVyOiExfSxFaD17cmVhZENvbnRleHQ6dmcsdXNlQ2FsbGJhY2s6YmksdXNlQ29udGV4dDp2Zyx1c2VFZmZlY3Q6WGgsdXNlSW1wZXJhdGl2ZUhhbmRsZTokaCx1c2VMYXlvdXRFZmZlY3Q6WWgsdXNlTWVtbzpjaSx1c2VSZWR1Y2VyOktoLHVzZVJlZjpUaCx1c2VTdGF0ZTpmdW5jdGlvbigpe3JldHVybiBLaChKaCl9LHVzZURlYnVnVmFsdWU6YWksdXNlRGVmZXJyZWRWYWx1ZTpmdW5jdGlvbihhKXt2YXIgYj1LaChKaCksYz1iWzBdLGQ9YlsxXTtYaChmdW5jdGlvbigpe3ZhciBiPXdoLnRyYW5zaXRpb247d2gudHJhbnNpdGlvbj0xO3RyeXtkKGEpfWZpbmFsbHl7d2gudHJhbnNpdGlvbj1ifX0sW2FdKTtyZXR1cm4gY30sdXNlVHJhbnNpdGlvbjpmdW5jdGlvbigpe3ZhciBhPUtoKEpoKVswXTtyZXR1cm5bVGgoKS5jdXJyZW50LFxuYV19LHVzZU11dGFibGVTb3VyY2U6UGgsdXNlT3BhcXVlSWRlbnRpZmllcjpmdW5jdGlvbigpe3JldHVybiBLaChKaClbMF19LHVuc3RhYmxlX2lzTmV3UmVjb25jaWxlcjohMX0sRmg9e3JlYWRDb250ZXh0OnZnLHVzZUNhbGxiYWNrOmJpLHVzZUNvbnRleHQ6dmcsdXNlRWZmZWN0OlhoLHVzZUltcGVyYXRpdmVIYW5kbGU6JGgsdXNlTGF5b3V0RWZmZWN0OlloLHVzZU1lbW86Y2ksdXNlUmVkdWNlcjpMaCx1c2VSZWY6VGgsdXNlU3RhdGU6ZnVuY3Rpb24oKXtyZXR1cm4gTGgoSmgpfSx1c2VEZWJ1Z1ZhbHVlOmFpLHVzZURlZmVycmVkVmFsdWU6ZnVuY3Rpb24oYSl7dmFyIGI9TGgoSmgpLGM9YlswXSxkPWJbMV07WGgoZnVuY3Rpb24oKXt2YXIgYj13aC50cmFuc2l0aW9uO3doLnRyYW5zaXRpb249MTt0cnl7ZChhKX1maW5hbGx5e3doLnRyYW5zaXRpb249Yn19LFthXSk7cmV0dXJuIGN9LHVzZVRyYW5zaXRpb246ZnVuY3Rpb24oKXt2YXIgYT1MaChKaClbMF07cmV0dXJuW1RoKCkuY3VycmVudCxcbmFdfSx1c2VNdXRhYmxlU291cmNlOlBoLHVzZU9wYXF1ZUlkZW50aWZpZXI6ZnVuY3Rpb24oKXtyZXR1cm4gTGgoSmgpWzBdfSx1bnN0YWJsZV9pc05ld1JlY29uY2lsZXI6ITF9LGVpPXJhLlJlYWN0Q3VycmVudE93bmVyLHVnPSExO2Z1bmN0aW9uIGZpKGEsYixjLGQpe2IuY2hpbGQ9bnVsbD09PWE/WmcoYixudWxsLGMsZCk6WWcoYixhLmNoaWxkLGMsZCl9ZnVuY3Rpb24gZ2koYSxiLGMsZCxlKXtjPWMucmVuZGVyO3ZhciBmPWIucmVmO3RnKGIsZSk7ZD1DaChhLGIsYyxkLGYsZSk7aWYobnVsbCE9PWEmJiF1ZylyZXR1cm4gYi51cGRhdGVRdWV1ZT1hLnVwZGF0ZVF1ZXVlLGIuZmxhZ3MmPS01MTcsYS5sYW5lcyY9fmUsaGkoYSxiLGUpO2IuZmxhZ3N8PTE7ZmkoYSxiLGQsZSk7cmV0dXJuIGIuY2hpbGR9XG5mdW5jdGlvbiBpaShhLGIsYyxkLGUsZil7aWYobnVsbD09PWEpe3ZhciBnPWMudHlwZTtpZihcImZ1bmN0aW9uXCI9PT10eXBlb2YgZyYmIWppKGcpJiZ2b2lkIDA9PT1nLmRlZmF1bHRQcm9wcyYmbnVsbD09PWMuY29tcGFyZSYmdm9pZCAwPT09Yy5kZWZhdWx0UHJvcHMpcmV0dXJuIGIudGFnPTE1LGIudHlwZT1nLGtpKGEsYixnLGQsZSxmKTthPVZnKGMudHlwZSxudWxsLGQsYixiLm1vZGUsZik7YS5yZWY9Yi5yZWY7YS5yZXR1cm49YjtyZXR1cm4gYi5jaGlsZD1hfWc9YS5jaGlsZDtpZigwPT09KGUmZikmJihlPWcubWVtb2l6ZWRQcm9wcyxjPWMuY29tcGFyZSxjPW51bGwhPT1jP2M6SmUsYyhlLGQpJiZhLnJlZj09PWIucmVmKSlyZXR1cm4gaGkoYSxiLGYpO2IuZmxhZ3N8PTE7YT1UZyhnLGQpO2EucmVmPWIucmVmO2EucmV0dXJuPWI7cmV0dXJuIGIuY2hpbGQ9YX1cbmZ1bmN0aW9uIGtpKGEsYixjLGQsZSxmKXtpZihudWxsIT09YSYmSmUoYS5tZW1vaXplZFByb3BzLGQpJiZhLnJlZj09PWIucmVmKWlmKHVnPSExLDAhPT0oZiZlKSkwIT09KGEuZmxhZ3MmMTYzODQpJiYodWc9ITApO2Vsc2UgcmV0dXJuIGIubGFuZXM9YS5sYW5lcyxoaShhLGIsZik7cmV0dXJuIGxpKGEsYixjLGQsZil9XG5mdW5jdGlvbiBtaShhLGIsYyl7dmFyIGQ9Yi5wZW5kaW5nUHJvcHMsZT1kLmNoaWxkcmVuLGY9bnVsbCE9PWE/YS5tZW1vaXplZFN0YXRlOm51bGw7aWYoXCJoaWRkZW5cIj09PWQubW9kZXx8XCJ1bnN0YWJsZS1kZWZlci13aXRob3V0LWhpZGluZ1wiPT09ZC5tb2RlKWlmKDA9PT0oYi5tb2RlJjQpKWIubWVtb2l6ZWRTdGF0ZT17YmFzZUxhbmVzOjB9LG5pKGIsYyk7ZWxzZSBpZigwIT09KGMmMTA3Mzc0MTgyNCkpYi5tZW1vaXplZFN0YXRlPXtiYXNlTGFuZXM6MH0sbmkoYixudWxsIT09Zj9mLmJhc2VMYW5lczpjKTtlbHNlIHJldHVybiBhPW51bGwhPT1mP2YuYmFzZUxhbmVzfGM6YyxiLmxhbmVzPWIuY2hpbGRMYW5lcz0xMDczNzQxODI0LGIubWVtb2l6ZWRTdGF0ZT17YmFzZUxhbmVzOmF9LG5pKGIsYSksbnVsbDtlbHNlIG51bGwhPT1mPyhkPWYuYmFzZUxhbmVzfGMsYi5tZW1vaXplZFN0YXRlPW51bGwpOmQ9YyxuaShiLGQpO2ZpKGEsYixlLGMpO3JldHVybiBiLmNoaWxkfVxuZnVuY3Rpb24gb2koYSxiKXt2YXIgYz1iLnJlZjtpZihudWxsPT09YSYmbnVsbCE9PWN8fG51bGwhPT1hJiZhLnJlZiE9PWMpYi5mbGFnc3w9MTI4fWZ1bmN0aW9uIGxpKGEsYixjLGQsZSl7dmFyIGY9RmYoYyk/RGY6TS5jdXJyZW50O2Y9RWYoYixmKTt0ZyhiLGUpO2M9Q2goYSxiLGMsZCxmLGUpO2lmKG51bGwhPT1hJiYhdWcpcmV0dXJuIGIudXBkYXRlUXVldWU9YS51cGRhdGVRdWV1ZSxiLmZsYWdzJj0tNTE3LGEubGFuZXMmPX5lLGhpKGEsYixlKTtiLmZsYWdzfD0xO2ZpKGEsYixjLGUpO3JldHVybiBiLmNoaWxkfVxuZnVuY3Rpb24gcGkoYSxiLGMsZCxlKXtpZihGZihjKSl7dmFyIGY9ITA7SmYoYil9ZWxzZSBmPSExO3RnKGIsZSk7aWYobnVsbD09PWIuc3RhdGVOb2RlKW51bGwhPT1hJiYoYS5hbHRlcm5hdGU9bnVsbCxiLmFsdGVybmF0ZT1udWxsLGIuZmxhZ3N8PTIpLE1nKGIsYyxkKSxPZyhiLGMsZCxlKSxkPSEwO2Vsc2UgaWYobnVsbD09PWEpe3ZhciBnPWIuc3RhdGVOb2RlLGg9Yi5tZW1vaXplZFByb3BzO2cucHJvcHM9aDt2YXIgaz1nLmNvbnRleHQsbD1jLmNvbnRleHRUeXBlO1wib2JqZWN0XCI9PT10eXBlb2YgbCYmbnVsbCE9PWw/bD12ZyhsKToobD1GZihjKT9EZjpNLmN1cnJlbnQsbD1FZihiLGwpKTt2YXIgbj1jLmdldERlcml2ZWRTdGF0ZUZyb21Qcm9wcyxBPVwiZnVuY3Rpb25cIj09PXR5cGVvZiBufHxcImZ1bmN0aW9uXCI9PT10eXBlb2YgZy5nZXRTbmFwc2hvdEJlZm9yZVVwZGF0ZTtBfHxcImZ1bmN0aW9uXCIhPT10eXBlb2YgZy5VTlNBRkVfY29tcG9uZW50V2lsbFJlY2VpdmVQcm9wcyYmXG5cImZ1bmN0aW9uXCIhPT10eXBlb2YgZy5jb21wb25lbnRXaWxsUmVjZWl2ZVByb3BzfHwoaCE9PWR8fGshPT1sKSYmTmcoYixnLGQsbCk7d2c9ITE7dmFyIHA9Yi5tZW1vaXplZFN0YXRlO2cuc3RhdGU9cDtDZyhiLGQsZyxlKTtrPWIubWVtb2l6ZWRTdGF0ZTtoIT09ZHx8cCE9PWt8fE4uY3VycmVudHx8d2c/KFwiZnVuY3Rpb25cIj09PXR5cGVvZiBuJiYoR2coYixjLG4sZCksaz1iLm1lbW9pemVkU3RhdGUpLChoPXdnfHxMZyhiLGMsaCxkLHAsayxsKSk/KEF8fFwiZnVuY3Rpb25cIiE9PXR5cGVvZiBnLlVOU0FGRV9jb21wb25lbnRXaWxsTW91bnQmJlwiZnVuY3Rpb25cIiE9PXR5cGVvZiBnLmNvbXBvbmVudFdpbGxNb3VudHx8KFwiZnVuY3Rpb25cIj09PXR5cGVvZiBnLmNvbXBvbmVudFdpbGxNb3VudCYmZy5jb21wb25lbnRXaWxsTW91bnQoKSxcImZ1bmN0aW9uXCI9PT10eXBlb2YgZy5VTlNBRkVfY29tcG9uZW50V2lsbE1vdW50JiZnLlVOU0FGRV9jb21wb25lbnRXaWxsTW91bnQoKSksXCJmdW5jdGlvblwiPT09XG50eXBlb2YgZy5jb21wb25lbnREaWRNb3VudCYmKGIuZmxhZ3N8PTQpKTooXCJmdW5jdGlvblwiPT09dHlwZW9mIGcuY29tcG9uZW50RGlkTW91bnQmJihiLmZsYWdzfD00KSxiLm1lbW9pemVkUHJvcHM9ZCxiLm1lbW9pemVkU3RhdGU9ayksZy5wcm9wcz1kLGcuc3RhdGU9ayxnLmNvbnRleHQ9bCxkPWgpOihcImZ1bmN0aW9uXCI9PT10eXBlb2YgZy5jb21wb25lbnREaWRNb3VudCYmKGIuZmxhZ3N8PTQpLGQ9ITEpfWVsc2V7Zz1iLnN0YXRlTm9kZTt5ZyhhLGIpO2g9Yi5tZW1vaXplZFByb3BzO2w9Yi50eXBlPT09Yi5lbGVtZW50VHlwZT9oOmxnKGIudHlwZSxoKTtnLnByb3BzPWw7QT1iLnBlbmRpbmdQcm9wcztwPWcuY29udGV4dDtrPWMuY29udGV4dFR5cGU7XCJvYmplY3RcIj09PXR5cGVvZiBrJiZudWxsIT09az9rPXZnKGspOihrPUZmKGMpP0RmOk0uY3VycmVudCxrPUVmKGIsaykpO3ZhciBDPWMuZ2V0RGVyaXZlZFN0YXRlRnJvbVByb3BzOyhuPVwiZnVuY3Rpb25cIj09PXR5cGVvZiBDfHxcblwiZnVuY3Rpb25cIj09PXR5cGVvZiBnLmdldFNuYXBzaG90QmVmb3JlVXBkYXRlKXx8XCJmdW5jdGlvblwiIT09dHlwZW9mIGcuVU5TQUZFX2NvbXBvbmVudFdpbGxSZWNlaXZlUHJvcHMmJlwiZnVuY3Rpb25cIiE9PXR5cGVvZiBnLmNvbXBvbmVudFdpbGxSZWNlaXZlUHJvcHN8fChoIT09QXx8cCE9PWspJiZOZyhiLGcsZCxrKTt3Zz0hMTtwPWIubWVtb2l6ZWRTdGF0ZTtnLnN0YXRlPXA7Q2coYixkLGcsZSk7dmFyIHg9Yi5tZW1vaXplZFN0YXRlO2ghPT1BfHxwIT09eHx8Ti5jdXJyZW50fHx3Zz8oXCJmdW5jdGlvblwiPT09dHlwZW9mIEMmJihHZyhiLGMsQyxkKSx4PWIubWVtb2l6ZWRTdGF0ZSksKGw9d2d8fExnKGIsYyxsLGQscCx4LGspKT8obnx8XCJmdW5jdGlvblwiIT09dHlwZW9mIGcuVU5TQUZFX2NvbXBvbmVudFdpbGxVcGRhdGUmJlwiZnVuY3Rpb25cIiE9PXR5cGVvZiBnLmNvbXBvbmVudFdpbGxVcGRhdGV8fChcImZ1bmN0aW9uXCI9PT10eXBlb2YgZy5jb21wb25lbnRXaWxsVXBkYXRlJiZnLmNvbXBvbmVudFdpbGxVcGRhdGUoZCxcbngsayksXCJmdW5jdGlvblwiPT09dHlwZW9mIGcuVU5TQUZFX2NvbXBvbmVudFdpbGxVcGRhdGUmJmcuVU5TQUZFX2NvbXBvbmVudFdpbGxVcGRhdGUoZCx4LGspKSxcImZ1bmN0aW9uXCI9PT10eXBlb2YgZy5jb21wb25lbnREaWRVcGRhdGUmJihiLmZsYWdzfD00KSxcImZ1bmN0aW9uXCI9PT10eXBlb2YgZy5nZXRTbmFwc2hvdEJlZm9yZVVwZGF0ZSYmKGIuZmxhZ3N8PTI1NikpOihcImZ1bmN0aW9uXCIhPT10eXBlb2YgZy5jb21wb25lbnREaWRVcGRhdGV8fGg9PT1hLm1lbW9pemVkUHJvcHMmJnA9PT1hLm1lbW9pemVkU3RhdGV8fChiLmZsYWdzfD00KSxcImZ1bmN0aW9uXCIhPT10eXBlb2YgZy5nZXRTbmFwc2hvdEJlZm9yZVVwZGF0ZXx8aD09PWEubWVtb2l6ZWRQcm9wcyYmcD09PWEubWVtb2l6ZWRTdGF0ZXx8KGIuZmxhZ3N8PTI1NiksYi5tZW1vaXplZFByb3BzPWQsYi5tZW1vaXplZFN0YXRlPXgpLGcucHJvcHM9ZCxnLnN0YXRlPXgsZy5jb250ZXh0PWssZD1sKTooXCJmdW5jdGlvblwiIT09dHlwZW9mIGcuY29tcG9uZW50RGlkVXBkYXRlfHxcbmg9PT1hLm1lbW9pemVkUHJvcHMmJnA9PT1hLm1lbW9pemVkU3RhdGV8fChiLmZsYWdzfD00KSxcImZ1bmN0aW9uXCIhPT10eXBlb2YgZy5nZXRTbmFwc2hvdEJlZm9yZVVwZGF0ZXx8aD09PWEubWVtb2l6ZWRQcm9wcyYmcD09PWEubWVtb2l6ZWRTdGF0ZXx8KGIuZmxhZ3N8PTI1NiksZD0hMSl9cmV0dXJuIHFpKGEsYixjLGQsZixlKX1cbmZ1bmN0aW9uIHFpKGEsYixjLGQsZSxmKXtvaShhLGIpO3ZhciBnPTAhPT0oYi5mbGFncyY2NCk7aWYoIWQmJiFnKXJldHVybiBlJiZLZihiLGMsITEpLGhpKGEsYixmKTtkPWIuc3RhdGVOb2RlO2VpLmN1cnJlbnQ9Yjt2YXIgaD1nJiZcImZ1bmN0aW9uXCIhPT10eXBlb2YgYy5nZXREZXJpdmVkU3RhdGVGcm9tRXJyb3I/bnVsbDpkLnJlbmRlcigpO2IuZmxhZ3N8PTE7bnVsbCE9PWEmJmc/KGIuY2hpbGQ9WWcoYixhLmNoaWxkLG51bGwsZiksYi5jaGlsZD1ZZyhiLG51bGwsaCxmKSk6ZmkoYSxiLGgsZik7Yi5tZW1vaXplZFN0YXRlPWQuc3RhdGU7ZSYmS2YoYixjLCEwKTtyZXR1cm4gYi5jaGlsZH1mdW5jdGlvbiByaShhKXt2YXIgYj1hLnN0YXRlTm9kZTtiLnBlbmRpbmdDb250ZXh0P0hmKGEsYi5wZW5kaW5nQ29udGV4dCxiLnBlbmRpbmdDb250ZXh0IT09Yi5jb250ZXh0KTpiLmNvbnRleHQmJkhmKGEsYi5jb250ZXh0LCExKTtlaChhLGIuY29udGFpbmVySW5mbyl9XG52YXIgc2k9e2RlaHlkcmF0ZWQ6bnVsbCxyZXRyeUxhbmU6MH07XG5mdW5jdGlvbiB0aShhLGIsYyl7dmFyIGQ9Yi5wZW5kaW5nUHJvcHMsZT1QLmN1cnJlbnQsZj0hMSxnOyhnPTAhPT0oYi5mbGFncyY2NCkpfHwoZz1udWxsIT09YSYmbnVsbD09PWEubWVtb2l6ZWRTdGF0ZT8hMTowIT09KGUmMikpO2c/KGY9ITAsYi5mbGFncyY9LTY1KTpudWxsIT09YSYmbnVsbD09PWEubWVtb2l6ZWRTdGF0ZXx8dm9pZCAwPT09ZC5mYWxsYmFja3x8ITA9PT1kLnVuc3RhYmxlX2F2b2lkVGhpc0ZhbGxiYWNrfHwoZXw9MSk7SShQLGUmMSk7aWYobnVsbD09PWEpe3ZvaWQgMCE9PWQuZmFsbGJhY2smJnBoKGIpO2E9ZC5jaGlsZHJlbjtlPWQuZmFsbGJhY2s7aWYoZilyZXR1cm4gYT11aShiLGEsZSxjKSxiLmNoaWxkLm1lbW9pemVkU3RhdGU9e2Jhc2VMYW5lczpjfSxiLm1lbW9pemVkU3RhdGU9c2ksYTtpZihcIm51bWJlclwiPT09dHlwZW9mIGQudW5zdGFibGVfZXhwZWN0ZWRMb2FkVGltZSlyZXR1cm4gYT11aShiLGEsZSxjKSxiLmNoaWxkLm1lbW9pemVkU3RhdGU9e2Jhc2VMYW5lczpjfSxcbmIubWVtb2l6ZWRTdGF0ZT1zaSxiLmxhbmVzPTMzNTU0NDMyLGE7Yz12aSh7bW9kZTpcInZpc2libGVcIixjaGlsZHJlbjphfSxiLm1vZGUsYyxudWxsKTtjLnJldHVybj1iO3JldHVybiBiLmNoaWxkPWN9aWYobnVsbCE9PWEubWVtb2l6ZWRTdGF0ZSl7aWYoZilyZXR1cm4gZD13aShhLGIsZC5jaGlsZHJlbixkLmZhbGxiYWNrLGMpLGY9Yi5jaGlsZCxlPWEuY2hpbGQubWVtb2l6ZWRTdGF0ZSxmLm1lbW9pemVkU3RhdGU9bnVsbD09PWU/e2Jhc2VMYW5lczpjfTp7YmFzZUxhbmVzOmUuYmFzZUxhbmVzfGN9LGYuY2hpbGRMYW5lcz1hLmNoaWxkTGFuZXMmfmMsYi5tZW1vaXplZFN0YXRlPXNpLGQ7Yz14aShhLGIsZC5jaGlsZHJlbixjKTtiLm1lbW9pemVkU3RhdGU9bnVsbDtyZXR1cm4gY31pZihmKXJldHVybiBkPXdpKGEsYixkLmNoaWxkcmVuLGQuZmFsbGJhY2ssYyksZj1iLmNoaWxkLGU9YS5jaGlsZC5tZW1vaXplZFN0YXRlLGYubWVtb2l6ZWRTdGF0ZT1udWxsPT09ZT97YmFzZUxhbmVzOmN9Olxue2Jhc2VMYW5lczplLmJhc2VMYW5lc3xjfSxmLmNoaWxkTGFuZXM9YS5jaGlsZExhbmVzJn5jLGIubWVtb2l6ZWRTdGF0ZT1zaSxkO2M9eGkoYSxiLGQuY2hpbGRyZW4sYyk7Yi5tZW1vaXplZFN0YXRlPW51bGw7cmV0dXJuIGN9ZnVuY3Rpb24gdWkoYSxiLGMsZCl7dmFyIGU9YS5tb2RlLGY9YS5jaGlsZDtiPXttb2RlOlwiaGlkZGVuXCIsY2hpbGRyZW46Yn07MD09PShlJjIpJiZudWxsIT09Zj8oZi5jaGlsZExhbmVzPTAsZi5wZW5kaW5nUHJvcHM9Yik6Zj12aShiLGUsMCxudWxsKTtjPVhnKGMsZSxkLG51bGwpO2YucmV0dXJuPWE7Yy5yZXR1cm49YTtmLnNpYmxpbmc9YzthLmNoaWxkPWY7cmV0dXJuIGN9XG5mdW5jdGlvbiB4aShhLGIsYyxkKXt2YXIgZT1hLmNoaWxkO2E9ZS5zaWJsaW5nO2M9VGcoZSx7bW9kZTpcInZpc2libGVcIixjaGlsZHJlbjpjfSk7MD09PShiLm1vZGUmMikmJihjLmxhbmVzPWQpO2MucmV0dXJuPWI7Yy5zaWJsaW5nPW51bGw7bnVsbCE9PWEmJihhLm5leHRFZmZlY3Q9bnVsbCxhLmZsYWdzPTgsYi5maXJzdEVmZmVjdD1iLmxhc3RFZmZlY3Q9YSk7cmV0dXJuIGIuY2hpbGQ9Y31cbmZ1bmN0aW9uIHdpKGEsYixjLGQsZSl7dmFyIGY9Yi5tb2RlLGc9YS5jaGlsZDthPWcuc2libGluZzt2YXIgaD17bW9kZTpcImhpZGRlblwiLGNoaWxkcmVuOmN9OzA9PT0oZiYyKSYmYi5jaGlsZCE9PWc/KGM9Yi5jaGlsZCxjLmNoaWxkTGFuZXM9MCxjLnBlbmRpbmdQcm9wcz1oLGc9Yy5sYXN0RWZmZWN0LG51bGwhPT1nPyhiLmZpcnN0RWZmZWN0PWMuZmlyc3RFZmZlY3QsYi5sYXN0RWZmZWN0PWcsZy5uZXh0RWZmZWN0PW51bGwpOmIuZmlyc3RFZmZlY3Q9Yi5sYXN0RWZmZWN0PW51bGwpOmM9VGcoZyxoKTtudWxsIT09YT9kPVRnKGEsZCk6KGQ9WGcoZCxmLGUsbnVsbCksZC5mbGFnc3w9Mik7ZC5yZXR1cm49YjtjLnJldHVybj1iO2Muc2libGluZz1kO2IuY2hpbGQ9YztyZXR1cm4gZH1mdW5jdGlvbiB5aShhLGIpe2EubGFuZXN8PWI7dmFyIGM9YS5hbHRlcm5hdGU7bnVsbCE9PWMmJihjLmxhbmVzfD1iKTtzZyhhLnJldHVybixiKX1cbmZ1bmN0aW9uIHppKGEsYixjLGQsZSxmKXt2YXIgZz1hLm1lbW9pemVkU3RhdGU7bnVsbD09PWc/YS5tZW1vaXplZFN0YXRlPXtpc0JhY2t3YXJkczpiLHJlbmRlcmluZzpudWxsLHJlbmRlcmluZ1N0YXJ0VGltZTowLGxhc3Q6ZCx0YWlsOmMsdGFpbE1vZGU6ZSxsYXN0RWZmZWN0OmZ9OihnLmlzQmFja3dhcmRzPWIsZy5yZW5kZXJpbmc9bnVsbCxnLnJlbmRlcmluZ1N0YXJ0VGltZT0wLGcubGFzdD1kLGcudGFpbD1jLGcudGFpbE1vZGU9ZSxnLmxhc3RFZmZlY3Q9Zil9XG5mdW5jdGlvbiBBaShhLGIsYyl7dmFyIGQ9Yi5wZW5kaW5nUHJvcHMsZT1kLnJldmVhbE9yZGVyLGY9ZC50YWlsO2ZpKGEsYixkLmNoaWxkcmVuLGMpO2Q9UC5jdXJyZW50O2lmKDAhPT0oZCYyKSlkPWQmMXwyLGIuZmxhZ3N8PTY0O2Vsc2V7aWYobnVsbCE9PWEmJjAhPT0oYS5mbGFncyY2NCkpYTpmb3IoYT1iLmNoaWxkO251bGwhPT1hOyl7aWYoMTM9PT1hLnRhZyludWxsIT09YS5tZW1vaXplZFN0YXRlJiZ5aShhLGMpO2Vsc2UgaWYoMTk9PT1hLnRhZyl5aShhLGMpO2Vsc2UgaWYobnVsbCE9PWEuY2hpbGQpe2EuY2hpbGQucmV0dXJuPWE7YT1hLmNoaWxkO2NvbnRpbnVlfWlmKGE9PT1iKWJyZWFrIGE7Zm9yKDtudWxsPT09YS5zaWJsaW5nOyl7aWYobnVsbD09PWEucmV0dXJufHxhLnJldHVybj09PWIpYnJlYWsgYTthPWEucmV0dXJufWEuc2libGluZy5yZXR1cm49YS5yZXR1cm47YT1hLnNpYmxpbmd9ZCY9MX1JKFAsZCk7aWYoMD09PShiLm1vZGUmMikpYi5tZW1vaXplZFN0YXRlPVxubnVsbDtlbHNlIHN3aXRjaChlKXtjYXNlIFwiZm9yd2FyZHNcIjpjPWIuY2hpbGQ7Zm9yKGU9bnVsbDtudWxsIT09YzspYT1jLmFsdGVybmF0ZSxudWxsIT09YSYmbnVsbD09PWloKGEpJiYoZT1jKSxjPWMuc2libGluZztjPWU7bnVsbD09PWM/KGU9Yi5jaGlsZCxiLmNoaWxkPW51bGwpOihlPWMuc2libGluZyxjLnNpYmxpbmc9bnVsbCk7emkoYiwhMSxlLGMsZixiLmxhc3RFZmZlY3QpO2JyZWFrO2Nhc2UgXCJiYWNrd2FyZHNcIjpjPW51bGw7ZT1iLmNoaWxkO2ZvcihiLmNoaWxkPW51bGw7bnVsbCE9PWU7KXthPWUuYWx0ZXJuYXRlO2lmKG51bGwhPT1hJiZudWxsPT09aWgoYSkpe2IuY2hpbGQ9ZTticmVha31hPWUuc2libGluZztlLnNpYmxpbmc9YztjPWU7ZT1hfXppKGIsITAsYyxudWxsLGYsYi5sYXN0RWZmZWN0KTticmVhaztjYXNlIFwidG9nZXRoZXJcIjp6aShiLCExLG51bGwsbnVsbCx2b2lkIDAsYi5sYXN0RWZmZWN0KTticmVhaztkZWZhdWx0OmIubWVtb2l6ZWRTdGF0ZT1udWxsfXJldHVybiBiLmNoaWxkfVxuZnVuY3Rpb24gaGkoYSxiLGMpe251bGwhPT1hJiYoYi5kZXBlbmRlbmNpZXM9YS5kZXBlbmRlbmNpZXMpO0RnfD1iLmxhbmVzO2lmKDAhPT0oYyZiLmNoaWxkTGFuZXMpKXtpZihudWxsIT09YSYmYi5jaGlsZCE9PWEuY2hpbGQpdGhyb3cgRXJyb3IoeSgxNTMpKTtpZihudWxsIT09Yi5jaGlsZCl7YT1iLmNoaWxkO2M9VGcoYSxhLnBlbmRpbmdQcm9wcyk7Yi5jaGlsZD1jO2ZvcihjLnJldHVybj1iO251bGwhPT1hLnNpYmxpbmc7KWE9YS5zaWJsaW5nLGM9Yy5zaWJsaW5nPVRnKGEsYS5wZW5kaW5nUHJvcHMpLGMucmV0dXJuPWI7Yy5zaWJsaW5nPW51bGx9cmV0dXJuIGIuY2hpbGR9cmV0dXJuIG51bGx9dmFyIEJpLENpLERpLEVpO1xuQmk9ZnVuY3Rpb24oYSxiKXtmb3IodmFyIGM9Yi5jaGlsZDtudWxsIT09Yzspe2lmKDU9PT1jLnRhZ3x8Nj09PWMudGFnKWEuYXBwZW5kQ2hpbGQoYy5zdGF0ZU5vZGUpO2Vsc2UgaWYoNCE9PWMudGFnJiZudWxsIT09Yy5jaGlsZCl7Yy5jaGlsZC5yZXR1cm49YztjPWMuY2hpbGQ7Y29udGludWV9aWYoYz09PWIpYnJlYWs7Zm9yKDtudWxsPT09Yy5zaWJsaW5nOyl7aWYobnVsbD09PWMucmV0dXJufHxjLnJldHVybj09PWIpcmV0dXJuO2M9Yy5yZXR1cm59Yy5zaWJsaW5nLnJldHVybj1jLnJldHVybjtjPWMuc2libGluZ319O0NpPWZ1bmN0aW9uKCl7fTtcbkRpPWZ1bmN0aW9uKGEsYixjLGQpe3ZhciBlPWEubWVtb2l6ZWRQcm9wcztpZihlIT09ZCl7YT1iLnN0YXRlTm9kZTtkaChhaC5jdXJyZW50KTt2YXIgZj1udWxsO3N3aXRjaChjKXtjYXNlIFwiaW5wdXRcIjplPVlhKGEsZSk7ZD1ZYShhLGQpO2Y9W107YnJlYWs7Y2FzZSBcIm9wdGlvblwiOmU9ZWIoYSxlKTtkPWViKGEsZCk7Zj1bXTticmVhaztjYXNlIFwic2VsZWN0XCI6ZT1tKHt9LGUse3ZhbHVlOnZvaWQgMH0pO2Q9bSh7fSxkLHt2YWx1ZTp2b2lkIDB9KTtmPVtdO2JyZWFrO2Nhc2UgXCJ0ZXh0YXJlYVwiOmU9Z2IoYSxlKTtkPWdiKGEsZCk7Zj1bXTticmVhaztkZWZhdWx0OlwiZnVuY3Rpb25cIiE9PXR5cGVvZiBlLm9uQ2xpY2smJlwiZnVuY3Rpb25cIj09PXR5cGVvZiBkLm9uQ2xpY2smJihhLm9uY2xpY2s9amYpfXZiKGMsZCk7dmFyIGc7Yz1udWxsO2ZvcihsIGluIGUpaWYoIWQuaGFzT3duUHJvcGVydHkobCkmJmUuaGFzT3duUHJvcGVydHkobCkmJm51bGwhPWVbbF0paWYoXCJzdHlsZVwiPT09XG5sKXt2YXIgaD1lW2xdO2ZvcihnIGluIGgpaC5oYXNPd25Qcm9wZXJ0eShnKSYmKGN8fChjPXt9KSxjW2ddPVwiXCIpfWVsc2VcImRhbmdlcm91c2x5U2V0SW5uZXJIVE1MXCIhPT1sJiZcImNoaWxkcmVuXCIhPT1sJiZcInN1cHByZXNzQ29udGVudEVkaXRhYmxlV2FybmluZ1wiIT09bCYmXCJzdXBwcmVzc0h5ZHJhdGlvbldhcm5pbmdcIiE9PWwmJlwiYXV0b0ZvY3VzXCIhPT1sJiYoY2EuaGFzT3duUHJvcGVydHkobCk/Znx8KGY9W10pOihmPWZ8fFtdKS5wdXNoKGwsbnVsbCkpO2ZvcihsIGluIGQpe3ZhciBrPWRbbF07aD1udWxsIT1lP2VbbF06dm9pZCAwO2lmKGQuaGFzT3duUHJvcGVydHkobCkmJmshPT1oJiYobnVsbCE9a3x8bnVsbCE9aCkpaWYoXCJzdHlsZVwiPT09bClpZihoKXtmb3IoZyBpbiBoKSFoLmhhc093blByb3BlcnR5KGcpfHxrJiZrLmhhc093blByb3BlcnR5KGcpfHwoY3x8KGM9e30pLGNbZ109XCJcIik7Zm9yKGcgaW4gaylrLmhhc093blByb3BlcnR5KGcpJiZoW2ddIT09a1tnXSYmKGN8fFxuKGM9e30pLGNbZ109a1tnXSl9ZWxzZSBjfHwoZnx8KGY9W10pLGYucHVzaChsLGMpKSxjPWs7ZWxzZVwiZGFuZ2Vyb3VzbHlTZXRJbm5lckhUTUxcIj09PWw/KGs9az9rLl9faHRtbDp2b2lkIDAsaD1oP2guX19odG1sOnZvaWQgMCxudWxsIT1rJiZoIT09ayYmKGY9Znx8W10pLnB1c2gobCxrKSk6XCJjaGlsZHJlblwiPT09bD9cInN0cmluZ1wiIT09dHlwZW9mIGsmJlwibnVtYmVyXCIhPT10eXBlb2Yga3x8KGY9Znx8W10pLnB1c2gobCxcIlwiK2spOlwic3VwcHJlc3NDb250ZW50RWRpdGFibGVXYXJuaW5nXCIhPT1sJiZcInN1cHByZXNzSHlkcmF0aW9uV2FybmluZ1wiIT09bCYmKGNhLmhhc093blByb3BlcnR5KGwpPyhudWxsIT1rJiZcIm9uU2Nyb2xsXCI9PT1sJiZHKFwic2Nyb2xsXCIsYSksZnx8aD09PWt8fChmPVtdKSk6XCJvYmplY3RcIj09PXR5cGVvZiBrJiZudWxsIT09ayYmay4kJHR5cGVvZj09PUdhP2sudG9TdHJpbmcoKTooZj1mfHxbXSkucHVzaChsLGspKX1jJiYoZj1mfHxbXSkucHVzaChcInN0eWxlXCIsXG5jKTt2YXIgbD1mO2lmKGIudXBkYXRlUXVldWU9bCliLmZsYWdzfD00fX07RWk9ZnVuY3Rpb24oYSxiLGMsZCl7YyE9PWQmJihiLmZsYWdzfD00KX07ZnVuY3Rpb24gRmkoYSxiKXtpZighbGgpc3dpdGNoKGEudGFpbE1vZGUpe2Nhc2UgXCJoaWRkZW5cIjpiPWEudGFpbDtmb3IodmFyIGM9bnVsbDtudWxsIT09YjspbnVsbCE9PWIuYWx0ZXJuYXRlJiYoYz1iKSxiPWIuc2libGluZztudWxsPT09Yz9hLnRhaWw9bnVsbDpjLnNpYmxpbmc9bnVsbDticmVhaztjYXNlIFwiY29sbGFwc2VkXCI6Yz1hLnRhaWw7Zm9yKHZhciBkPW51bGw7bnVsbCE9PWM7KW51bGwhPT1jLmFsdGVybmF0ZSYmKGQ9YyksYz1jLnNpYmxpbmc7bnVsbD09PWQ/Ynx8bnVsbD09PWEudGFpbD9hLnRhaWw9bnVsbDphLnRhaWwuc2libGluZz1udWxsOmQuc2libGluZz1udWxsfX1cbmZ1bmN0aW9uIEdpKGEsYixjKXt2YXIgZD1iLnBlbmRpbmdQcm9wcztzd2l0Y2goYi50YWcpe2Nhc2UgMjpjYXNlIDE2OmNhc2UgMTU6Y2FzZSAwOmNhc2UgMTE6Y2FzZSA3OmNhc2UgODpjYXNlIDEyOmNhc2UgOTpjYXNlIDE0OnJldHVybiBudWxsO2Nhc2UgMTpyZXR1cm4gRmYoYi50eXBlKSYmR2YoKSxudWxsO2Nhc2UgMzpmaCgpO0goTik7SChNKTt1aCgpO2Q9Yi5zdGF0ZU5vZGU7ZC5wZW5kaW5nQ29udGV4dCYmKGQuY29udGV4dD1kLnBlbmRpbmdDb250ZXh0LGQucGVuZGluZ0NvbnRleHQ9bnVsbCk7aWYobnVsbD09PWF8fG51bGw9PT1hLmNoaWxkKXJoKGIpP2IuZmxhZ3N8PTQ6ZC5oeWRyYXRlfHwoYi5mbGFnc3w9MjU2KTtDaShiKTtyZXR1cm4gbnVsbDtjYXNlIDU6aGgoYik7dmFyIGU9ZGgoY2guY3VycmVudCk7Yz1iLnR5cGU7aWYobnVsbCE9PWEmJm51bGwhPWIuc3RhdGVOb2RlKURpKGEsYixjLGQsZSksYS5yZWYhPT1iLnJlZiYmKGIuZmxhZ3N8PTEyOCk7ZWxzZXtpZighZCl7aWYobnVsbD09PVxuYi5zdGF0ZU5vZGUpdGhyb3cgRXJyb3IoeSgxNjYpKTtyZXR1cm4gbnVsbH1hPWRoKGFoLmN1cnJlbnQpO2lmKHJoKGIpKXtkPWIuc3RhdGVOb2RlO2M9Yi50eXBlO3ZhciBmPWIubWVtb2l6ZWRQcm9wcztkW3dmXT1iO2RbeGZdPWY7c3dpdGNoKGMpe2Nhc2UgXCJkaWFsb2dcIjpHKFwiY2FuY2VsXCIsZCk7RyhcImNsb3NlXCIsZCk7YnJlYWs7Y2FzZSBcImlmcmFtZVwiOmNhc2UgXCJvYmplY3RcIjpjYXNlIFwiZW1iZWRcIjpHKFwibG9hZFwiLGQpO2JyZWFrO2Nhc2UgXCJ2aWRlb1wiOmNhc2UgXCJhdWRpb1wiOmZvcihhPTA7YTxYZS5sZW5ndGg7YSsrKUcoWGVbYV0sZCk7YnJlYWs7Y2FzZSBcInNvdXJjZVwiOkcoXCJlcnJvclwiLGQpO2JyZWFrO2Nhc2UgXCJpbWdcIjpjYXNlIFwiaW1hZ2VcIjpjYXNlIFwibGlua1wiOkcoXCJlcnJvclwiLGQpO0coXCJsb2FkXCIsZCk7YnJlYWs7Y2FzZSBcImRldGFpbHNcIjpHKFwidG9nZ2xlXCIsZCk7YnJlYWs7Y2FzZSBcImlucHV0XCI6WmEoZCxmKTtHKFwiaW52YWxpZFwiLGQpO2JyZWFrO2Nhc2UgXCJzZWxlY3RcIjpkLl93cmFwcGVyU3RhdGU9XG57d2FzTXVsdGlwbGU6ISFmLm11bHRpcGxlfTtHKFwiaW52YWxpZFwiLGQpO2JyZWFrO2Nhc2UgXCJ0ZXh0YXJlYVwiOmhiKGQsZiksRyhcImludmFsaWRcIixkKX12YihjLGYpO2E9bnVsbDtmb3IodmFyIGcgaW4gZilmLmhhc093blByb3BlcnR5KGcpJiYoZT1mW2ddLFwiY2hpbGRyZW5cIj09PWc/XCJzdHJpbmdcIj09PXR5cGVvZiBlP2QudGV4dENvbnRlbnQhPT1lJiYoYT1bXCJjaGlsZHJlblwiLGVdKTpcIm51bWJlclwiPT09dHlwZW9mIGUmJmQudGV4dENvbnRlbnQhPT1cIlwiK2UmJihhPVtcImNoaWxkcmVuXCIsXCJcIitlXSk6Y2EuaGFzT3duUHJvcGVydHkoZykmJm51bGwhPWUmJlwib25TY3JvbGxcIj09PWcmJkcoXCJzY3JvbGxcIixkKSk7c3dpdGNoKGMpe2Nhc2UgXCJpbnB1dFwiOlZhKGQpO2NiKGQsZiwhMCk7YnJlYWs7Y2FzZSBcInRleHRhcmVhXCI6VmEoZCk7amIoZCk7YnJlYWs7Y2FzZSBcInNlbGVjdFwiOmNhc2UgXCJvcHRpb25cIjpicmVhaztkZWZhdWx0OlwiZnVuY3Rpb25cIj09PXR5cGVvZiBmLm9uQ2xpY2smJihkLm9uY2xpY2s9XG5qZil9ZD1hO2IudXBkYXRlUXVldWU9ZDtudWxsIT09ZCYmKGIuZmxhZ3N8PTQpfWVsc2V7Zz05PT09ZS5ub2RlVHlwZT9lOmUub3duZXJEb2N1bWVudDthPT09a2IuaHRtbCYmKGE9bGIoYykpO2E9PT1rYi5odG1sP1wic2NyaXB0XCI9PT1jPyhhPWcuY3JlYXRlRWxlbWVudChcImRpdlwiKSxhLmlubmVySFRNTD1cIjxzY3JpcHQ+XFx4M2Mvc2NyaXB0PlwiLGE9YS5yZW1vdmVDaGlsZChhLmZpcnN0Q2hpbGQpKTpcInN0cmluZ1wiPT09dHlwZW9mIGQuaXM/YT1nLmNyZWF0ZUVsZW1lbnQoYyx7aXM6ZC5pc30pOihhPWcuY3JlYXRlRWxlbWVudChjKSxcInNlbGVjdFwiPT09YyYmKGc9YSxkLm11bHRpcGxlP2cubXVsdGlwbGU9ITA6ZC5zaXplJiYoZy5zaXplPWQuc2l6ZSkpKTphPWcuY3JlYXRlRWxlbWVudE5TKGEsYyk7YVt3Zl09YjthW3hmXT1kO0JpKGEsYiwhMSwhMSk7Yi5zdGF0ZU5vZGU9YTtnPXdiKGMsZCk7c3dpdGNoKGMpe2Nhc2UgXCJkaWFsb2dcIjpHKFwiY2FuY2VsXCIsYSk7RyhcImNsb3NlXCIsYSk7XG5lPWQ7YnJlYWs7Y2FzZSBcImlmcmFtZVwiOmNhc2UgXCJvYmplY3RcIjpjYXNlIFwiZW1iZWRcIjpHKFwibG9hZFwiLGEpO2U9ZDticmVhaztjYXNlIFwidmlkZW9cIjpjYXNlIFwiYXVkaW9cIjpmb3IoZT0wO2U8WGUubGVuZ3RoO2UrKylHKFhlW2VdLGEpO2U9ZDticmVhaztjYXNlIFwic291cmNlXCI6RyhcImVycm9yXCIsYSk7ZT1kO2JyZWFrO2Nhc2UgXCJpbWdcIjpjYXNlIFwiaW1hZ2VcIjpjYXNlIFwibGlua1wiOkcoXCJlcnJvclwiLGEpO0coXCJsb2FkXCIsYSk7ZT1kO2JyZWFrO2Nhc2UgXCJkZXRhaWxzXCI6RyhcInRvZ2dsZVwiLGEpO2U9ZDticmVhaztjYXNlIFwiaW5wdXRcIjpaYShhLGQpO2U9WWEoYSxkKTtHKFwiaW52YWxpZFwiLGEpO2JyZWFrO2Nhc2UgXCJvcHRpb25cIjplPWViKGEsZCk7YnJlYWs7Y2FzZSBcInNlbGVjdFwiOmEuX3dyYXBwZXJTdGF0ZT17d2FzTXVsdGlwbGU6ISFkLm11bHRpcGxlfTtlPW0oe30sZCx7dmFsdWU6dm9pZCAwfSk7RyhcImludmFsaWRcIixhKTticmVhaztjYXNlIFwidGV4dGFyZWFcIjpoYihhLGQpO2U9XG5nYihhLGQpO0coXCJpbnZhbGlkXCIsYSk7YnJlYWs7ZGVmYXVsdDplPWR9dmIoYyxlKTt2YXIgaD1lO2ZvcihmIGluIGgpaWYoaC5oYXNPd25Qcm9wZXJ0eShmKSl7dmFyIGs9aFtmXTtcInN0eWxlXCI9PT1mP3RiKGEsayk6XCJkYW5nZXJvdXNseVNldElubmVySFRNTFwiPT09Zj8oaz1rP2suX19odG1sOnZvaWQgMCxudWxsIT1rJiZvYihhLGspKTpcImNoaWxkcmVuXCI9PT1mP1wic3RyaW5nXCI9PT10eXBlb2Ygaz8oXCJ0ZXh0YXJlYVwiIT09Y3x8XCJcIiE9PWspJiZwYihhLGspOlwibnVtYmVyXCI9PT10eXBlb2YgayYmcGIoYSxcIlwiK2spOlwic3VwcHJlc3NDb250ZW50RWRpdGFibGVXYXJuaW5nXCIhPT1mJiZcInN1cHByZXNzSHlkcmF0aW9uV2FybmluZ1wiIT09ZiYmXCJhdXRvRm9jdXNcIiE9PWYmJihjYS5oYXNPd25Qcm9wZXJ0eShmKT9udWxsIT1rJiZcIm9uU2Nyb2xsXCI9PT1mJiZHKFwic2Nyb2xsXCIsYSk6bnVsbCE9ayYmcWEoYSxmLGssZykpfXN3aXRjaChjKXtjYXNlIFwiaW5wdXRcIjpWYShhKTtjYihhLGQsITEpO1xuYnJlYWs7Y2FzZSBcInRleHRhcmVhXCI6VmEoYSk7amIoYSk7YnJlYWs7Y2FzZSBcIm9wdGlvblwiOm51bGwhPWQudmFsdWUmJmEuc2V0QXR0cmlidXRlKFwidmFsdWVcIixcIlwiK1NhKGQudmFsdWUpKTticmVhaztjYXNlIFwic2VsZWN0XCI6YS5tdWx0aXBsZT0hIWQubXVsdGlwbGU7Zj1kLnZhbHVlO251bGwhPWY/ZmIoYSwhIWQubXVsdGlwbGUsZiwhMSk6bnVsbCE9ZC5kZWZhdWx0VmFsdWUmJmZiKGEsISFkLm11bHRpcGxlLGQuZGVmYXVsdFZhbHVlLCEwKTticmVhaztkZWZhdWx0OlwiZnVuY3Rpb25cIj09PXR5cGVvZiBlLm9uQ2xpY2smJihhLm9uY2xpY2s9amYpfW1mKGMsZCkmJihiLmZsYWdzfD00KX1udWxsIT09Yi5yZWYmJihiLmZsYWdzfD0xMjgpfXJldHVybiBudWxsO2Nhc2UgNjppZihhJiZudWxsIT1iLnN0YXRlTm9kZSlFaShhLGIsYS5tZW1vaXplZFByb3BzLGQpO2Vsc2V7aWYoXCJzdHJpbmdcIiE9PXR5cGVvZiBkJiZudWxsPT09Yi5zdGF0ZU5vZGUpdGhyb3cgRXJyb3IoeSgxNjYpKTtcbmM9ZGgoY2guY3VycmVudCk7ZGgoYWguY3VycmVudCk7cmgoYik/KGQ9Yi5zdGF0ZU5vZGUsYz1iLm1lbW9pemVkUHJvcHMsZFt3Zl09YixkLm5vZGVWYWx1ZSE9PWMmJihiLmZsYWdzfD00KSk6KGQ9KDk9PT1jLm5vZGVUeXBlP2M6Yy5vd25lckRvY3VtZW50KS5jcmVhdGVUZXh0Tm9kZShkKSxkW3dmXT1iLGIuc3RhdGVOb2RlPWQpfXJldHVybiBudWxsO2Nhc2UgMTM6SChQKTtkPWIubWVtb2l6ZWRTdGF0ZTtpZigwIT09KGIuZmxhZ3MmNjQpKXJldHVybiBiLmxhbmVzPWMsYjtkPW51bGwhPT1kO2M9ITE7bnVsbD09PWE/dm9pZCAwIT09Yi5tZW1vaXplZFByb3BzLmZhbGxiYWNrJiZyaChiKTpjPW51bGwhPT1hLm1lbW9pemVkU3RhdGU7aWYoZCYmIWMmJjAhPT0oYi5tb2RlJjIpKWlmKG51bGw9PT1hJiYhMCE9PWIubWVtb2l6ZWRQcm9wcy51bnN0YWJsZV9hdm9pZFRoaXNGYWxsYmFja3x8MCE9PShQLmN1cnJlbnQmMSkpMD09PVYmJihWPTMpO2Vsc2V7aWYoMD09PVZ8fDM9PT1WKVY9XG40O251bGw9PT1VfHwwPT09KERnJjEzNDIxNzcyNykmJjA9PT0oSGkmMTM0MjE3NzI3KXx8SWkoVSxXKX1pZihkfHxjKWIuZmxhZ3N8PTQ7cmV0dXJuIG51bGw7Y2FzZSA0OnJldHVybiBmaCgpLENpKGIpLG51bGw9PT1hJiZjZihiLnN0YXRlTm9kZS5jb250YWluZXJJbmZvKSxudWxsO2Nhc2UgMTA6cmV0dXJuIHJnKGIpLG51bGw7Y2FzZSAxNzpyZXR1cm4gRmYoYi50eXBlKSYmR2YoKSxudWxsO2Nhc2UgMTk6SChQKTtkPWIubWVtb2l6ZWRTdGF0ZTtpZihudWxsPT09ZClyZXR1cm4gbnVsbDtmPTAhPT0oYi5mbGFncyY2NCk7Zz1kLnJlbmRlcmluZztpZihudWxsPT09ZylpZihmKUZpKGQsITEpO2Vsc2V7aWYoMCE9PVZ8fG51bGwhPT1hJiYwIT09KGEuZmxhZ3MmNjQpKWZvcihhPWIuY2hpbGQ7bnVsbCE9PWE7KXtnPWloKGEpO2lmKG51bGwhPT1nKXtiLmZsYWdzfD02NDtGaShkLCExKTtmPWcudXBkYXRlUXVldWU7bnVsbCE9PWYmJihiLnVwZGF0ZVF1ZXVlPWYsYi5mbGFnc3w9NCk7XG5udWxsPT09ZC5sYXN0RWZmZWN0JiYoYi5maXJzdEVmZmVjdD1udWxsKTtiLmxhc3RFZmZlY3Q9ZC5sYXN0RWZmZWN0O2Q9Yztmb3IoYz1iLmNoaWxkO251bGwhPT1jOylmPWMsYT1kLGYuZmxhZ3MmPTIsZi5uZXh0RWZmZWN0PW51bGwsZi5maXJzdEVmZmVjdD1udWxsLGYubGFzdEVmZmVjdD1udWxsLGc9Zi5hbHRlcm5hdGUsbnVsbD09PWc/KGYuY2hpbGRMYW5lcz0wLGYubGFuZXM9YSxmLmNoaWxkPW51bGwsZi5tZW1vaXplZFByb3BzPW51bGwsZi5tZW1vaXplZFN0YXRlPW51bGwsZi51cGRhdGVRdWV1ZT1udWxsLGYuZGVwZW5kZW5jaWVzPW51bGwsZi5zdGF0ZU5vZGU9bnVsbCk6KGYuY2hpbGRMYW5lcz1nLmNoaWxkTGFuZXMsZi5sYW5lcz1nLmxhbmVzLGYuY2hpbGQ9Zy5jaGlsZCxmLm1lbW9pemVkUHJvcHM9Zy5tZW1vaXplZFByb3BzLGYubWVtb2l6ZWRTdGF0ZT1nLm1lbW9pemVkU3RhdGUsZi51cGRhdGVRdWV1ZT1nLnVwZGF0ZVF1ZXVlLGYudHlwZT1nLnR5cGUsYT1nLmRlcGVuZGVuY2llcyxcbmYuZGVwZW5kZW5jaWVzPW51bGw9PT1hP251bGw6e2xhbmVzOmEubGFuZXMsZmlyc3RDb250ZXh0OmEuZmlyc3RDb250ZXh0fSksYz1jLnNpYmxpbmc7SShQLFAuY3VycmVudCYxfDIpO3JldHVybiBiLmNoaWxkfWE9YS5zaWJsaW5nfW51bGwhPT1kLnRhaWwmJk8oKT5KaSYmKGIuZmxhZ3N8PTY0LGY9ITAsRmkoZCwhMSksYi5sYW5lcz0zMzU1NDQzMil9ZWxzZXtpZighZilpZihhPWloKGcpLG51bGwhPT1hKXtpZihiLmZsYWdzfD02NCxmPSEwLGM9YS51cGRhdGVRdWV1ZSxudWxsIT09YyYmKGIudXBkYXRlUXVldWU9YyxiLmZsYWdzfD00KSxGaShkLCEwKSxudWxsPT09ZC50YWlsJiZcImhpZGRlblwiPT09ZC50YWlsTW9kZSYmIWcuYWx0ZXJuYXRlJiYhbGgpcmV0dXJuIGI9Yi5sYXN0RWZmZWN0PWQubGFzdEVmZmVjdCxudWxsIT09YiYmKGIubmV4dEVmZmVjdD1udWxsKSxudWxsfWVsc2UgMipPKCktZC5yZW5kZXJpbmdTdGFydFRpbWU+SmkmJjEwNzM3NDE4MjQhPT1jJiYoYi5mbGFnc3w9XG42NCxmPSEwLEZpKGQsITEpLGIubGFuZXM9MzM1NTQ0MzIpO2QuaXNCYWNrd2FyZHM/KGcuc2libGluZz1iLmNoaWxkLGIuY2hpbGQ9Zyk6KGM9ZC5sYXN0LG51bGwhPT1jP2Muc2libGluZz1nOmIuY2hpbGQ9ZyxkLmxhc3Q9Zyl9cmV0dXJuIG51bGwhPT1kLnRhaWw/KGM9ZC50YWlsLGQucmVuZGVyaW5nPWMsZC50YWlsPWMuc2libGluZyxkLmxhc3RFZmZlY3Q9Yi5sYXN0RWZmZWN0LGQucmVuZGVyaW5nU3RhcnRUaW1lPU8oKSxjLnNpYmxpbmc9bnVsbCxiPVAuY3VycmVudCxJKFAsZj9iJjF8MjpiJjEpLGMpOm51bGw7Y2FzZSAyMzpjYXNlIDI0OnJldHVybiBLaSgpLG51bGwhPT1hJiZudWxsIT09YS5tZW1vaXplZFN0YXRlIT09KG51bGwhPT1iLm1lbW9pemVkU3RhdGUpJiZcInVuc3RhYmxlLWRlZmVyLXdpdGhvdXQtaGlkaW5nXCIhPT1kLm1vZGUmJihiLmZsYWdzfD00KSxudWxsfXRocm93IEVycm9yKHkoMTU2LGIudGFnKSk7fVxuZnVuY3Rpb24gTGkoYSl7c3dpdGNoKGEudGFnKXtjYXNlIDE6RmYoYS50eXBlKSYmR2YoKTt2YXIgYj1hLmZsYWdzO3JldHVybiBiJjQwOTY/KGEuZmxhZ3M9YiYtNDA5N3w2NCxhKTpudWxsO2Nhc2UgMzpmaCgpO0goTik7SChNKTt1aCgpO2I9YS5mbGFncztpZigwIT09KGImNjQpKXRocm93IEVycm9yKHkoMjg1KSk7YS5mbGFncz1iJi00MDk3fDY0O3JldHVybiBhO2Nhc2UgNTpyZXR1cm4gaGgoYSksbnVsbDtjYXNlIDEzOnJldHVybiBIKFApLGI9YS5mbGFncyxiJjQwOTY/KGEuZmxhZ3M9YiYtNDA5N3w2NCxhKTpudWxsO2Nhc2UgMTk6cmV0dXJuIEgoUCksbnVsbDtjYXNlIDQ6cmV0dXJuIGZoKCksbnVsbDtjYXNlIDEwOnJldHVybiByZyhhKSxudWxsO2Nhc2UgMjM6Y2FzZSAyNDpyZXR1cm4gS2koKSxudWxsO2RlZmF1bHQ6cmV0dXJuIG51bGx9fVxuZnVuY3Rpb24gTWkoYSxiKXt0cnl7dmFyIGM9XCJcIixkPWI7ZG8gYys9UWEoZCksZD1kLnJldHVybjt3aGlsZShkKTt2YXIgZT1jfWNhdGNoKGYpe2U9XCJcXG5FcnJvciBnZW5lcmF0aW5nIHN0YWNrOiBcIitmLm1lc3NhZ2UrXCJcXG5cIitmLnN0YWNrfXJldHVybnt2YWx1ZTphLHNvdXJjZTpiLHN0YWNrOmV9fWZ1bmN0aW9uIE5pKGEsYil7dHJ5e2NvbnNvbGUuZXJyb3IoYi52YWx1ZSl9Y2F0Y2goYyl7c2V0VGltZW91dChmdW5jdGlvbigpe3Rocm93IGM7fSl9fXZhciBPaT1cImZ1bmN0aW9uXCI9PT10eXBlb2YgV2Vha01hcD9XZWFrTWFwOk1hcDtmdW5jdGlvbiBQaShhLGIsYyl7Yz16ZygtMSxjKTtjLnRhZz0zO2MucGF5bG9hZD17ZWxlbWVudDpudWxsfTt2YXIgZD1iLnZhbHVlO2MuY2FsbGJhY2s9ZnVuY3Rpb24oKXtRaXx8KFFpPSEwLFJpPWQpO05pKGEsYil9O3JldHVybiBjfVxuZnVuY3Rpb24gU2koYSxiLGMpe2M9emcoLTEsYyk7Yy50YWc9Mzt2YXIgZD1hLnR5cGUuZ2V0RGVyaXZlZFN0YXRlRnJvbUVycm9yO2lmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBkKXt2YXIgZT1iLnZhbHVlO2MucGF5bG9hZD1mdW5jdGlvbigpe05pKGEsYik7cmV0dXJuIGQoZSl9fXZhciBmPWEuc3RhdGVOb2RlO251bGwhPT1mJiZcImZ1bmN0aW9uXCI9PT10eXBlb2YgZi5jb21wb25lbnREaWRDYXRjaCYmKGMuY2FsbGJhY2s9ZnVuY3Rpb24oKXtcImZ1bmN0aW9uXCIhPT10eXBlb2YgZCYmKG51bGw9PT1UaT9UaT1uZXcgU2V0KFt0aGlzXSk6VGkuYWRkKHRoaXMpLE5pKGEsYikpO3ZhciBjPWIuc3RhY2s7dGhpcy5jb21wb25lbnREaWRDYXRjaChiLnZhbHVlLHtjb21wb25lbnRTdGFjazpudWxsIT09Yz9jOlwiXCJ9KX0pO3JldHVybiBjfXZhciBVaT1cImZ1bmN0aW9uXCI9PT10eXBlb2YgV2Vha1NldD9XZWFrU2V0OlNldDtcbmZ1bmN0aW9uIFZpKGEpe3ZhciBiPWEucmVmO2lmKG51bGwhPT1iKWlmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBiKXRyeXtiKG51bGwpfWNhdGNoKGMpe1dpKGEsYyl9ZWxzZSBiLmN1cnJlbnQ9bnVsbH1mdW5jdGlvbiBYaShhLGIpe3N3aXRjaChiLnRhZyl7Y2FzZSAwOmNhc2UgMTE6Y2FzZSAxNTpjYXNlIDIyOnJldHVybjtjYXNlIDE6aWYoYi5mbGFncyYyNTYmJm51bGwhPT1hKXt2YXIgYz1hLm1lbW9pemVkUHJvcHMsZD1hLm1lbW9pemVkU3RhdGU7YT1iLnN0YXRlTm9kZTtiPWEuZ2V0U25hcHNob3RCZWZvcmVVcGRhdGUoYi5lbGVtZW50VHlwZT09PWIudHlwZT9jOmxnKGIudHlwZSxjKSxkKTthLl9fcmVhY3RJbnRlcm5hbFNuYXBzaG90QmVmb3JlVXBkYXRlPWJ9cmV0dXJuO2Nhc2UgMzpiLmZsYWdzJjI1NiYmcWYoYi5zdGF0ZU5vZGUuY29udGFpbmVySW5mbyk7cmV0dXJuO2Nhc2UgNTpjYXNlIDY6Y2FzZSA0OmNhc2UgMTc6cmV0dXJufXRocm93IEVycm9yKHkoMTYzKSk7fVxuZnVuY3Rpb24gWWkoYSxiLGMpe3N3aXRjaChjLnRhZyl7Y2FzZSAwOmNhc2UgMTE6Y2FzZSAxNTpjYXNlIDIyOmI9Yy51cGRhdGVRdWV1ZTtiPW51bGwhPT1iP2IubGFzdEVmZmVjdDpudWxsO2lmKG51bGwhPT1iKXthPWI9Yi5uZXh0O2Rve2lmKDM9PT0oYS50YWcmMykpe3ZhciBkPWEuY3JlYXRlO2EuZGVzdHJveT1kKCl9YT1hLm5leHR9d2hpbGUoYSE9PWIpfWI9Yy51cGRhdGVRdWV1ZTtiPW51bGwhPT1iP2IubGFzdEVmZmVjdDpudWxsO2lmKG51bGwhPT1iKXthPWI9Yi5uZXh0O2Rve3ZhciBlPWE7ZD1lLm5leHQ7ZT1lLnRhZzswIT09KGUmNCkmJjAhPT0oZSYxKSYmKFppKGMsYSksJGkoYyxhKSk7YT1kfXdoaWxlKGEhPT1iKX1yZXR1cm47Y2FzZSAxOmE9Yy5zdGF0ZU5vZGU7Yy5mbGFncyY0JiYobnVsbD09PWI/YS5jb21wb25lbnREaWRNb3VudCgpOihkPWMuZWxlbWVudFR5cGU9PT1jLnR5cGU/Yi5tZW1vaXplZFByb3BzOmxnKGMudHlwZSxiLm1lbW9pemVkUHJvcHMpLGEuY29tcG9uZW50RGlkVXBkYXRlKGQsXG5iLm1lbW9pemVkU3RhdGUsYS5fX3JlYWN0SW50ZXJuYWxTbmFwc2hvdEJlZm9yZVVwZGF0ZSkpKTtiPWMudXBkYXRlUXVldWU7bnVsbCE9PWImJkVnKGMsYixhKTtyZXR1cm47Y2FzZSAzOmI9Yy51cGRhdGVRdWV1ZTtpZihudWxsIT09Yil7YT1udWxsO2lmKG51bGwhPT1jLmNoaWxkKXN3aXRjaChjLmNoaWxkLnRhZyl7Y2FzZSA1OmE9Yy5jaGlsZC5zdGF0ZU5vZGU7YnJlYWs7Y2FzZSAxOmE9Yy5jaGlsZC5zdGF0ZU5vZGV9RWcoYyxiLGEpfXJldHVybjtjYXNlIDU6YT1jLnN0YXRlTm9kZTtudWxsPT09YiYmYy5mbGFncyY0JiZtZihjLnR5cGUsYy5tZW1vaXplZFByb3BzKSYmYS5mb2N1cygpO3JldHVybjtjYXNlIDY6cmV0dXJuO2Nhc2UgNDpyZXR1cm47Y2FzZSAxMjpyZXR1cm47Y2FzZSAxMzpudWxsPT09Yy5tZW1vaXplZFN0YXRlJiYoYz1jLmFsdGVybmF0ZSxudWxsIT09YyYmKGM9Yy5tZW1vaXplZFN0YXRlLG51bGwhPT1jJiYoYz1jLmRlaHlkcmF0ZWQsbnVsbCE9PWMmJkNjKGMpKSkpO1xucmV0dXJuO2Nhc2UgMTk6Y2FzZSAxNzpjYXNlIDIwOmNhc2UgMjE6Y2FzZSAyMzpjYXNlIDI0OnJldHVybn10aHJvdyBFcnJvcih5KDE2MykpO31cbmZ1bmN0aW9uIGFqKGEsYil7Zm9yKHZhciBjPWE7Oyl7aWYoNT09PWMudGFnKXt2YXIgZD1jLnN0YXRlTm9kZTtpZihiKWQ9ZC5zdHlsZSxcImZ1bmN0aW9uXCI9PT10eXBlb2YgZC5zZXRQcm9wZXJ0eT9kLnNldFByb3BlcnR5KFwiZGlzcGxheVwiLFwibm9uZVwiLFwiaW1wb3J0YW50XCIpOmQuZGlzcGxheT1cIm5vbmVcIjtlbHNle2Q9Yy5zdGF0ZU5vZGU7dmFyIGU9Yy5tZW1vaXplZFByb3BzLnN0eWxlO2U9dm9pZCAwIT09ZSYmbnVsbCE9PWUmJmUuaGFzT3duUHJvcGVydHkoXCJkaXNwbGF5XCIpP2UuZGlzcGxheTpudWxsO2Quc3R5bGUuZGlzcGxheT1zYihcImRpc3BsYXlcIixlKX19ZWxzZSBpZig2PT09Yy50YWcpYy5zdGF0ZU5vZGUubm9kZVZhbHVlPWI/XCJcIjpjLm1lbW9pemVkUHJvcHM7ZWxzZSBpZigoMjMhPT1jLnRhZyYmMjQhPT1jLnRhZ3x8bnVsbD09PWMubWVtb2l6ZWRTdGF0ZXx8Yz09PWEpJiZudWxsIT09Yy5jaGlsZCl7Yy5jaGlsZC5yZXR1cm49YztjPWMuY2hpbGQ7Y29udGludWV9aWYoYz09PVxuYSlicmVhaztmb3IoO251bGw9PT1jLnNpYmxpbmc7KXtpZihudWxsPT09Yy5yZXR1cm58fGMucmV0dXJuPT09YSlyZXR1cm47Yz1jLnJldHVybn1jLnNpYmxpbmcucmV0dXJuPWMucmV0dXJuO2M9Yy5zaWJsaW5nfX1cbmZ1bmN0aW9uIGJqKGEsYil7aWYoTWYmJlwiZnVuY3Rpb25cIj09PXR5cGVvZiBNZi5vbkNvbW1pdEZpYmVyVW5tb3VudCl0cnl7TWYub25Db21taXRGaWJlclVubW91bnQoTGYsYil9Y2F0Y2goZil7fXN3aXRjaChiLnRhZyl7Y2FzZSAwOmNhc2UgMTE6Y2FzZSAxNDpjYXNlIDE1OmNhc2UgMjI6YT1iLnVwZGF0ZVF1ZXVlO2lmKG51bGwhPT1hJiYoYT1hLmxhc3RFZmZlY3QsbnVsbCE9PWEpKXt2YXIgYz1hPWEubmV4dDtkb3t2YXIgZD1jLGU9ZC5kZXN0cm95O2Q9ZC50YWc7aWYodm9pZCAwIT09ZSlpZigwIT09KGQmNCkpWmkoYixjKTtlbHNle2Q9Yjt0cnl7ZSgpfWNhdGNoKGYpe1dpKGQsZil9fWM9Yy5uZXh0fXdoaWxlKGMhPT1hKX1icmVhaztjYXNlIDE6VmkoYik7YT1iLnN0YXRlTm9kZTtpZihcImZ1bmN0aW9uXCI9PT10eXBlb2YgYS5jb21wb25lbnRXaWxsVW5tb3VudCl0cnl7YS5wcm9wcz1iLm1lbW9pemVkUHJvcHMsYS5zdGF0ZT1iLm1lbW9pemVkU3RhdGUsYS5jb21wb25lbnRXaWxsVW5tb3VudCgpfWNhdGNoKGYpe1dpKGIsXG5mKX1icmVhaztjYXNlIDU6VmkoYik7YnJlYWs7Y2FzZSA0OmNqKGEsYil9fWZ1bmN0aW9uIGRqKGEpe2EuYWx0ZXJuYXRlPW51bGw7YS5jaGlsZD1udWxsO2EuZGVwZW5kZW5jaWVzPW51bGw7YS5maXJzdEVmZmVjdD1udWxsO2EubGFzdEVmZmVjdD1udWxsO2EubWVtb2l6ZWRQcm9wcz1udWxsO2EubWVtb2l6ZWRTdGF0ZT1udWxsO2EucGVuZGluZ1Byb3BzPW51bGw7YS5yZXR1cm49bnVsbDthLnVwZGF0ZVF1ZXVlPW51bGx9ZnVuY3Rpb24gZWooYSl7cmV0dXJuIDU9PT1hLnRhZ3x8Mz09PWEudGFnfHw0PT09YS50YWd9XG5mdW5jdGlvbiBmaihhKXthOntmb3IodmFyIGI9YS5yZXR1cm47bnVsbCE9PWI7KXtpZihlaihiKSlicmVhayBhO2I9Yi5yZXR1cm59dGhyb3cgRXJyb3IoeSgxNjApKTt9dmFyIGM9YjtiPWMuc3RhdGVOb2RlO3N3aXRjaChjLnRhZyl7Y2FzZSA1OnZhciBkPSExO2JyZWFrO2Nhc2UgMzpiPWIuY29udGFpbmVySW5mbztkPSEwO2JyZWFrO2Nhc2UgNDpiPWIuY29udGFpbmVySW5mbztkPSEwO2JyZWFrO2RlZmF1bHQ6dGhyb3cgRXJyb3IoeSgxNjEpKTt9Yy5mbGFncyYxNiYmKHBiKGIsXCJcIiksYy5mbGFncyY9LTE3KTthOmI6Zm9yKGM9YTs7KXtmb3IoO251bGw9PT1jLnNpYmxpbmc7KXtpZihudWxsPT09Yy5yZXR1cm58fGVqKGMucmV0dXJuKSl7Yz1udWxsO2JyZWFrIGF9Yz1jLnJldHVybn1jLnNpYmxpbmcucmV0dXJuPWMucmV0dXJuO2ZvcihjPWMuc2libGluZzs1IT09Yy50YWcmJjYhPT1jLnRhZyYmMTghPT1jLnRhZzspe2lmKGMuZmxhZ3MmMiljb250aW51ZSBiO2lmKG51bGw9PT1cbmMuY2hpbGR8fDQ9PT1jLnRhZyljb250aW51ZSBiO2Vsc2UgYy5jaGlsZC5yZXR1cm49YyxjPWMuY2hpbGR9aWYoIShjLmZsYWdzJjIpKXtjPWMuc3RhdGVOb2RlO2JyZWFrIGF9fWQ/Z2ooYSxjLGIpOmhqKGEsYyxiKX1cbmZ1bmN0aW9uIGdqKGEsYixjKXt2YXIgZD1hLnRhZyxlPTU9PT1kfHw2PT09ZDtpZihlKWE9ZT9hLnN0YXRlTm9kZTphLnN0YXRlTm9kZS5pbnN0YW5jZSxiPzg9PT1jLm5vZGVUeXBlP2MucGFyZW50Tm9kZS5pbnNlcnRCZWZvcmUoYSxiKTpjLmluc2VydEJlZm9yZShhLGIpOig4PT09Yy5ub2RlVHlwZT8oYj1jLnBhcmVudE5vZGUsYi5pbnNlcnRCZWZvcmUoYSxjKSk6KGI9YyxiLmFwcGVuZENoaWxkKGEpKSxjPWMuX3JlYWN0Um9vdENvbnRhaW5lcixudWxsIT09YyYmdm9pZCAwIT09Y3x8bnVsbCE9PWIub25jbGlja3x8KGIub25jbGljaz1qZikpO2Vsc2UgaWYoNCE9PWQmJihhPWEuY2hpbGQsbnVsbCE9PWEpKWZvcihnaihhLGIsYyksYT1hLnNpYmxpbmc7bnVsbCE9PWE7KWdqKGEsYixjKSxhPWEuc2libGluZ31cbmZ1bmN0aW9uIGhqKGEsYixjKXt2YXIgZD1hLnRhZyxlPTU9PT1kfHw2PT09ZDtpZihlKWE9ZT9hLnN0YXRlTm9kZTphLnN0YXRlTm9kZS5pbnN0YW5jZSxiP2MuaW5zZXJ0QmVmb3JlKGEsYik6Yy5hcHBlbmRDaGlsZChhKTtlbHNlIGlmKDQhPT1kJiYoYT1hLmNoaWxkLG51bGwhPT1hKSlmb3IoaGooYSxiLGMpLGE9YS5zaWJsaW5nO251bGwhPT1hOyloaihhLGIsYyksYT1hLnNpYmxpbmd9XG5mdW5jdGlvbiBjaihhLGIpe2Zvcih2YXIgYz1iLGQ9ITEsZSxmOzspe2lmKCFkKXtkPWMucmV0dXJuO2E6Zm9yKDs7KXtpZihudWxsPT09ZCl0aHJvdyBFcnJvcih5KDE2MCkpO2U9ZC5zdGF0ZU5vZGU7c3dpdGNoKGQudGFnKXtjYXNlIDU6Zj0hMTticmVhayBhO2Nhc2UgMzplPWUuY29udGFpbmVySW5mbztmPSEwO2JyZWFrIGE7Y2FzZSA0OmU9ZS5jb250YWluZXJJbmZvO2Y9ITA7YnJlYWsgYX1kPWQucmV0dXJufWQ9ITB9aWYoNT09PWMudGFnfHw2PT09Yy50YWcpe2E6Zm9yKHZhciBnPWEsaD1jLGs9aDs7KWlmKGJqKGcsayksbnVsbCE9PWsuY2hpbGQmJjQhPT1rLnRhZylrLmNoaWxkLnJldHVybj1rLGs9ay5jaGlsZDtlbHNle2lmKGs9PT1oKWJyZWFrIGE7Zm9yKDtudWxsPT09ay5zaWJsaW5nOyl7aWYobnVsbD09PWsucmV0dXJufHxrLnJldHVybj09PWgpYnJlYWsgYTtrPWsucmV0dXJufWsuc2libGluZy5yZXR1cm49ay5yZXR1cm47az1rLnNpYmxpbmd9Zj8oZz1lLGg9Yy5zdGF0ZU5vZGUsXG44PT09Zy5ub2RlVHlwZT9nLnBhcmVudE5vZGUucmVtb3ZlQ2hpbGQoaCk6Zy5yZW1vdmVDaGlsZChoKSk6ZS5yZW1vdmVDaGlsZChjLnN0YXRlTm9kZSl9ZWxzZSBpZig0PT09Yy50YWcpe2lmKG51bGwhPT1jLmNoaWxkKXtlPWMuc3RhdGVOb2RlLmNvbnRhaW5lckluZm87Zj0hMDtjLmNoaWxkLnJldHVybj1jO2M9Yy5jaGlsZDtjb250aW51ZX19ZWxzZSBpZihiaihhLGMpLG51bGwhPT1jLmNoaWxkKXtjLmNoaWxkLnJldHVybj1jO2M9Yy5jaGlsZDtjb250aW51ZX1pZihjPT09YilicmVhaztmb3IoO251bGw9PT1jLnNpYmxpbmc7KXtpZihudWxsPT09Yy5yZXR1cm58fGMucmV0dXJuPT09YilyZXR1cm47Yz1jLnJldHVybjs0PT09Yy50YWcmJihkPSExKX1jLnNpYmxpbmcucmV0dXJuPWMucmV0dXJuO2M9Yy5zaWJsaW5nfX1cbmZ1bmN0aW9uIGlqKGEsYil7c3dpdGNoKGIudGFnKXtjYXNlIDA6Y2FzZSAxMTpjYXNlIDE0OmNhc2UgMTU6Y2FzZSAyMjp2YXIgYz1iLnVwZGF0ZVF1ZXVlO2M9bnVsbCE9PWM/Yy5sYXN0RWZmZWN0Om51bGw7aWYobnVsbCE9PWMpe3ZhciBkPWM9Yy5uZXh0O2RvIDM9PT0oZC50YWcmMykmJihhPWQuZGVzdHJveSxkLmRlc3Ryb3k9dm9pZCAwLHZvaWQgMCE9PWEmJmEoKSksZD1kLm5leHQ7d2hpbGUoZCE9PWMpfXJldHVybjtjYXNlIDE6cmV0dXJuO2Nhc2UgNTpjPWIuc3RhdGVOb2RlO2lmKG51bGwhPWMpe2Q9Yi5tZW1vaXplZFByb3BzO3ZhciBlPW51bGwhPT1hP2EubWVtb2l6ZWRQcm9wczpkO2E9Yi50eXBlO3ZhciBmPWIudXBkYXRlUXVldWU7Yi51cGRhdGVRdWV1ZT1udWxsO2lmKG51bGwhPT1mKXtjW3hmXT1kO1wiaW5wdXRcIj09PWEmJlwicmFkaW9cIj09PWQudHlwZSYmbnVsbCE9ZC5uYW1lJiYkYShjLGQpO3diKGEsZSk7Yj13YihhLGQpO2ZvcihlPTA7ZTxmLmxlbmd0aDtlKz1cbjIpe3ZhciBnPWZbZV0saD1mW2UrMV07XCJzdHlsZVwiPT09Zz90YihjLGgpOlwiZGFuZ2Vyb3VzbHlTZXRJbm5lckhUTUxcIj09PWc/b2IoYyxoKTpcImNoaWxkcmVuXCI9PT1nP3BiKGMsaCk6cWEoYyxnLGgsYil9c3dpdGNoKGEpe2Nhc2UgXCJpbnB1dFwiOmFiKGMsZCk7YnJlYWs7Y2FzZSBcInRleHRhcmVhXCI6aWIoYyxkKTticmVhaztjYXNlIFwic2VsZWN0XCI6YT1jLl93cmFwcGVyU3RhdGUud2FzTXVsdGlwbGUsYy5fd3JhcHBlclN0YXRlLndhc011bHRpcGxlPSEhZC5tdWx0aXBsZSxmPWQudmFsdWUsbnVsbCE9Zj9mYihjLCEhZC5tdWx0aXBsZSxmLCExKTphIT09ISFkLm11bHRpcGxlJiYobnVsbCE9ZC5kZWZhdWx0VmFsdWU/ZmIoYywhIWQubXVsdGlwbGUsZC5kZWZhdWx0VmFsdWUsITApOmZiKGMsISFkLm11bHRpcGxlLGQubXVsdGlwbGU/W106XCJcIiwhMSkpfX19cmV0dXJuO2Nhc2UgNjppZihudWxsPT09Yi5zdGF0ZU5vZGUpdGhyb3cgRXJyb3IoeSgxNjIpKTtiLnN0YXRlTm9kZS5ub2RlVmFsdWU9XG5iLm1lbW9pemVkUHJvcHM7cmV0dXJuO2Nhc2UgMzpjPWIuc3RhdGVOb2RlO2MuaHlkcmF0ZSYmKGMuaHlkcmF0ZT0hMSxDYyhjLmNvbnRhaW5lckluZm8pKTtyZXR1cm47Y2FzZSAxMjpyZXR1cm47Y2FzZSAxMzpudWxsIT09Yi5tZW1vaXplZFN0YXRlJiYoamo9TygpLGFqKGIuY2hpbGQsITApKTtraihiKTtyZXR1cm47Y2FzZSAxOTpraihiKTtyZXR1cm47Y2FzZSAxNzpyZXR1cm47Y2FzZSAyMzpjYXNlIDI0OmFqKGIsbnVsbCE9PWIubWVtb2l6ZWRTdGF0ZSk7cmV0dXJufXRocm93IEVycm9yKHkoMTYzKSk7fWZ1bmN0aW9uIGtqKGEpe3ZhciBiPWEudXBkYXRlUXVldWU7aWYobnVsbCE9PWIpe2EudXBkYXRlUXVldWU9bnVsbDt2YXIgYz1hLnN0YXRlTm9kZTtudWxsPT09YyYmKGM9YS5zdGF0ZU5vZGU9bmV3IFVpKTtiLmZvckVhY2goZnVuY3Rpb24oYil7dmFyIGQ9bGouYmluZChudWxsLGEsYik7Yy5oYXMoYil8fChjLmFkZChiKSxiLnRoZW4oZCxkKSl9KX19XG5mdW5jdGlvbiBtaihhLGIpe3JldHVybiBudWxsIT09YSYmKGE9YS5tZW1vaXplZFN0YXRlLG51bGw9PT1hfHxudWxsIT09YS5kZWh5ZHJhdGVkKT8oYj1iLm1lbW9pemVkU3RhdGUsbnVsbCE9PWImJm51bGw9PT1iLmRlaHlkcmF0ZWQpOiExfXZhciBuaj1NYXRoLmNlaWwsb2o9cmEuUmVhY3RDdXJyZW50RGlzcGF0Y2hlcixwaj1yYS5SZWFjdEN1cnJlbnRPd25lcixYPTAsVT1udWxsLFk9bnVsbCxXPTAscWo9MCxyaj1CZigwKSxWPTAsc2o9bnVsbCx0aj0wLERnPTAsSGk9MCx1aj0wLHZqPW51bGwsamo9MCxKaT1JbmZpbml0eTtmdW5jdGlvbiB3aigpe0ppPU8oKSs1MDB9dmFyIFo9bnVsbCxRaT0hMSxSaT1udWxsLFRpPW51bGwseGo9ITEseWo9bnVsbCx6aj05MCxBaj1bXSxCaj1bXSxDaj1udWxsLERqPTAsRWo9bnVsbCxGaj0tMSxHaj0wLEhqPTAsSWo9bnVsbCxKaj0hMTtmdW5jdGlvbiBIZygpe3JldHVybiAwIT09KFgmNDgpP08oKTotMSE9PUZqP0ZqOkZqPU8oKX1cbmZ1bmN0aW9uIElnKGEpe2E9YS5tb2RlO2lmKDA9PT0oYSYyKSlyZXR1cm4gMTtpZigwPT09KGEmNCkpcmV0dXJuIDk5PT09ZWcoKT8xOjI7MD09PUdqJiYoR2o9dGopO2lmKDAhPT1rZy50cmFuc2l0aW9uKXswIT09SGomJihIaj1udWxsIT09dmo/dmoucGVuZGluZ0xhbmVzOjApO2E9R2o7dmFyIGI9NDE4NjExMiZ+SGo7YiY9LWI7MD09PWImJihhPTQxODYxMTImfmEsYj1hJi1hLDA9PT1iJiYoYj04MTkyKSk7cmV0dXJuIGJ9YT1lZygpOzAhPT0oWCY0KSYmOTg9PT1hP2E9WGMoMTIsR2opOihhPVNjKGEpLGE9WGMoYSxHaikpO3JldHVybiBhfVxuZnVuY3Rpb24gSmcoYSxiLGMpe2lmKDUwPERqKXRocm93IERqPTAsRWo9bnVsbCxFcnJvcih5KDE4NSkpO2E9S2ooYSxiKTtpZihudWxsPT09YSlyZXR1cm4gbnVsbDskYyhhLGIsYyk7YT09PVUmJihIaXw9Yiw0PT09ViYmSWkoYSxXKSk7dmFyIGQ9ZWcoKTsxPT09Yj8wIT09KFgmOCkmJjA9PT0oWCY0OCk/TGooYSk6KE1qKGEsYyksMD09PVgmJih3aigpLGlnKCkpKTooMD09PShYJjQpfHw5OCE9PWQmJjk5IT09ZHx8KG51bGw9PT1Daj9Daj1uZXcgU2V0KFthXSk6Q2ouYWRkKGEpKSxNaihhLGMpKTt2aj1hfWZ1bmN0aW9uIEtqKGEsYil7YS5sYW5lc3w9Yjt2YXIgYz1hLmFsdGVybmF0ZTtudWxsIT09YyYmKGMubGFuZXN8PWIpO2M9YTtmb3IoYT1hLnJldHVybjtudWxsIT09YTspYS5jaGlsZExhbmVzfD1iLGM9YS5hbHRlcm5hdGUsbnVsbCE9PWMmJihjLmNoaWxkTGFuZXN8PWIpLGM9YSxhPWEucmV0dXJuO3JldHVybiAzPT09Yy50YWc/Yy5zdGF0ZU5vZGU6bnVsbH1cbmZ1bmN0aW9uIE1qKGEsYil7Zm9yKHZhciBjPWEuY2FsbGJhY2tOb2RlLGQ9YS5zdXNwZW5kZWRMYW5lcyxlPWEucGluZ2VkTGFuZXMsZj1hLmV4cGlyYXRpb25UaW1lcyxnPWEucGVuZGluZ0xhbmVzOzA8Zzspe3ZhciBoPTMxLVZjKGcpLGs9MTw8aCxsPWZbaF07aWYoLTE9PT1sKXtpZigwPT09KGsmZCl8fDAhPT0oayZlKSl7bD1iO1JjKGspO3ZhciBuPUY7ZltoXT0xMDw9bj9sKzI1MDo2PD1uP2wrNUUzOi0xfX1lbHNlIGw8PWImJihhLmV4cGlyZWRMYW5lc3w9ayk7ZyY9fmt9ZD1VYyhhLGE9PT1VP1c6MCk7Yj1GO2lmKDA9PT1kKW51bGwhPT1jJiYoYyE9PVpmJiZQZihjKSxhLmNhbGxiYWNrTm9kZT1udWxsLGEuY2FsbGJhY2tQcmlvcml0eT0wKTtlbHNle2lmKG51bGwhPT1jKXtpZihhLmNhbGxiYWNrUHJpb3JpdHk9PT1iKXJldHVybjtjIT09WmYmJlBmKGMpfTE1PT09Yj8oYz1Mai5iaW5kKG51bGwsYSksbnVsbD09PWFnPyhhZz1bY10sYmc9T2YoVWYsamcpKTphZy5wdXNoKGMpLFxuYz1aZik6MTQ9PT1iP2M9aGcoOTksTGouYmluZChudWxsLGEpKTooYz1UYyhiKSxjPWhnKGMsTmouYmluZChudWxsLGEpKSk7YS5jYWxsYmFja1ByaW9yaXR5PWI7YS5jYWxsYmFja05vZGU9Y319XG5mdW5jdGlvbiBOaihhKXtGaj0tMTtIaj1Haj0wO2lmKDAhPT0oWCY0OCkpdGhyb3cgRXJyb3IoeSgzMjcpKTt2YXIgYj1hLmNhbGxiYWNrTm9kZTtpZihPaigpJiZhLmNhbGxiYWNrTm9kZSE9PWIpcmV0dXJuIG51bGw7dmFyIGM9VWMoYSxhPT09VT9XOjApO2lmKDA9PT1jKXJldHVybiBudWxsO3ZhciBkPWM7dmFyIGU9WDtYfD0xNjt2YXIgZj1QaigpO2lmKFUhPT1hfHxXIT09ZCl3aigpLFFqKGEsZCk7ZG8gdHJ5e1JqKCk7YnJlYWt9Y2F0Y2goaCl7U2ooYSxoKX13aGlsZSgxKTtxZygpO29qLmN1cnJlbnQ9ZjtYPWU7bnVsbCE9PVk/ZD0wOihVPW51bGwsVz0wLGQ9Vik7aWYoMCE9PSh0aiZIaSkpUWooYSwwKTtlbHNlIGlmKDAhPT1kKXsyPT09ZCYmKFh8PTY0LGEuaHlkcmF0ZSYmKGEuaHlkcmF0ZT0hMSxxZihhLmNvbnRhaW5lckluZm8pKSxjPVdjKGEpLDAhPT1jJiYoZD1UaihhLGMpKSk7aWYoMT09PWQpdGhyb3cgYj1zaixRaihhLDApLElpKGEsYyksTWooYSxPKCkpLGI7YS5maW5pc2hlZFdvcms9XG5hLmN1cnJlbnQuYWx0ZXJuYXRlO2EuZmluaXNoZWRMYW5lcz1jO3N3aXRjaChkKXtjYXNlIDA6Y2FzZSAxOnRocm93IEVycm9yKHkoMzQ1KSk7Y2FzZSAyOlVqKGEpO2JyZWFrO2Nhc2UgMzpJaShhLGMpO2lmKChjJjYyOTE0NTYwKT09PWMmJihkPWpqKzUwMC1PKCksMTA8ZCkpe2lmKDAhPT1VYyhhLDApKWJyZWFrO2U9YS5zdXNwZW5kZWRMYW5lcztpZigoZSZjKSE9PWMpe0hnKCk7YS5waW5nZWRMYW5lc3w9YS5zdXNwZW5kZWRMYW5lcyZlO2JyZWFrfWEudGltZW91dEhhbmRsZT1vZihVai5iaW5kKG51bGwsYSksZCk7YnJlYWt9VWooYSk7YnJlYWs7Y2FzZSA0OklpKGEsYyk7aWYoKGMmNDE4NjExMik9PT1jKWJyZWFrO2Q9YS5ldmVudFRpbWVzO2ZvcihlPS0xOzA8Yzspe3ZhciBnPTMxLVZjKGMpO2Y9MTw8ZztnPWRbZ107Zz5lJiYoZT1nKTtjJj1+Zn1jPWU7Yz1PKCktYztjPSgxMjA+Yz8xMjA6NDgwPmM/NDgwOjEwODA+Yz8xMDgwOjE5MjA+Yz8xOTIwOjNFMz5jPzNFMzo0MzIwPlxuYz80MzIwOjE5NjAqbmooYy8xOTYwKSktYztpZigxMDxjKXthLnRpbWVvdXRIYW5kbGU9b2YoVWouYmluZChudWxsLGEpLGMpO2JyZWFrfVVqKGEpO2JyZWFrO2Nhc2UgNTpVaihhKTticmVhaztkZWZhdWx0OnRocm93IEVycm9yKHkoMzI5KSk7fX1NaihhLE8oKSk7cmV0dXJuIGEuY2FsbGJhY2tOb2RlPT09Yj9Oai5iaW5kKG51bGwsYSk6bnVsbH1mdW5jdGlvbiBJaShhLGIpe2ImPX51ajtiJj1+SGk7YS5zdXNwZW5kZWRMYW5lc3w9YjthLnBpbmdlZExhbmVzJj1+Yjtmb3IoYT1hLmV4cGlyYXRpb25UaW1lczswPGI7KXt2YXIgYz0zMS1WYyhiKSxkPTE8PGM7YVtjXT0tMTtiJj1+ZH19XG5mdW5jdGlvbiBMaihhKXtpZigwIT09KFgmNDgpKXRocm93IEVycm9yKHkoMzI3KSk7T2ooKTtpZihhPT09VSYmMCE9PShhLmV4cGlyZWRMYW5lcyZXKSl7dmFyIGI9Vzt2YXIgYz1UaihhLGIpOzAhPT0odGomSGkpJiYoYj1VYyhhLGIpLGM9VGooYSxiKSl9ZWxzZSBiPVVjKGEsMCksYz1UaihhLGIpOzAhPT1hLnRhZyYmMj09PWMmJihYfD02NCxhLmh5ZHJhdGUmJihhLmh5ZHJhdGU9ITEscWYoYS5jb250YWluZXJJbmZvKSksYj1XYyhhKSwwIT09YiYmKGM9VGooYSxiKSkpO2lmKDE9PT1jKXRocm93IGM9c2osUWooYSwwKSxJaShhLGIpLE1qKGEsTygpKSxjO2EuZmluaXNoZWRXb3JrPWEuY3VycmVudC5hbHRlcm5hdGU7YS5maW5pc2hlZExhbmVzPWI7VWooYSk7TWooYSxPKCkpO3JldHVybiBudWxsfVxuZnVuY3Rpb24gVmooKXtpZihudWxsIT09Q2ope3ZhciBhPUNqO0NqPW51bGw7YS5mb3JFYWNoKGZ1bmN0aW9uKGEpe2EuZXhwaXJlZExhbmVzfD0yNCZhLnBlbmRpbmdMYW5lcztNaihhLE8oKSl9KX1pZygpfWZ1bmN0aW9uIFdqKGEsYil7dmFyIGM9WDtYfD0xO3RyeXtyZXR1cm4gYShiKX1maW5hbGx5e1g9YywwPT09WCYmKHdqKCksaWcoKSl9fWZ1bmN0aW9uIFhqKGEsYil7dmFyIGM9WDtYJj0tMjtYfD04O3RyeXtyZXR1cm4gYShiKX1maW5hbGx5e1g9YywwPT09WCYmKHdqKCksaWcoKSl9fWZ1bmN0aW9uIG5pKGEsYil7SShyaixxaik7cWp8PWI7dGp8PWJ9ZnVuY3Rpb24gS2koKXtxaj1yai5jdXJyZW50O0gocmopfVxuZnVuY3Rpb24gUWooYSxiKXthLmZpbmlzaGVkV29yaz1udWxsO2EuZmluaXNoZWRMYW5lcz0wO3ZhciBjPWEudGltZW91dEhhbmRsZTstMSE9PWMmJihhLnRpbWVvdXRIYW5kbGU9LTEscGYoYykpO2lmKG51bGwhPT1ZKWZvcihjPVkucmV0dXJuO251bGwhPT1jOyl7dmFyIGQ9Yztzd2l0Y2goZC50YWcpe2Nhc2UgMTpkPWQudHlwZS5jaGlsZENvbnRleHRUeXBlcztudWxsIT09ZCYmdm9pZCAwIT09ZCYmR2YoKTticmVhaztjYXNlIDM6ZmgoKTtIKE4pO0goTSk7dWgoKTticmVhaztjYXNlIDU6aGgoZCk7YnJlYWs7Y2FzZSA0OmZoKCk7YnJlYWs7Y2FzZSAxMzpIKFApO2JyZWFrO2Nhc2UgMTk6SChQKTticmVhaztjYXNlIDEwOnJnKGQpO2JyZWFrO2Nhc2UgMjM6Y2FzZSAyNDpLaSgpfWM9Yy5yZXR1cm59VT1hO1k9VGcoYS5jdXJyZW50LG51bGwpO1c9cWo9dGo9YjtWPTA7c2o9bnVsbDt1aj1IaT1EZz0wfVxuZnVuY3Rpb24gU2ooYSxiKXtkb3t2YXIgYz1ZO3RyeXtxZygpO3ZoLmN1cnJlbnQ9R2g7aWYoeWgpe2Zvcih2YXIgZD1SLm1lbW9pemVkU3RhdGU7bnVsbCE9PWQ7KXt2YXIgZT1kLnF1ZXVlO251bGwhPT1lJiYoZS5wZW5kaW5nPW51bGwpO2Q9ZC5uZXh0fXloPSExfXhoPTA7VD1TPVI9bnVsbDt6aD0hMTtwai5jdXJyZW50PW51bGw7aWYobnVsbD09PWN8fG51bGw9PT1jLnJldHVybil7Vj0xO3NqPWI7WT1udWxsO2JyZWFrfWE6e3ZhciBmPWEsZz1jLnJldHVybixoPWMsaz1iO2I9VztoLmZsYWdzfD0yMDQ4O2guZmlyc3RFZmZlY3Q9aC5sYXN0RWZmZWN0PW51bGw7aWYobnVsbCE9PWsmJlwib2JqZWN0XCI9PT10eXBlb2YgayYmXCJmdW5jdGlvblwiPT09dHlwZW9mIGsudGhlbil7dmFyIGw9aztpZigwPT09KGgubW9kZSYyKSl7dmFyIG49aC5hbHRlcm5hdGU7bj8oaC51cGRhdGVRdWV1ZT1uLnVwZGF0ZVF1ZXVlLGgubWVtb2l6ZWRTdGF0ZT1uLm1lbW9pemVkU3RhdGUsaC5sYW5lcz1uLmxhbmVzKTpcbihoLnVwZGF0ZVF1ZXVlPW51bGwsaC5tZW1vaXplZFN0YXRlPW51bGwpfXZhciBBPTAhPT0oUC5jdXJyZW50JjEpLHA9Zztkb3t2YXIgQztpZihDPTEzPT09cC50YWcpe3ZhciB4PXAubWVtb2l6ZWRTdGF0ZTtpZihudWxsIT09eClDPW51bGwhPT14LmRlaHlkcmF0ZWQ/ITA6ITE7ZWxzZXt2YXIgdz1wLm1lbW9pemVkUHJvcHM7Qz12b2lkIDA9PT13LmZhbGxiYWNrPyExOiEwIT09dy51bnN0YWJsZV9hdm9pZFRoaXNGYWxsYmFjaz8hMDpBPyExOiEwfX1pZihDKXt2YXIgej1wLnVwZGF0ZVF1ZXVlO2lmKG51bGw9PT16KXt2YXIgdT1uZXcgU2V0O3UuYWRkKGwpO3AudXBkYXRlUXVldWU9dX1lbHNlIHouYWRkKGwpO2lmKDA9PT0ocC5tb2RlJjIpKXtwLmZsYWdzfD02NDtoLmZsYWdzfD0xNjM4NDtoLmZsYWdzJj0tMjk4MTtpZigxPT09aC50YWcpaWYobnVsbD09PWguYWx0ZXJuYXRlKWgudGFnPTE3O2Vsc2V7dmFyIHQ9emcoLTEsMSk7dC50YWc9MjtBZyhoLHQpfWgubGFuZXN8PTE7YnJlYWsgYX1rPVxudm9pZCAwO2g9Yjt2YXIgcT1mLnBpbmdDYWNoZTtudWxsPT09cT8ocT1mLnBpbmdDYWNoZT1uZXcgT2ksaz1uZXcgU2V0LHEuc2V0KGwsaykpOihrPXEuZ2V0KGwpLHZvaWQgMD09PWsmJihrPW5ldyBTZXQscS5zZXQobCxrKSkpO2lmKCFrLmhhcyhoKSl7ay5hZGQoaCk7dmFyIHY9WWouYmluZChudWxsLGYsbCxoKTtsLnRoZW4odix2KX1wLmZsYWdzfD00MDk2O3AubGFuZXM9YjticmVhayBhfXA9cC5yZXR1cm59d2hpbGUobnVsbCE9PXApO2s9RXJyb3IoKFJhKGgudHlwZSl8fFwiQSBSZWFjdCBjb21wb25lbnRcIikrXCIgc3VzcGVuZGVkIHdoaWxlIHJlbmRlcmluZywgYnV0IG5vIGZhbGxiYWNrIFVJIHdhcyBzcGVjaWZpZWQuXFxuXFxuQWRkIGEgPFN1c3BlbnNlIGZhbGxiYWNrPS4uLj4gY29tcG9uZW50IGhpZ2hlciBpbiB0aGUgdHJlZSB0byBwcm92aWRlIGEgbG9hZGluZyBpbmRpY2F0b3Igb3IgcGxhY2Vob2xkZXIgdG8gZGlzcGxheS5cIil9NSE9PVYmJihWPTIpO2s9TWkoayxoKTtwPVxuZztkb3tzd2l0Y2gocC50YWcpe2Nhc2UgMzpmPWs7cC5mbGFnc3w9NDA5NjtiJj0tYjtwLmxhbmVzfD1iO3ZhciBKPVBpKHAsZixiKTtCZyhwLEopO2JyZWFrIGE7Y2FzZSAxOmY9azt2YXIgSz1wLnR5cGUsUT1wLnN0YXRlTm9kZTtpZigwPT09KHAuZmxhZ3MmNjQpJiYoXCJmdW5jdGlvblwiPT09dHlwZW9mIEsuZ2V0RGVyaXZlZFN0YXRlRnJvbUVycm9yfHxudWxsIT09USYmXCJmdW5jdGlvblwiPT09dHlwZW9mIFEuY29tcG9uZW50RGlkQ2F0Y2gmJihudWxsPT09VGl8fCFUaS5oYXMoUSkpKSl7cC5mbGFnc3w9NDA5NjtiJj0tYjtwLmxhbmVzfD1iO3ZhciBMPVNpKHAsZixiKTtCZyhwLEwpO2JyZWFrIGF9fXA9cC5yZXR1cm59d2hpbGUobnVsbCE9PXApfVpqKGMpfWNhdGNoKHZhKXtiPXZhO1k9PT1jJiZudWxsIT09YyYmKFk9Yz1jLnJldHVybik7Y29udGludWV9YnJlYWt9d2hpbGUoMSl9XG5mdW5jdGlvbiBQaigpe3ZhciBhPW9qLmN1cnJlbnQ7b2ouY3VycmVudD1HaDtyZXR1cm4gbnVsbD09PWE/R2g6YX1mdW5jdGlvbiBUaihhLGIpe3ZhciBjPVg7WHw9MTY7dmFyIGQ9UGooKTtVPT09YSYmVz09PWJ8fFFqKGEsYik7ZG8gdHJ5e2FrKCk7YnJlYWt9Y2F0Y2goZSl7U2ooYSxlKX13aGlsZSgxKTtxZygpO1g9Yztvai5jdXJyZW50PWQ7aWYobnVsbCE9PVkpdGhyb3cgRXJyb3IoeSgyNjEpKTtVPW51bGw7Vz0wO3JldHVybiBWfWZ1bmN0aW9uIGFrKCl7Zm9yKDtudWxsIT09WTspYmsoWSl9ZnVuY3Rpb24gUmooKXtmb3IoO251bGwhPT1ZJiYhUWYoKTspYmsoWSl9ZnVuY3Rpb24gYmsoYSl7dmFyIGI9Y2soYS5hbHRlcm5hdGUsYSxxaik7YS5tZW1vaXplZFByb3BzPWEucGVuZGluZ1Byb3BzO251bGw9PT1iP1pqKGEpOlk9Yjtwai5jdXJyZW50PW51bGx9XG5mdW5jdGlvbiBaaihhKXt2YXIgYj1hO2Rve3ZhciBjPWIuYWx0ZXJuYXRlO2E9Yi5yZXR1cm47aWYoMD09PShiLmZsYWdzJjIwNDgpKXtjPUdpKGMsYixxaik7aWYobnVsbCE9PWMpe1k9YztyZXR1cm59Yz1iO2lmKDI0IT09Yy50YWcmJjIzIT09Yy50YWd8fG51bGw9PT1jLm1lbW9pemVkU3RhdGV8fDAhPT0ocWomMTA3Mzc0MTgyNCl8fDA9PT0oYy5tb2RlJjQpKXtmb3IodmFyIGQ9MCxlPWMuY2hpbGQ7bnVsbCE9PWU7KWR8PWUubGFuZXN8ZS5jaGlsZExhbmVzLGU9ZS5zaWJsaW5nO2MuY2hpbGRMYW5lcz1kfW51bGwhPT1hJiYwPT09KGEuZmxhZ3MmMjA0OCkmJihudWxsPT09YS5maXJzdEVmZmVjdCYmKGEuZmlyc3RFZmZlY3Q9Yi5maXJzdEVmZmVjdCksbnVsbCE9PWIubGFzdEVmZmVjdCYmKG51bGwhPT1hLmxhc3RFZmZlY3QmJihhLmxhc3RFZmZlY3QubmV4dEVmZmVjdD1iLmZpcnN0RWZmZWN0KSxhLmxhc3RFZmZlY3Q9Yi5sYXN0RWZmZWN0KSwxPGIuZmxhZ3MmJihudWxsIT09XG5hLmxhc3RFZmZlY3Q/YS5sYXN0RWZmZWN0Lm5leHRFZmZlY3Q9YjphLmZpcnN0RWZmZWN0PWIsYS5sYXN0RWZmZWN0PWIpKX1lbHNle2M9TGkoYik7aWYobnVsbCE9PWMpe2MuZmxhZ3MmPTIwNDc7WT1jO3JldHVybn1udWxsIT09YSYmKGEuZmlyc3RFZmZlY3Q9YS5sYXN0RWZmZWN0PW51bGwsYS5mbGFnc3w9MjA0OCl9Yj1iLnNpYmxpbmc7aWYobnVsbCE9PWIpe1k9YjtyZXR1cm59WT1iPWF9d2hpbGUobnVsbCE9PWIpOzA9PT1WJiYoVj01KX1mdW5jdGlvbiBVaihhKXt2YXIgYj1lZygpO2dnKDk5LGRrLmJpbmQobnVsbCxhLGIpKTtyZXR1cm4gbnVsbH1cbmZ1bmN0aW9uIGRrKGEsYil7ZG8gT2ooKTt3aGlsZShudWxsIT09eWopO2lmKDAhPT0oWCY0OCkpdGhyb3cgRXJyb3IoeSgzMjcpKTt2YXIgYz1hLmZpbmlzaGVkV29yaztpZihudWxsPT09YylyZXR1cm4gbnVsbDthLmZpbmlzaGVkV29yaz1udWxsO2EuZmluaXNoZWRMYW5lcz0wO2lmKGM9PT1hLmN1cnJlbnQpdGhyb3cgRXJyb3IoeSgxNzcpKTthLmNhbGxiYWNrTm9kZT1udWxsO3ZhciBkPWMubGFuZXN8Yy5jaGlsZExhbmVzLGU9ZCxmPWEucGVuZGluZ0xhbmVzJn5lO2EucGVuZGluZ0xhbmVzPWU7YS5zdXNwZW5kZWRMYW5lcz0wO2EucGluZ2VkTGFuZXM9MDthLmV4cGlyZWRMYW5lcyY9ZTthLm11dGFibGVSZWFkTGFuZXMmPWU7YS5lbnRhbmdsZWRMYW5lcyY9ZTtlPWEuZW50YW5nbGVtZW50cztmb3IodmFyIGc9YS5ldmVudFRpbWVzLGg9YS5leHBpcmF0aW9uVGltZXM7MDxmOyl7dmFyIGs9MzEtVmMoZiksbD0xPDxrO2Vba109MDtnW2tdPS0xO2hba109LTE7ZiY9fmx9bnVsbCE9PVxuQ2omJjA9PT0oZCYyNCkmJkNqLmhhcyhhKSYmQ2ouZGVsZXRlKGEpO2E9PT1VJiYoWT1VPW51bGwsVz0wKTsxPGMuZmxhZ3M/bnVsbCE9PWMubGFzdEVmZmVjdD8oYy5sYXN0RWZmZWN0Lm5leHRFZmZlY3Q9YyxkPWMuZmlyc3RFZmZlY3QpOmQ9YzpkPWMuZmlyc3RFZmZlY3Q7aWYobnVsbCE9PWQpe2U9WDtYfD0zMjtwai5jdXJyZW50PW51bGw7a2Y9ZmQ7Zz1OZSgpO2lmKE9lKGcpKXtpZihcInNlbGVjdGlvblN0YXJ0XCJpbiBnKWg9e3N0YXJ0Omcuc2VsZWN0aW9uU3RhcnQsZW5kOmcuc2VsZWN0aW9uRW5kfTtlbHNlIGE6aWYoaD0oaD1nLm93bmVyRG9jdW1lbnQpJiZoLmRlZmF1bHRWaWV3fHx3aW5kb3csKGw9aC5nZXRTZWxlY3Rpb24mJmguZ2V0U2VsZWN0aW9uKCkpJiYwIT09bC5yYW5nZUNvdW50KXtoPWwuYW5jaG9yTm9kZTtmPWwuYW5jaG9yT2Zmc2V0O2s9bC5mb2N1c05vZGU7bD1sLmZvY3VzT2Zmc2V0O3RyeXtoLm5vZGVUeXBlLGsubm9kZVR5cGV9Y2F0Y2godmEpe2g9bnVsbDtcbmJyZWFrIGF9dmFyIG49MCxBPS0xLHA9LTEsQz0wLHg9MCx3PWcsej1udWxsO2I6Zm9yKDs7KXtmb3IodmFyIHU7Oyl7dyE9PWh8fDAhPT1mJiYzIT09dy5ub2RlVHlwZXx8KEE9bitmKTt3IT09a3x8MCE9PWwmJjMhPT13Lm5vZGVUeXBlfHwocD1uK2wpOzM9PT13Lm5vZGVUeXBlJiYobis9dy5ub2RlVmFsdWUubGVuZ3RoKTtpZihudWxsPT09KHU9dy5maXJzdENoaWxkKSlicmVhazt6PXc7dz11fWZvcig7Oyl7aWYodz09PWcpYnJlYWsgYjt6PT09aCYmKytDPT09ZiYmKEE9bik7ej09PWsmJisreD09PWwmJihwPW4pO2lmKG51bGwhPT0odT13Lm5leHRTaWJsaW5nKSlicmVhazt3PXo7ej13LnBhcmVudE5vZGV9dz11fWg9LTE9PT1BfHwtMT09PXA/bnVsbDp7c3RhcnQ6QSxlbmQ6cH19ZWxzZSBoPW51bGw7aD1ofHx7c3RhcnQ6MCxlbmQ6MH19ZWxzZSBoPW51bGw7bGY9e2ZvY3VzZWRFbGVtOmcsc2VsZWN0aW9uUmFuZ2U6aH07ZmQ9ITE7SWo9bnVsbDtKaj0hMTtaPWQ7ZG8gdHJ5e2VrKCl9Y2F0Y2godmEpe2lmKG51bGw9PT1cblopdGhyb3cgRXJyb3IoeSgzMzApKTtXaShaLHZhKTtaPVoubmV4dEVmZmVjdH13aGlsZShudWxsIT09Wik7SWo9bnVsbDtaPWQ7ZG8gdHJ5e2ZvcihnPWE7bnVsbCE9PVo7KXt2YXIgdD1aLmZsYWdzO3QmMTYmJnBiKFouc3RhdGVOb2RlLFwiXCIpO2lmKHQmMTI4KXt2YXIgcT1aLmFsdGVybmF0ZTtpZihudWxsIT09cSl7dmFyIHY9cS5yZWY7bnVsbCE9PXYmJihcImZ1bmN0aW9uXCI9PT10eXBlb2Ygdj92KG51bGwpOnYuY3VycmVudD1udWxsKX19c3dpdGNoKHQmMTAzOCl7Y2FzZSAyOmZqKFopO1ouZmxhZ3MmPS0zO2JyZWFrO2Nhc2UgNjpmaihaKTtaLmZsYWdzJj0tMztpaihaLmFsdGVybmF0ZSxaKTticmVhaztjYXNlIDEwMjQ6Wi5mbGFncyY9LTEwMjU7YnJlYWs7Y2FzZSAxMDI4OlouZmxhZ3MmPS0xMDI1O2lqKFouYWx0ZXJuYXRlLFopO2JyZWFrO2Nhc2UgNDppaihaLmFsdGVybmF0ZSxaKTticmVhaztjYXNlIDg6aD1aO2NqKGcsaCk7dmFyIEo9aC5hbHRlcm5hdGU7ZGooaCk7bnVsbCE9PVxuSiYmZGooSil9Wj1aLm5leHRFZmZlY3R9fWNhdGNoKHZhKXtpZihudWxsPT09Wil0aHJvdyBFcnJvcih5KDMzMCkpO1dpKFosdmEpO1o9Wi5uZXh0RWZmZWN0fXdoaWxlKG51bGwhPT1aKTt2PWxmO3E9TmUoKTt0PXYuZm9jdXNlZEVsZW07Zz12LnNlbGVjdGlvblJhbmdlO2lmKHEhPT10JiZ0JiZ0Lm93bmVyRG9jdW1lbnQmJk1lKHQub3duZXJEb2N1bWVudC5kb2N1bWVudEVsZW1lbnQsdCkpe251bGwhPT1nJiZPZSh0KSYmKHE9Zy5zdGFydCx2PWcuZW5kLHZvaWQgMD09PXYmJih2PXEpLFwic2VsZWN0aW9uU3RhcnRcImluIHQ/KHQuc2VsZWN0aW9uU3RhcnQ9cSx0LnNlbGVjdGlvbkVuZD1NYXRoLm1pbih2LHQudmFsdWUubGVuZ3RoKSk6KHY9KHE9dC5vd25lckRvY3VtZW50fHxkb2N1bWVudCkmJnEuZGVmYXVsdFZpZXd8fHdpbmRvdyx2LmdldFNlbGVjdGlvbiYmKHY9di5nZXRTZWxlY3Rpb24oKSxoPXQudGV4dENvbnRlbnQubGVuZ3RoLEo9TWF0aC5taW4oZy5zdGFydCxoKSxnPXZvaWQgMD09PVxuZy5lbmQ/SjpNYXRoLm1pbihnLmVuZCxoKSwhdi5leHRlbmQmJko+ZyYmKGg9ZyxnPUosSj1oKSxoPUxlKHQsSiksZj1MZSh0LGcpLGgmJmYmJigxIT09di5yYW5nZUNvdW50fHx2LmFuY2hvck5vZGUhPT1oLm5vZGV8fHYuYW5jaG9yT2Zmc2V0IT09aC5vZmZzZXR8fHYuZm9jdXNOb2RlIT09Zi5ub2RlfHx2LmZvY3VzT2Zmc2V0IT09Zi5vZmZzZXQpJiYocT1xLmNyZWF0ZVJhbmdlKCkscS5zZXRTdGFydChoLm5vZGUsaC5vZmZzZXQpLHYucmVtb3ZlQWxsUmFuZ2VzKCksSj5nPyh2LmFkZFJhbmdlKHEpLHYuZXh0ZW5kKGYubm9kZSxmLm9mZnNldCkpOihxLnNldEVuZChmLm5vZGUsZi5vZmZzZXQpLHYuYWRkUmFuZ2UocSkpKSkpKTtxPVtdO2Zvcih2PXQ7dj12LnBhcmVudE5vZGU7KTE9PT12Lm5vZGVUeXBlJiZxLnB1c2goe2VsZW1lbnQ6dixsZWZ0OnYuc2Nyb2xsTGVmdCx0b3A6di5zY3JvbGxUb3B9KTtcImZ1bmN0aW9uXCI9PT10eXBlb2YgdC5mb2N1cyYmdC5mb2N1cygpO2Zvcih0PVxuMDt0PHEubGVuZ3RoO3QrKyl2PXFbdF0sdi5lbGVtZW50LnNjcm9sbExlZnQ9di5sZWZ0LHYuZWxlbWVudC5zY3JvbGxUb3A9di50b3B9ZmQ9ISFrZjtsZj1rZj1udWxsO2EuY3VycmVudD1jO1o9ZDtkbyB0cnl7Zm9yKHQ9YTtudWxsIT09Wjspe3ZhciBLPVouZmxhZ3M7SyYzNiYmWWkodCxaLmFsdGVybmF0ZSxaKTtpZihLJjEyOCl7cT12b2lkIDA7dmFyIFE9Wi5yZWY7aWYobnVsbCE9PVEpe3ZhciBMPVouc3RhdGVOb2RlO3N3aXRjaChaLnRhZyl7Y2FzZSA1OnE9TDticmVhaztkZWZhdWx0OnE9TH1cImZ1bmN0aW9uXCI9PT10eXBlb2YgUT9RKHEpOlEuY3VycmVudD1xfX1aPVoubmV4dEVmZmVjdH19Y2F0Y2godmEpe2lmKG51bGw9PT1aKXRocm93IEVycm9yKHkoMzMwKSk7V2koWix2YSk7Wj1aLm5leHRFZmZlY3R9d2hpbGUobnVsbCE9PVopO1o9bnVsbDskZigpO1g9ZX1lbHNlIGEuY3VycmVudD1jO2lmKHhqKXhqPSExLHlqPWEsemo9YjtlbHNlIGZvcihaPWQ7bnVsbCE9PVo7KWI9XG5aLm5leHRFZmZlY3QsWi5uZXh0RWZmZWN0PW51bGwsWi5mbGFncyY4JiYoSz1aLEsuc2libGluZz1udWxsLEsuc3RhdGVOb2RlPW51bGwpLFo9YjtkPWEucGVuZGluZ0xhbmVzOzA9PT1kJiYoVGk9bnVsbCk7MT09PWQ/YT09PUVqP0RqKys6KERqPTAsRWo9YSk6RGo9MDtjPWMuc3RhdGVOb2RlO2lmKE1mJiZcImZ1bmN0aW9uXCI9PT10eXBlb2YgTWYub25Db21taXRGaWJlclJvb3QpdHJ5e01mLm9uQ29tbWl0RmliZXJSb290KExmLGMsdm9pZCAwLDY0PT09KGMuY3VycmVudC5mbGFncyY2NCkpfWNhdGNoKHZhKXt9TWooYSxPKCkpO2lmKFFpKXRocm93IFFpPSExLGE9UmksUmk9bnVsbCxhO2lmKDAhPT0oWCY4KSlyZXR1cm4gbnVsbDtpZygpO3JldHVybiBudWxsfVxuZnVuY3Rpb24gZWsoKXtmb3IoO251bGwhPT1aOyl7dmFyIGE9Wi5hbHRlcm5hdGU7Smp8fG51bGw9PT1Janx8KDAhPT0oWi5mbGFncyY4KT9kYyhaLElqKSYmKEpqPSEwKToxMz09PVoudGFnJiZtaihhLFopJiZkYyhaLElqKSYmKEpqPSEwKSk7dmFyIGI9Wi5mbGFnczswIT09KGImMjU2KSYmWGkoYSxaKTswPT09KGImNTEyKXx8eGp8fCh4aj0hMCxoZyg5NyxmdW5jdGlvbigpe09qKCk7cmV0dXJuIG51bGx9KSk7Wj1aLm5leHRFZmZlY3R9fWZ1bmN0aW9uIE9qKCl7aWYoOTAhPT16ail7dmFyIGE9OTc8emo/OTc6emo7emo9OTA7cmV0dXJuIGdnKGEsZmspfXJldHVybiExfWZ1bmN0aW9uICRpKGEsYil7QWoucHVzaChiLGEpO3hqfHwoeGo9ITAsaGcoOTcsZnVuY3Rpb24oKXtPaigpO3JldHVybiBudWxsfSkpfWZ1bmN0aW9uIFppKGEsYil7QmoucHVzaChiLGEpO3hqfHwoeGo9ITAsaGcoOTcsZnVuY3Rpb24oKXtPaigpO3JldHVybiBudWxsfSkpfVxuZnVuY3Rpb24gZmsoKXtpZihudWxsPT09eWopcmV0dXJuITE7dmFyIGE9eWo7eWo9bnVsbDtpZigwIT09KFgmNDgpKXRocm93IEVycm9yKHkoMzMxKSk7dmFyIGI9WDtYfD0zMjt2YXIgYz1CajtCaj1bXTtmb3IodmFyIGQ9MDtkPGMubGVuZ3RoO2QrPTIpe3ZhciBlPWNbZF0sZj1jW2QrMV0sZz1lLmRlc3Ryb3k7ZS5kZXN0cm95PXZvaWQgMDtpZihcImZ1bmN0aW9uXCI9PT10eXBlb2YgZyl0cnl7ZygpfWNhdGNoKGspe2lmKG51bGw9PT1mKXRocm93IEVycm9yKHkoMzMwKSk7V2koZixrKX19Yz1BajtBaj1bXTtmb3IoZD0wO2Q8Yy5sZW5ndGg7ZCs9Mil7ZT1jW2RdO2Y9Y1tkKzFdO3RyeXt2YXIgaD1lLmNyZWF0ZTtlLmRlc3Ryb3k9aCgpfWNhdGNoKGspe2lmKG51bGw9PT1mKXRocm93IEVycm9yKHkoMzMwKSk7V2koZixrKX19Zm9yKGg9YS5jdXJyZW50LmZpcnN0RWZmZWN0O251bGwhPT1oOylhPWgubmV4dEVmZmVjdCxoLm5leHRFZmZlY3Q9bnVsbCxoLmZsYWdzJjgmJihoLnNpYmxpbmc9XG5udWxsLGguc3RhdGVOb2RlPW51bGwpLGg9YTtYPWI7aWcoKTtyZXR1cm4hMH1mdW5jdGlvbiBnayhhLGIsYyl7Yj1NaShjLGIpO2I9UGkoYSxiLDEpO0FnKGEsYik7Yj1IZygpO2E9S2ooYSwxKTtudWxsIT09YSYmKCRjKGEsMSxiKSxNaihhLGIpKX1cbmZ1bmN0aW9uIFdpKGEsYil7aWYoMz09PWEudGFnKWdrKGEsYSxiKTtlbHNlIGZvcih2YXIgYz1hLnJldHVybjtudWxsIT09Yzspe2lmKDM9PT1jLnRhZyl7Z2soYyxhLGIpO2JyZWFrfWVsc2UgaWYoMT09PWMudGFnKXt2YXIgZD1jLnN0YXRlTm9kZTtpZihcImZ1bmN0aW9uXCI9PT10eXBlb2YgYy50eXBlLmdldERlcml2ZWRTdGF0ZUZyb21FcnJvcnx8XCJmdW5jdGlvblwiPT09dHlwZW9mIGQuY29tcG9uZW50RGlkQ2F0Y2gmJihudWxsPT09VGl8fCFUaS5oYXMoZCkpKXthPU1pKGIsYSk7dmFyIGU9U2koYyxhLDEpO0FnKGMsZSk7ZT1IZygpO2M9S2ooYywxKTtpZihudWxsIT09YykkYyhjLDEsZSksTWooYyxlKTtlbHNlIGlmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBkLmNvbXBvbmVudERpZENhdGNoJiYobnVsbD09PVRpfHwhVGkuaGFzKGQpKSl0cnl7ZC5jb21wb25lbnREaWRDYXRjaChiLGEpfWNhdGNoKGYpe31icmVha319Yz1jLnJldHVybn19XG5mdW5jdGlvbiBZaihhLGIsYyl7dmFyIGQ9YS5waW5nQ2FjaGU7bnVsbCE9PWQmJmQuZGVsZXRlKGIpO2I9SGcoKTthLnBpbmdlZExhbmVzfD1hLnN1c3BlbmRlZExhbmVzJmM7VT09PWEmJihXJmMpPT09YyYmKDQ9PT1WfHwzPT09ViYmKFcmNjI5MTQ1NjApPT09VyYmNTAwPk8oKS1qaj9RaihhLDApOnVqfD1jKTtNaihhLGIpfWZ1bmN0aW9uIGxqKGEsYil7dmFyIGM9YS5zdGF0ZU5vZGU7bnVsbCE9PWMmJmMuZGVsZXRlKGIpO2I9MDswPT09YiYmKGI9YS5tb2RlLDA9PT0oYiYyKT9iPTE6MD09PShiJjQpP2I9OTk9PT1lZygpPzE6MjooMD09PUdqJiYoR2o9dGopLGI9WWMoNjI5MTQ1NjAmfkdqKSwwPT09YiYmKGI9NDE5NDMwNCkpKTtjPUhnKCk7YT1LaihhLGIpO251bGwhPT1hJiYoJGMoYSxiLGMpLE1qKGEsYykpfXZhciBjaztcbmNrPWZ1bmN0aW9uKGEsYixjKXt2YXIgZD1iLmxhbmVzO2lmKG51bGwhPT1hKWlmKGEubWVtb2l6ZWRQcm9wcyE9PWIucGVuZGluZ1Byb3BzfHxOLmN1cnJlbnQpdWc9ITA7ZWxzZSBpZigwIT09KGMmZCkpdWc9MCE9PShhLmZsYWdzJjE2Mzg0KT8hMDohMTtlbHNle3VnPSExO3N3aXRjaChiLnRhZyl7Y2FzZSAzOnJpKGIpO3NoKCk7YnJlYWs7Y2FzZSA1OmdoKGIpO2JyZWFrO2Nhc2UgMTpGZihiLnR5cGUpJiZKZihiKTticmVhaztjYXNlIDQ6ZWgoYixiLnN0YXRlTm9kZS5jb250YWluZXJJbmZvKTticmVhaztjYXNlIDEwOmQ9Yi5tZW1vaXplZFByb3BzLnZhbHVlO3ZhciBlPWIudHlwZS5fY29udGV4dDtJKG1nLGUuX2N1cnJlbnRWYWx1ZSk7ZS5fY3VycmVudFZhbHVlPWQ7YnJlYWs7Y2FzZSAxMzppZihudWxsIT09Yi5tZW1vaXplZFN0YXRlKXtpZigwIT09KGMmYi5jaGlsZC5jaGlsZExhbmVzKSlyZXR1cm4gdGkoYSxiLGMpO0koUCxQLmN1cnJlbnQmMSk7Yj1oaShhLGIsYyk7cmV0dXJuIG51bGwhPT1cbmI/Yi5zaWJsaW5nOm51bGx9SShQLFAuY3VycmVudCYxKTticmVhaztjYXNlIDE5OmQ9MCE9PShjJmIuY2hpbGRMYW5lcyk7aWYoMCE9PShhLmZsYWdzJjY0KSl7aWYoZClyZXR1cm4gQWkoYSxiLGMpO2IuZmxhZ3N8PTY0fWU9Yi5tZW1vaXplZFN0YXRlO251bGwhPT1lJiYoZS5yZW5kZXJpbmc9bnVsbCxlLnRhaWw9bnVsbCxlLmxhc3RFZmZlY3Q9bnVsbCk7SShQLFAuY3VycmVudCk7aWYoZClicmVhaztlbHNlIHJldHVybiBudWxsO2Nhc2UgMjM6Y2FzZSAyNDpyZXR1cm4gYi5sYW5lcz0wLG1pKGEsYixjKX1yZXR1cm4gaGkoYSxiLGMpfWVsc2UgdWc9ITE7Yi5sYW5lcz0wO3N3aXRjaChiLnRhZyl7Y2FzZSAyOmQ9Yi50eXBlO251bGwhPT1hJiYoYS5hbHRlcm5hdGU9bnVsbCxiLmFsdGVybmF0ZT1udWxsLGIuZmxhZ3N8PTIpO2E9Yi5wZW5kaW5nUHJvcHM7ZT1FZihiLE0uY3VycmVudCk7dGcoYixjKTtlPUNoKG51bGwsYixkLGEsZSxjKTtiLmZsYWdzfD0xO2lmKFwib2JqZWN0XCI9PT1cbnR5cGVvZiBlJiZudWxsIT09ZSYmXCJmdW5jdGlvblwiPT09dHlwZW9mIGUucmVuZGVyJiZ2b2lkIDA9PT1lLiQkdHlwZW9mKXtiLnRhZz0xO2IubWVtb2l6ZWRTdGF0ZT1udWxsO2IudXBkYXRlUXVldWU9bnVsbDtpZihGZihkKSl7dmFyIGY9ITA7SmYoYil9ZWxzZSBmPSExO2IubWVtb2l6ZWRTdGF0ZT1udWxsIT09ZS5zdGF0ZSYmdm9pZCAwIT09ZS5zdGF0ZT9lLnN0YXRlOm51bGw7eGcoYik7dmFyIGc9ZC5nZXREZXJpdmVkU3RhdGVGcm9tUHJvcHM7XCJmdW5jdGlvblwiPT09dHlwZW9mIGcmJkdnKGIsZCxnLGEpO2UudXBkYXRlcj1LZztiLnN0YXRlTm9kZT1lO2UuX3JlYWN0SW50ZXJuYWxzPWI7T2coYixkLGEsYyk7Yj1xaShudWxsLGIsZCwhMCxmLGMpfWVsc2UgYi50YWc9MCxmaShudWxsLGIsZSxjKSxiPWIuY2hpbGQ7cmV0dXJuIGI7Y2FzZSAxNjplPWIuZWxlbWVudFR5cGU7YTp7bnVsbCE9PWEmJihhLmFsdGVybmF0ZT1udWxsLGIuYWx0ZXJuYXRlPW51bGwsYi5mbGFnc3w9Mik7XG5hPWIucGVuZGluZ1Byb3BzO2Y9ZS5faW5pdDtlPWYoZS5fcGF5bG9hZCk7Yi50eXBlPWU7Zj1iLnRhZz1oayhlKTthPWxnKGUsYSk7c3dpdGNoKGYpe2Nhc2UgMDpiPWxpKG51bGwsYixlLGEsYyk7YnJlYWsgYTtjYXNlIDE6Yj1waShudWxsLGIsZSxhLGMpO2JyZWFrIGE7Y2FzZSAxMTpiPWdpKG51bGwsYixlLGEsYyk7YnJlYWsgYTtjYXNlIDE0OmI9aWkobnVsbCxiLGUsbGcoZS50eXBlLGEpLGQsYyk7YnJlYWsgYX10aHJvdyBFcnJvcih5KDMwNixlLFwiXCIpKTt9cmV0dXJuIGI7Y2FzZSAwOnJldHVybiBkPWIudHlwZSxlPWIucGVuZGluZ1Byb3BzLGU9Yi5lbGVtZW50VHlwZT09PWQ/ZTpsZyhkLGUpLGxpKGEsYixkLGUsYyk7Y2FzZSAxOnJldHVybiBkPWIudHlwZSxlPWIucGVuZGluZ1Byb3BzLGU9Yi5lbGVtZW50VHlwZT09PWQ/ZTpsZyhkLGUpLHBpKGEsYixkLGUsYyk7Y2FzZSAzOnJpKGIpO2Q9Yi51cGRhdGVRdWV1ZTtpZihudWxsPT09YXx8bnVsbD09PWQpdGhyb3cgRXJyb3IoeSgyODIpKTtcbmQ9Yi5wZW5kaW5nUHJvcHM7ZT1iLm1lbW9pemVkU3RhdGU7ZT1udWxsIT09ZT9lLmVsZW1lbnQ6bnVsbDt5ZyhhLGIpO0NnKGIsZCxudWxsLGMpO2Q9Yi5tZW1vaXplZFN0YXRlLmVsZW1lbnQ7aWYoZD09PWUpc2goKSxiPWhpKGEsYixjKTtlbHNle2U9Yi5zdGF0ZU5vZGU7aWYoZj1lLmh5ZHJhdGUpa2g9cmYoYi5zdGF0ZU5vZGUuY29udGFpbmVySW5mby5maXJzdENoaWxkKSxqaD1iLGY9bGg9ITA7aWYoZil7YT1lLm11dGFibGVTb3VyY2VFYWdlckh5ZHJhdGlvbkRhdGE7aWYobnVsbCE9YSlmb3IoZT0wO2U8YS5sZW5ndGg7ZSs9MilmPWFbZV0sZi5fd29ya0luUHJvZ3Jlc3NWZXJzaW9uUHJpbWFyeT1hW2UrMV0sdGgucHVzaChmKTtjPVpnKGIsbnVsbCxkLGMpO2ZvcihiLmNoaWxkPWM7YzspYy5mbGFncz1jLmZsYWdzJi0zfDEwMjQsYz1jLnNpYmxpbmd9ZWxzZSBmaShhLGIsZCxjKSxzaCgpO2I9Yi5jaGlsZH1yZXR1cm4gYjtjYXNlIDU6cmV0dXJuIGdoKGIpLG51bGw9PT1hJiZcbnBoKGIpLGQ9Yi50eXBlLGU9Yi5wZW5kaW5nUHJvcHMsZj1udWxsIT09YT9hLm1lbW9pemVkUHJvcHM6bnVsbCxnPWUuY2hpbGRyZW4sbmYoZCxlKT9nPW51bGw6bnVsbCE9PWYmJm5mKGQsZikmJihiLmZsYWdzfD0xNiksb2koYSxiKSxmaShhLGIsZyxjKSxiLmNoaWxkO2Nhc2UgNjpyZXR1cm4gbnVsbD09PWEmJnBoKGIpLG51bGw7Y2FzZSAxMzpyZXR1cm4gdGkoYSxiLGMpO2Nhc2UgNDpyZXR1cm4gZWgoYixiLnN0YXRlTm9kZS5jb250YWluZXJJbmZvKSxkPWIucGVuZGluZ1Byb3BzLG51bGw9PT1hP2IuY2hpbGQ9WWcoYixudWxsLGQsYyk6ZmkoYSxiLGQsYyksYi5jaGlsZDtjYXNlIDExOnJldHVybiBkPWIudHlwZSxlPWIucGVuZGluZ1Byb3BzLGU9Yi5lbGVtZW50VHlwZT09PWQ/ZTpsZyhkLGUpLGdpKGEsYixkLGUsYyk7Y2FzZSA3OnJldHVybiBmaShhLGIsYi5wZW5kaW5nUHJvcHMsYyksYi5jaGlsZDtjYXNlIDg6cmV0dXJuIGZpKGEsYixiLnBlbmRpbmdQcm9wcy5jaGlsZHJlbixcbmMpLGIuY2hpbGQ7Y2FzZSAxMjpyZXR1cm4gZmkoYSxiLGIucGVuZGluZ1Byb3BzLmNoaWxkcmVuLGMpLGIuY2hpbGQ7Y2FzZSAxMDphOntkPWIudHlwZS5fY29udGV4dDtlPWIucGVuZGluZ1Byb3BzO2c9Yi5tZW1vaXplZFByb3BzO2Y9ZS52YWx1ZTt2YXIgaD1iLnR5cGUuX2NvbnRleHQ7SShtZyxoLl9jdXJyZW50VmFsdWUpO2guX2N1cnJlbnRWYWx1ZT1mO2lmKG51bGwhPT1nKWlmKGg9Zy52YWx1ZSxmPUhlKGgsZik/MDooXCJmdW5jdGlvblwiPT09dHlwZW9mIGQuX2NhbGN1bGF0ZUNoYW5nZWRCaXRzP2QuX2NhbGN1bGF0ZUNoYW5nZWRCaXRzKGgsZik6MTA3Mzc0MTgyMyl8MCwwPT09Zil7aWYoZy5jaGlsZHJlbj09PWUuY2hpbGRyZW4mJiFOLmN1cnJlbnQpe2I9aGkoYSxiLGMpO2JyZWFrIGF9fWVsc2UgZm9yKGg9Yi5jaGlsZCxudWxsIT09aCYmKGgucmV0dXJuPWIpO251bGwhPT1oOyl7dmFyIGs9aC5kZXBlbmRlbmNpZXM7aWYobnVsbCE9PWspe2c9aC5jaGlsZDtmb3IodmFyIGw9XG5rLmZpcnN0Q29udGV4dDtudWxsIT09bDspe2lmKGwuY29udGV4dD09PWQmJjAhPT0obC5vYnNlcnZlZEJpdHMmZikpezE9PT1oLnRhZyYmKGw9emcoLTEsYyYtYyksbC50YWc9MixBZyhoLGwpKTtoLmxhbmVzfD1jO2w9aC5hbHRlcm5hdGU7bnVsbCE9PWwmJihsLmxhbmVzfD1jKTtzZyhoLnJldHVybixjKTtrLmxhbmVzfD1jO2JyZWFrfWw9bC5uZXh0fX1lbHNlIGc9MTA9PT1oLnRhZz9oLnR5cGU9PT1iLnR5cGU/bnVsbDpoLmNoaWxkOmguY2hpbGQ7aWYobnVsbCE9PWcpZy5yZXR1cm49aDtlbHNlIGZvcihnPWg7bnVsbCE9PWc7KXtpZihnPT09Yil7Zz1udWxsO2JyZWFrfWg9Zy5zaWJsaW5nO2lmKG51bGwhPT1oKXtoLnJldHVybj1nLnJldHVybjtnPWg7YnJlYWt9Zz1nLnJldHVybn1oPWd9ZmkoYSxiLGUuY2hpbGRyZW4sYyk7Yj1iLmNoaWxkfXJldHVybiBiO2Nhc2UgOTpyZXR1cm4gZT1iLnR5cGUsZj1iLnBlbmRpbmdQcm9wcyxkPWYuY2hpbGRyZW4sdGcoYixjKSxlPXZnKGUsXG5mLnVuc3RhYmxlX29ic2VydmVkQml0cyksZD1kKGUpLGIuZmxhZ3N8PTEsZmkoYSxiLGQsYyksYi5jaGlsZDtjYXNlIDE0OnJldHVybiBlPWIudHlwZSxmPWxnKGUsYi5wZW5kaW5nUHJvcHMpLGY9bGcoZS50eXBlLGYpLGlpKGEsYixlLGYsZCxjKTtjYXNlIDE1OnJldHVybiBraShhLGIsYi50eXBlLGIucGVuZGluZ1Byb3BzLGQsYyk7Y2FzZSAxNzpyZXR1cm4gZD1iLnR5cGUsZT1iLnBlbmRpbmdQcm9wcyxlPWIuZWxlbWVudFR5cGU9PT1kP2U6bGcoZCxlKSxudWxsIT09YSYmKGEuYWx0ZXJuYXRlPW51bGwsYi5hbHRlcm5hdGU9bnVsbCxiLmZsYWdzfD0yKSxiLnRhZz0xLEZmKGQpPyhhPSEwLEpmKGIpKTphPSExLHRnKGIsYyksTWcoYixkLGUpLE9nKGIsZCxlLGMpLHFpKG51bGwsYixkLCEwLGEsYyk7Y2FzZSAxOTpyZXR1cm4gQWkoYSxiLGMpO2Nhc2UgMjM6cmV0dXJuIG1pKGEsYixjKTtjYXNlIDI0OnJldHVybiBtaShhLGIsYyl9dGhyb3cgRXJyb3IoeSgxNTYsYi50YWcpKTtcbn07ZnVuY3Rpb24gaWsoYSxiLGMsZCl7dGhpcy50YWc9YTt0aGlzLmtleT1jO3RoaXMuc2libGluZz10aGlzLmNoaWxkPXRoaXMucmV0dXJuPXRoaXMuc3RhdGVOb2RlPXRoaXMudHlwZT10aGlzLmVsZW1lbnRUeXBlPW51bGw7dGhpcy5pbmRleD0wO3RoaXMucmVmPW51bGw7dGhpcy5wZW5kaW5nUHJvcHM9Yjt0aGlzLmRlcGVuZGVuY2llcz10aGlzLm1lbW9pemVkU3RhdGU9dGhpcy51cGRhdGVRdWV1ZT10aGlzLm1lbW9pemVkUHJvcHM9bnVsbDt0aGlzLm1vZGU9ZDt0aGlzLmZsYWdzPTA7dGhpcy5sYXN0RWZmZWN0PXRoaXMuZmlyc3RFZmZlY3Q9dGhpcy5uZXh0RWZmZWN0PW51bGw7dGhpcy5jaGlsZExhbmVzPXRoaXMubGFuZXM9MDt0aGlzLmFsdGVybmF0ZT1udWxsfWZ1bmN0aW9uIG5oKGEsYixjLGQpe3JldHVybiBuZXcgaWsoYSxiLGMsZCl9ZnVuY3Rpb24gamkoYSl7YT1hLnByb3RvdHlwZTtyZXR1cm4hKCFhfHwhYS5pc1JlYWN0Q29tcG9uZW50KX1cbmZ1bmN0aW9uIGhrKGEpe2lmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBhKXJldHVybiBqaShhKT8xOjA7aWYodm9pZCAwIT09YSYmbnVsbCE9PWEpe2E9YS4kJHR5cGVvZjtpZihhPT09QWEpcmV0dXJuIDExO2lmKGE9PT1EYSlyZXR1cm4gMTR9cmV0dXJuIDJ9XG5mdW5jdGlvbiBUZyhhLGIpe3ZhciBjPWEuYWx0ZXJuYXRlO251bGw9PT1jPyhjPW5oKGEudGFnLGIsYS5rZXksYS5tb2RlKSxjLmVsZW1lbnRUeXBlPWEuZWxlbWVudFR5cGUsYy50eXBlPWEudHlwZSxjLnN0YXRlTm9kZT1hLnN0YXRlTm9kZSxjLmFsdGVybmF0ZT1hLGEuYWx0ZXJuYXRlPWMpOihjLnBlbmRpbmdQcm9wcz1iLGMudHlwZT1hLnR5cGUsYy5mbGFncz0wLGMubmV4dEVmZmVjdD1udWxsLGMuZmlyc3RFZmZlY3Q9bnVsbCxjLmxhc3RFZmZlY3Q9bnVsbCk7Yy5jaGlsZExhbmVzPWEuY2hpbGRMYW5lcztjLmxhbmVzPWEubGFuZXM7Yy5jaGlsZD1hLmNoaWxkO2MubWVtb2l6ZWRQcm9wcz1hLm1lbW9pemVkUHJvcHM7Yy5tZW1vaXplZFN0YXRlPWEubWVtb2l6ZWRTdGF0ZTtjLnVwZGF0ZVF1ZXVlPWEudXBkYXRlUXVldWU7Yj1hLmRlcGVuZGVuY2llcztjLmRlcGVuZGVuY2llcz1udWxsPT09Yj9udWxsOntsYW5lczpiLmxhbmVzLGZpcnN0Q29udGV4dDpiLmZpcnN0Q29udGV4dH07XG5jLnNpYmxpbmc9YS5zaWJsaW5nO2MuaW5kZXg9YS5pbmRleDtjLnJlZj1hLnJlZjtyZXR1cm4gY31cbmZ1bmN0aW9uIFZnKGEsYixjLGQsZSxmKXt2YXIgZz0yO2Q9YTtpZihcImZ1bmN0aW9uXCI9PT10eXBlb2YgYSlqaShhKSYmKGc9MSk7ZWxzZSBpZihcInN0cmluZ1wiPT09dHlwZW9mIGEpZz01O2Vsc2UgYTpzd2l0Y2goYSl7Y2FzZSB1YTpyZXR1cm4gWGcoYy5jaGlsZHJlbixlLGYsYik7Y2FzZSBIYTpnPTg7ZXw9MTY7YnJlYWs7Y2FzZSB3YTpnPTg7ZXw9MTticmVhaztjYXNlIHhhOnJldHVybiBhPW5oKDEyLGMsYixlfDgpLGEuZWxlbWVudFR5cGU9eGEsYS50eXBlPXhhLGEubGFuZXM9ZixhO2Nhc2UgQmE6cmV0dXJuIGE9bmgoMTMsYyxiLGUpLGEudHlwZT1CYSxhLmVsZW1lbnRUeXBlPUJhLGEubGFuZXM9ZixhO2Nhc2UgQ2E6cmV0dXJuIGE9bmgoMTksYyxiLGUpLGEuZWxlbWVudFR5cGU9Q2EsYS5sYW5lcz1mLGE7Y2FzZSBJYTpyZXR1cm4gdmkoYyxlLGYsYik7Y2FzZSBKYTpyZXR1cm4gYT1uaCgyNCxjLGIsZSksYS5lbGVtZW50VHlwZT1KYSxhLmxhbmVzPWYsYTtkZWZhdWx0OmlmKFwib2JqZWN0XCI9PT1cbnR5cGVvZiBhJiZudWxsIT09YSlzd2l0Y2goYS4kJHR5cGVvZil7Y2FzZSB5YTpnPTEwO2JyZWFrIGE7Y2FzZSB6YTpnPTk7YnJlYWsgYTtjYXNlIEFhOmc9MTE7YnJlYWsgYTtjYXNlIERhOmc9MTQ7YnJlYWsgYTtjYXNlIEVhOmc9MTY7ZD1udWxsO2JyZWFrIGE7Y2FzZSBGYTpnPTIyO2JyZWFrIGF9dGhyb3cgRXJyb3IoeSgxMzAsbnVsbD09YT9hOnR5cGVvZiBhLFwiXCIpKTt9Yj1uaChnLGMsYixlKTtiLmVsZW1lbnRUeXBlPWE7Yi50eXBlPWQ7Yi5sYW5lcz1mO3JldHVybiBifWZ1bmN0aW9uIFhnKGEsYixjLGQpe2E9bmgoNyxhLGQsYik7YS5sYW5lcz1jO3JldHVybiBhfWZ1bmN0aW9uIHZpKGEsYixjLGQpe2E9bmgoMjMsYSxkLGIpO2EuZWxlbWVudFR5cGU9SWE7YS5sYW5lcz1jO3JldHVybiBhfWZ1bmN0aW9uIFVnKGEsYixjKXthPW5oKDYsYSxudWxsLGIpO2EubGFuZXM9YztyZXR1cm4gYX1cbmZ1bmN0aW9uIFdnKGEsYixjKXtiPW5oKDQsbnVsbCE9PWEuY2hpbGRyZW4/YS5jaGlsZHJlbjpbXSxhLmtleSxiKTtiLmxhbmVzPWM7Yi5zdGF0ZU5vZGU9e2NvbnRhaW5lckluZm86YS5jb250YWluZXJJbmZvLHBlbmRpbmdDaGlsZHJlbjpudWxsLGltcGxlbWVudGF0aW9uOmEuaW1wbGVtZW50YXRpb259O3JldHVybiBifVxuZnVuY3Rpb24gamsoYSxiLGMpe3RoaXMudGFnPWI7dGhpcy5jb250YWluZXJJbmZvPWE7dGhpcy5maW5pc2hlZFdvcms9dGhpcy5waW5nQ2FjaGU9dGhpcy5jdXJyZW50PXRoaXMucGVuZGluZ0NoaWxkcmVuPW51bGw7dGhpcy50aW1lb3V0SGFuZGxlPS0xO3RoaXMucGVuZGluZ0NvbnRleHQ9dGhpcy5jb250ZXh0PW51bGw7dGhpcy5oeWRyYXRlPWM7dGhpcy5jYWxsYmFja05vZGU9bnVsbDt0aGlzLmNhbGxiYWNrUHJpb3JpdHk9MDt0aGlzLmV2ZW50VGltZXM9WmMoMCk7dGhpcy5leHBpcmF0aW9uVGltZXM9WmMoLTEpO3RoaXMuZW50YW5nbGVkTGFuZXM9dGhpcy5maW5pc2hlZExhbmVzPXRoaXMubXV0YWJsZVJlYWRMYW5lcz10aGlzLmV4cGlyZWRMYW5lcz10aGlzLnBpbmdlZExhbmVzPXRoaXMuc3VzcGVuZGVkTGFuZXM9dGhpcy5wZW5kaW5nTGFuZXM9MDt0aGlzLmVudGFuZ2xlbWVudHM9WmMoMCk7dGhpcy5tdXRhYmxlU291cmNlRWFnZXJIeWRyYXRpb25EYXRhPW51bGx9XG5mdW5jdGlvbiBrayhhLGIsYyl7dmFyIGQ9Mzxhcmd1bWVudHMubGVuZ3RoJiZ2b2lkIDAhPT1hcmd1bWVudHNbM10/YXJndW1lbnRzWzNdOm51bGw7cmV0dXJueyQkdHlwZW9mOnRhLGtleTpudWxsPT1kP251bGw6XCJcIitkLGNoaWxkcmVuOmEsY29udGFpbmVySW5mbzpiLGltcGxlbWVudGF0aW9uOmN9fVxuZnVuY3Rpb24gbGsoYSxiLGMsZCl7dmFyIGU9Yi5jdXJyZW50LGY9SGcoKSxnPUlnKGUpO2E6aWYoYyl7Yz1jLl9yZWFjdEludGVybmFscztiOntpZihaYihjKSE9PWN8fDEhPT1jLnRhZyl0aHJvdyBFcnJvcih5KDE3MCkpO3ZhciBoPWM7ZG97c3dpdGNoKGgudGFnKXtjYXNlIDM6aD1oLnN0YXRlTm9kZS5jb250ZXh0O2JyZWFrIGI7Y2FzZSAxOmlmKEZmKGgudHlwZSkpe2g9aC5zdGF0ZU5vZGUuX19yZWFjdEludGVybmFsTWVtb2l6ZWRNZXJnZWRDaGlsZENvbnRleHQ7YnJlYWsgYn19aD1oLnJldHVybn13aGlsZShudWxsIT09aCk7dGhyb3cgRXJyb3IoeSgxNzEpKTt9aWYoMT09PWMudGFnKXt2YXIgaz1jLnR5cGU7aWYoRmYoaykpe2M9SWYoYyxrLGgpO2JyZWFrIGF9fWM9aH1lbHNlIGM9Q2Y7bnVsbD09PWIuY29udGV4dD9iLmNvbnRleHQ9YzpiLnBlbmRpbmdDb250ZXh0PWM7Yj16ZyhmLGcpO2IucGF5bG9hZD17ZWxlbWVudDphfTtkPXZvaWQgMD09PWQ/bnVsbDpkO251bGwhPT1cbmQmJihiLmNhbGxiYWNrPWQpO0FnKGUsYik7SmcoZSxnLGYpO3JldHVybiBnfWZ1bmN0aW9uIG1rKGEpe2E9YS5jdXJyZW50O2lmKCFhLmNoaWxkKXJldHVybiBudWxsO3N3aXRjaChhLmNoaWxkLnRhZyl7Y2FzZSA1OnJldHVybiBhLmNoaWxkLnN0YXRlTm9kZTtkZWZhdWx0OnJldHVybiBhLmNoaWxkLnN0YXRlTm9kZX19ZnVuY3Rpb24gbmsoYSxiKXthPWEubWVtb2l6ZWRTdGF0ZTtpZihudWxsIT09YSYmbnVsbCE9PWEuZGVoeWRyYXRlZCl7dmFyIGM9YS5yZXRyeUxhbmU7YS5yZXRyeUxhbmU9MCE9PWMmJmM8Yj9jOmJ9fWZ1bmN0aW9uIG9rKGEsYil7bmsoYSxiKTsoYT1hLmFsdGVybmF0ZSkmJm5rKGEsYil9ZnVuY3Rpb24gcGsoKXtyZXR1cm4gbnVsbH1cbmZ1bmN0aW9uIHFrKGEsYixjKXt2YXIgZD1udWxsIT1jJiZudWxsIT1jLmh5ZHJhdGlvbk9wdGlvbnMmJmMuaHlkcmF0aW9uT3B0aW9ucy5tdXRhYmxlU291cmNlc3x8bnVsbDtjPW5ldyBqayhhLGIsbnVsbCE9YyYmITA9PT1jLmh5ZHJhdGUpO2I9bmgoMyxudWxsLG51bGwsMj09PWI/NzoxPT09Yj8zOjApO2MuY3VycmVudD1iO2Iuc3RhdGVOb2RlPWM7eGcoYik7YVtmZl09Yy5jdXJyZW50O2NmKDg9PT1hLm5vZGVUeXBlP2EucGFyZW50Tm9kZTphKTtpZihkKWZvcihhPTA7YTxkLmxlbmd0aDthKyspe2I9ZFthXTt2YXIgZT1iLl9nZXRWZXJzaW9uO2U9ZShiLl9zb3VyY2UpO251bGw9PWMubXV0YWJsZVNvdXJjZUVhZ2VySHlkcmF0aW9uRGF0YT9jLm11dGFibGVTb3VyY2VFYWdlckh5ZHJhdGlvbkRhdGE9W2IsZV06Yy5tdXRhYmxlU291cmNlRWFnZXJIeWRyYXRpb25EYXRhLnB1c2goYixlKX10aGlzLl9pbnRlcm5hbFJvb3Q9Y31cbnFrLnByb3RvdHlwZS5yZW5kZXI9ZnVuY3Rpb24oYSl7bGsoYSx0aGlzLl9pbnRlcm5hbFJvb3QsbnVsbCxudWxsKX07cWsucHJvdG90eXBlLnVubW91bnQ9ZnVuY3Rpb24oKXt2YXIgYT10aGlzLl9pbnRlcm5hbFJvb3QsYj1hLmNvbnRhaW5lckluZm87bGsobnVsbCxhLG51bGwsZnVuY3Rpb24oKXtiW2ZmXT1udWxsfSl9O2Z1bmN0aW9uIHJrKGEpe3JldHVybiEoIWF8fDEhPT1hLm5vZGVUeXBlJiY5IT09YS5ub2RlVHlwZSYmMTEhPT1hLm5vZGVUeXBlJiYoOCE9PWEubm9kZVR5cGV8fFwiIHJlYWN0LW1vdW50LXBvaW50LXVuc3RhYmxlIFwiIT09YS5ub2RlVmFsdWUpKX1cbmZ1bmN0aW9uIHNrKGEsYil7Ynx8KGI9YT85PT09YS5ub2RlVHlwZT9hLmRvY3VtZW50RWxlbWVudDphLmZpcnN0Q2hpbGQ6bnVsbCxiPSEoIWJ8fDEhPT1iLm5vZGVUeXBlfHwhYi5oYXNBdHRyaWJ1dGUoXCJkYXRhLXJlYWN0cm9vdFwiKSkpO2lmKCFiKWZvcih2YXIgYztjPWEubGFzdENoaWxkOylhLnJlbW92ZUNoaWxkKGMpO3JldHVybiBuZXcgcWsoYSwwLGI/e2h5ZHJhdGU6ITB9OnZvaWQgMCl9XG5mdW5jdGlvbiB0ayhhLGIsYyxkLGUpe3ZhciBmPWMuX3JlYWN0Um9vdENvbnRhaW5lcjtpZihmKXt2YXIgZz1mLl9pbnRlcm5hbFJvb3Q7aWYoXCJmdW5jdGlvblwiPT09dHlwZW9mIGUpe3ZhciBoPWU7ZT1mdW5jdGlvbigpe3ZhciBhPW1rKGcpO2guY2FsbChhKX19bGsoYixnLGEsZSl9ZWxzZXtmPWMuX3JlYWN0Um9vdENvbnRhaW5lcj1zayhjLGQpO2c9Zi5faW50ZXJuYWxSb290O2lmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBlKXt2YXIgaz1lO2U9ZnVuY3Rpb24oKXt2YXIgYT1tayhnKTtrLmNhbGwoYSl9fVhqKGZ1bmN0aW9uKCl7bGsoYixnLGEsZSl9KX1yZXR1cm4gbWsoZyl9ZWM9ZnVuY3Rpb24oYSl7aWYoMTM9PT1hLnRhZyl7dmFyIGI9SGcoKTtKZyhhLDQsYik7b2soYSw0KX19O2ZjPWZ1bmN0aW9uKGEpe2lmKDEzPT09YS50YWcpe3ZhciBiPUhnKCk7SmcoYSw2NzEwODg2NCxiKTtvayhhLDY3MTA4ODY0KX19O1xuZ2M9ZnVuY3Rpb24oYSl7aWYoMTM9PT1hLnRhZyl7dmFyIGI9SGcoKSxjPUlnKGEpO0pnKGEsYyxiKTtvayhhLGMpfX07aGM9ZnVuY3Rpb24oYSxiKXtyZXR1cm4gYigpfTtcbnliPWZ1bmN0aW9uKGEsYixjKXtzd2l0Y2goYil7Y2FzZSBcImlucHV0XCI6YWIoYSxjKTtiPWMubmFtZTtpZihcInJhZGlvXCI9PT1jLnR5cGUmJm51bGwhPWIpe2ZvcihjPWE7Yy5wYXJlbnROb2RlOyljPWMucGFyZW50Tm9kZTtjPWMucXVlcnlTZWxlY3RvckFsbChcImlucHV0W25hbWU9XCIrSlNPTi5zdHJpbmdpZnkoXCJcIitiKSsnXVt0eXBlPVwicmFkaW9cIl0nKTtmb3IoYj0wO2I8Yy5sZW5ndGg7YisrKXt2YXIgZD1jW2JdO2lmKGQhPT1hJiZkLmZvcm09PT1hLmZvcm0pe3ZhciBlPURiKGQpO2lmKCFlKXRocm93IEVycm9yKHkoOTApKTtXYShkKTthYihkLGUpfX19YnJlYWs7Y2FzZSBcInRleHRhcmVhXCI6aWIoYSxjKTticmVhaztjYXNlIFwic2VsZWN0XCI6Yj1jLnZhbHVlLG51bGwhPWImJmZiKGEsISFjLm11bHRpcGxlLGIsITEpfX07R2I9V2o7XG5IYj1mdW5jdGlvbihhLGIsYyxkLGUpe3ZhciBmPVg7WHw9NDt0cnl7cmV0dXJuIGdnKDk4LGEuYmluZChudWxsLGIsYyxkLGUpKX1maW5hbGx5e1g9ZiwwPT09WCYmKHdqKCksaWcoKSl9fTtJYj1mdW5jdGlvbigpezA9PT0oWCY0OSkmJihWaigpLE9qKCkpfTtKYj1mdW5jdGlvbihhLGIpe3ZhciBjPVg7WHw9Mjt0cnl7cmV0dXJuIGEoYil9ZmluYWxseXtYPWMsMD09PVgmJih3aigpLGlnKCkpfX07ZnVuY3Rpb24gdWsoYSxiKXt2YXIgYz0yPGFyZ3VtZW50cy5sZW5ndGgmJnZvaWQgMCE9PWFyZ3VtZW50c1syXT9hcmd1bWVudHNbMl06bnVsbDtpZighcmsoYikpdGhyb3cgRXJyb3IoeSgyMDApKTtyZXR1cm4ga2soYSxiLG51bGwsYyl9dmFyIHZrPXtFdmVudHM6W0NiLHVlLERiLEViLEZiLE9qLHtjdXJyZW50OiExfV19LHdrPXtmaW5kRmliZXJCeUhvc3RJbnN0YW5jZTp3YyxidW5kbGVUeXBlOjAsdmVyc2lvbjpcIjE3LjAuMlwiLHJlbmRlcmVyUGFja2FnZU5hbWU6XCJyZWFjdC1kb21cIn07XG52YXIgeGs9e2J1bmRsZVR5cGU6d2suYnVuZGxlVHlwZSx2ZXJzaW9uOndrLnZlcnNpb24scmVuZGVyZXJQYWNrYWdlTmFtZTp3ay5yZW5kZXJlclBhY2thZ2VOYW1lLHJlbmRlcmVyQ29uZmlnOndrLnJlbmRlcmVyQ29uZmlnLG92ZXJyaWRlSG9va1N0YXRlOm51bGwsb3ZlcnJpZGVIb29rU3RhdGVEZWxldGVQYXRoOm51bGwsb3ZlcnJpZGVIb29rU3RhdGVSZW5hbWVQYXRoOm51bGwsb3ZlcnJpZGVQcm9wczpudWxsLG92ZXJyaWRlUHJvcHNEZWxldGVQYXRoOm51bGwsb3ZlcnJpZGVQcm9wc1JlbmFtZVBhdGg6bnVsbCxzZXRTdXNwZW5zZUhhbmRsZXI6bnVsbCxzY2hlZHVsZVVwZGF0ZTpudWxsLGN1cnJlbnREaXNwYXRjaGVyUmVmOnJhLlJlYWN0Q3VycmVudERpc3BhdGNoZXIsZmluZEhvc3RJbnN0YW5jZUJ5RmliZXI6ZnVuY3Rpb24oYSl7YT1jYyhhKTtyZXR1cm4gbnVsbD09PWE/bnVsbDphLnN0YXRlTm9kZX0sZmluZEZpYmVyQnlIb3N0SW5zdGFuY2U6d2suZmluZEZpYmVyQnlIb3N0SW5zdGFuY2V8fFxucGssZmluZEhvc3RJbnN0YW5jZXNGb3JSZWZyZXNoOm51bGwsc2NoZWR1bGVSZWZyZXNoOm51bGwsc2NoZWR1bGVSb290Om51bGwsc2V0UmVmcmVzaEhhbmRsZXI6bnVsbCxnZXRDdXJyZW50RmliZXI6bnVsbH07aWYoXCJ1bmRlZmluZWRcIiE9PXR5cGVvZiBfX1JFQUNUX0RFVlRPT0xTX0dMT0JBTF9IT09LX18pe3ZhciB5az1fX1JFQUNUX0RFVlRPT0xTX0dMT0JBTF9IT09LX187aWYoIXlrLmlzRGlzYWJsZWQmJnlrLnN1cHBvcnRzRmliZXIpdHJ5e0xmPXlrLmluamVjdCh4ayksTWY9eWt9Y2F0Y2goYSl7fX1leHBvcnRzLl9fU0VDUkVUX0lOVEVSTkFMU19ET19OT1RfVVNFX09SX1lPVV9XSUxMX0JFX0ZJUkVEPXZrO2V4cG9ydHMuY3JlYXRlUG9ydGFsPXVrO1xuZXhwb3J0cy5maW5kRE9NTm9kZT1mdW5jdGlvbihhKXtpZihudWxsPT1hKXJldHVybiBudWxsO2lmKDE9PT1hLm5vZGVUeXBlKXJldHVybiBhO3ZhciBiPWEuX3JlYWN0SW50ZXJuYWxzO2lmKHZvaWQgMD09PWIpe2lmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBhLnJlbmRlcil0aHJvdyBFcnJvcih5KDE4OCkpO3Rocm93IEVycm9yKHkoMjY4LE9iamVjdC5rZXlzKGEpKSk7fWE9Y2MoYik7YT1udWxsPT09YT9udWxsOmEuc3RhdGVOb2RlO3JldHVybiBhfTtleHBvcnRzLmZsdXNoU3luYz1mdW5jdGlvbihhLGIpe3ZhciBjPVg7aWYoMCE9PShjJjQ4KSlyZXR1cm4gYShiKTtYfD0xO3RyeXtpZihhKXJldHVybiBnZyg5OSxhLmJpbmQobnVsbCxiKSl9ZmluYWxseXtYPWMsaWcoKX19O2V4cG9ydHMuaHlkcmF0ZT1mdW5jdGlvbihhLGIsYyl7aWYoIXJrKGIpKXRocm93IEVycm9yKHkoMjAwKSk7cmV0dXJuIHRrKG51bGwsYSxiLCEwLGMpfTtcbmV4cG9ydHMucmVuZGVyPWZ1bmN0aW9uKGEsYixjKXtpZighcmsoYikpdGhyb3cgRXJyb3IoeSgyMDApKTtyZXR1cm4gdGsobnVsbCxhLGIsITEsYyl9O2V4cG9ydHMudW5tb3VudENvbXBvbmVudEF0Tm9kZT1mdW5jdGlvbihhKXtpZighcmsoYSkpdGhyb3cgRXJyb3IoeSg0MCkpO3JldHVybiBhLl9yZWFjdFJvb3RDb250YWluZXI/KFhqKGZ1bmN0aW9uKCl7dGsobnVsbCxudWxsLGEsITEsZnVuY3Rpb24oKXthLl9yZWFjdFJvb3RDb250YWluZXI9bnVsbDthW2ZmXT1udWxsfSl9KSwhMCk6ITF9O2V4cG9ydHMudW5zdGFibGVfYmF0Y2hlZFVwZGF0ZXM9V2o7ZXhwb3J0cy51bnN0YWJsZV9jcmVhdGVQb3J0YWw9ZnVuY3Rpb24oYSxiKXtyZXR1cm4gdWsoYSxiLDI8YXJndW1lbnRzLmxlbmd0aCYmdm9pZCAwIT09YXJndW1lbnRzWzJdP2FyZ3VtZW50c1syXTpudWxsKX07XG5leHBvcnRzLnVuc3RhYmxlX3JlbmRlclN1YnRyZWVJbnRvQ29udGFpbmVyPWZ1bmN0aW9uKGEsYixjLGQpe2lmKCFyayhjKSl0aHJvdyBFcnJvcih5KDIwMCkpO2lmKG51bGw9PWF8fHZvaWQgMD09PWEuX3JlYWN0SW50ZXJuYWxzKXRocm93IEVycm9yKHkoMzgpKTtyZXR1cm4gdGsoYSxiLGMsITEsZCl9O2V4cG9ydHMudmVyc2lvbj1cIjE3LjAuMlwiO1xuIiwiJ3VzZSBzdHJpY3QnO1xuXG5pZiAocHJvY2Vzcy5lbnYuTk9ERV9FTlYgPT09ICdwcm9kdWN0aW9uJykge1xuICBtb2R1bGUuZXhwb3J0cyA9IHJlcXVpcmUoJy4vY2pzL3NjaGVkdWxlci5wcm9kdWN0aW9uLm1pbi5qcycpO1xufSBlbHNlIHtcbiAgbW9kdWxlLmV4cG9ydHMgPSByZXF1aXJlKCcuL2Nqcy9zY2hlZHVsZXIuZGV2ZWxvcG1lbnQuanMnKTtcbn1cbiIsIi8qKiBAbGljZW5zZSBSZWFjdCB2MC4yMC4yXG4gKiBzY2hlZHVsZXIucHJvZHVjdGlvbi5taW4uanNcbiAqXG4gKiBDb3B5cmlnaHQgKGMpIEZhY2Vib29rLCBJbmMuIGFuZCBpdHMgYWZmaWxpYXRlcy5cbiAqXG4gKiBUaGlzIHNvdXJjZSBjb2RlIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBNSVQgbGljZW5zZSBmb3VuZCBpbiB0aGVcbiAqIExJQ0VOU0UgZmlsZSBpbiB0aGUgcm9vdCBkaXJlY3Rvcnkgb2YgdGhpcyBzb3VyY2UgdHJlZS5cbiAqL1xuJ3VzZSBzdHJpY3QnO3ZhciBmLGcsaCxrO2lmKFwib2JqZWN0XCI9PT10eXBlb2YgcGVyZm9ybWFuY2UmJlwiZnVuY3Rpb25cIj09PXR5cGVvZiBwZXJmb3JtYW5jZS5ub3cpe3ZhciBsPXBlcmZvcm1hbmNlO2V4cG9ydHMudW5zdGFibGVfbm93PWZ1bmN0aW9uKCl7cmV0dXJuIGwubm93KCl9fWVsc2V7dmFyIHA9RGF0ZSxxPXAubm93KCk7ZXhwb3J0cy51bnN0YWJsZV9ub3c9ZnVuY3Rpb24oKXtyZXR1cm4gcC5ub3coKS1xfX1cbmlmKFwidW5kZWZpbmVkXCI9PT10eXBlb2Ygd2luZG93fHxcImZ1bmN0aW9uXCIhPT10eXBlb2YgTWVzc2FnZUNoYW5uZWwpe3ZhciB0PW51bGwsdT1udWxsLHc9ZnVuY3Rpb24oKXtpZihudWxsIT09dCl0cnl7dmFyIGE9ZXhwb3J0cy51bnN0YWJsZV9ub3coKTt0KCEwLGEpO3Q9bnVsbH1jYXRjaChiKXt0aHJvdyBzZXRUaW1lb3V0KHcsMCksYjt9fTtmPWZ1bmN0aW9uKGEpe251bGwhPT10P3NldFRpbWVvdXQoZiwwLGEpOih0PWEsc2V0VGltZW91dCh3LDApKX07Zz1mdW5jdGlvbihhLGIpe3U9c2V0VGltZW91dChhLGIpfTtoPWZ1bmN0aW9uKCl7Y2xlYXJUaW1lb3V0KHUpfTtleHBvcnRzLnVuc3RhYmxlX3Nob3VsZFlpZWxkPWZ1bmN0aW9uKCl7cmV0dXJuITF9O2s9ZXhwb3J0cy51bnN0YWJsZV9mb3JjZUZyYW1lUmF0ZT1mdW5jdGlvbigpe319ZWxzZXt2YXIgeD13aW5kb3cuc2V0VGltZW91dCx5PXdpbmRvdy5jbGVhclRpbWVvdXQ7aWYoXCJ1bmRlZmluZWRcIiE9PXR5cGVvZiBjb25zb2xlKXt2YXIgej1cbndpbmRvdy5jYW5jZWxBbmltYXRpb25GcmFtZTtcImZ1bmN0aW9uXCIhPT10eXBlb2Ygd2luZG93LnJlcXVlc3RBbmltYXRpb25GcmFtZSYmY29uc29sZS5lcnJvcihcIlRoaXMgYnJvd3NlciBkb2Vzbid0IHN1cHBvcnQgcmVxdWVzdEFuaW1hdGlvbkZyYW1lLiBNYWtlIHN1cmUgdGhhdCB5b3UgbG9hZCBhIHBvbHlmaWxsIGluIG9sZGVyIGJyb3dzZXJzLiBodHRwczovL3JlYWN0anMub3JnL2xpbmsvcmVhY3QtcG9seWZpbGxzXCIpO1wiZnVuY3Rpb25cIiE9PXR5cGVvZiB6JiZjb25zb2xlLmVycm9yKFwiVGhpcyBicm93c2VyIGRvZXNuJ3Qgc3VwcG9ydCBjYW5jZWxBbmltYXRpb25GcmFtZS4gTWFrZSBzdXJlIHRoYXQgeW91IGxvYWQgYSBwb2x5ZmlsbCBpbiBvbGRlciBicm93c2Vycy4gaHR0cHM6Ly9yZWFjdGpzLm9yZy9saW5rL3JlYWN0LXBvbHlmaWxsc1wiKX12YXIgQT0hMSxCPW51bGwsQz0tMSxEPTUsRT0wO2V4cG9ydHMudW5zdGFibGVfc2hvdWxkWWllbGQ9ZnVuY3Rpb24oKXtyZXR1cm4gZXhwb3J0cy51bnN0YWJsZV9ub3coKT49XG5FfTtrPWZ1bmN0aW9uKCl7fTtleHBvcnRzLnVuc3RhYmxlX2ZvcmNlRnJhbWVSYXRlPWZ1bmN0aW9uKGEpezA+YXx8MTI1PGE/Y29uc29sZS5lcnJvcihcImZvcmNlRnJhbWVSYXRlIHRha2VzIGEgcG9zaXRpdmUgaW50IGJldHdlZW4gMCBhbmQgMTI1LCBmb3JjaW5nIGZyYW1lIHJhdGVzIGhpZ2hlciB0aGFuIDEyNSBmcHMgaXMgbm90IHN1cHBvcnRlZFwiKTpEPTA8YT9NYXRoLmZsb29yKDFFMy9hKTo1fTt2YXIgRj1uZXcgTWVzc2FnZUNoYW5uZWwsRz1GLnBvcnQyO0YucG9ydDEub25tZXNzYWdlPWZ1bmN0aW9uKCl7aWYobnVsbCE9PUIpe3ZhciBhPWV4cG9ydHMudW5zdGFibGVfbm93KCk7RT1hK0Q7dHJ5e0IoITAsYSk/Ry5wb3N0TWVzc2FnZShudWxsKTooQT0hMSxCPW51bGwpfWNhdGNoKGIpe3Rocm93IEcucG9zdE1lc3NhZ2UobnVsbCksYjt9fWVsc2UgQT0hMX07Zj1mdW5jdGlvbihhKXtCPWE7QXx8KEE9ITAsRy5wb3N0TWVzc2FnZShudWxsKSl9O2c9ZnVuY3Rpb24oYSxiKXtDPVxueChmdW5jdGlvbigpe2EoZXhwb3J0cy51bnN0YWJsZV9ub3coKSl9LGIpfTtoPWZ1bmN0aW9uKCl7eShDKTtDPS0xfX1mdW5jdGlvbiBIKGEsYil7dmFyIGM9YS5sZW5ndGg7YS5wdXNoKGIpO2E6Zm9yKDs7KXt2YXIgZD1jLTE+Pj4xLGU9YVtkXTtpZih2b2lkIDAhPT1lJiYwPEkoZSxiKSlhW2RdPWIsYVtjXT1lLGM9ZDtlbHNlIGJyZWFrIGF9fWZ1bmN0aW9uIEooYSl7YT1hWzBdO3JldHVybiB2b2lkIDA9PT1hP251bGw6YX1cbmZ1bmN0aW9uIEsoYSl7dmFyIGI9YVswXTtpZih2b2lkIDAhPT1iKXt2YXIgYz1hLnBvcCgpO2lmKGMhPT1iKXthWzBdPWM7YTpmb3IodmFyIGQ9MCxlPWEubGVuZ3RoO2Q8ZTspe3ZhciBtPTIqKGQrMSktMSxuPWFbbV0sdj1tKzEscj1hW3ZdO2lmKHZvaWQgMCE9PW4mJjA+SShuLGMpKXZvaWQgMCE9PXImJjA+SShyLG4pPyhhW2RdPXIsYVt2XT1jLGQ9dik6KGFbZF09bixhW21dPWMsZD1tKTtlbHNlIGlmKHZvaWQgMCE9PXImJjA+SShyLGMpKWFbZF09cixhW3ZdPWMsZD12O2Vsc2UgYnJlYWsgYX19cmV0dXJuIGJ9cmV0dXJuIG51bGx9ZnVuY3Rpb24gSShhLGIpe3ZhciBjPWEuc29ydEluZGV4LWIuc29ydEluZGV4O3JldHVybiAwIT09Yz9jOmEuaWQtYi5pZH12YXIgTD1bXSxNPVtdLE49MSxPPW51bGwsUD0zLFE9ITEsUj0hMSxTPSExO1xuZnVuY3Rpb24gVChhKXtmb3IodmFyIGI9SihNKTtudWxsIT09Yjspe2lmKG51bGw9PT1iLmNhbGxiYWNrKUsoTSk7ZWxzZSBpZihiLnN0YXJ0VGltZTw9YSlLKE0pLGIuc29ydEluZGV4PWIuZXhwaXJhdGlvblRpbWUsSChMLGIpO2Vsc2UgYnJlYWs7Yj1KKE0pfX1mdW5jdGlvbiBVKGEpe1M9ITE7VChhKTtpZighUilpZihudWxsIT09SihMKSlSPSEwLGYoVik7ZWxzZXt2YXIgYj1KKE0pO251bGwhPT1iJiZnKFUsYi5zdGFydFRpbWUtYSl9fVxuZnVuY3Rpb24gVihhLGIpe1I9ITE7UyYmKFM9ITEsaCgpKTtRPSEwO3ZhciBjPVA7dHJ5e1QoYik7Zm9yKE89SihMKTtudWxsIT09TyYmKCEoTy5leHBpcmF0aW9uVGltZT5iKXx8YSYmIWV4cG9ydHMudW5zdGFibGVfc2hvdWxkWWllbGQoKSk7KXt2YXIgZD1PLmNhbGxiYWNrO2lmKFwiZnVuY3Rpb25cIj09PXR5cGVvZiBkKXtPLmNhbGxiYWNrPW51bGw7UD1PLnByaW9yaXR5TGV2ZWw7dmFyIGU9ZChPLmV4cGlyYXRpb25UaW1lPD1iKTtiPWV4cG9ydHMudW5zdGFibGVfbm93KCk7XCJmdW5jdGlvblwiPT09dHlwZW9mIGU/Ty5jYWxsYmFjaz1lOk89PT1KKEwpJiZLKEwpO1QoYil9ZWxzZSBLKEwpO089SihMKX1pZihudWxsIT09Tyl2YXIgbT0hMDtlbHNle3ZhciBuPUooTSk7bnVsbCE9PW4mJmcoVSxuLnN0YXJ0VGltZS1iKTttPSExfXJldHVybiBtfWZpbmFsbHl7Tz1udWxsLFA9YyxRPSExfX12YXIgVz1rO2V4cG9ydHMudW5zdGFibGVfSWRsZVByaW9yaXR5PTU7XG5leHBvcnRzLnVuc3RhYmxlX0ltbWVkaWF0ZVByaW9yaXR5PTE7ZXhwb3J0cy51bnN0YWJsZV9Mb3dQcmlvcml0eT00O2V4cG9ydHMudW5zdGFibGVfTm9ybWFsUHJpb3JpdHk9MztleHBvcnRzLnVuc3RhYmxlX1Byb2ZpbGluZz1udWxsO2V4cG9ydHMudW5zdGFibGVfVXNlckJsb2NraW5nUHJpb3JpdHk9MjtleHBvcnRzLnVuc3RhYmxlX2NhbmNlbENhbGxiYWNrPWZ1bmN0aW9uKGEpe2EuY2FsbGJhY2s9bnVsbH07ZXhwb3J0cy51bnN0YWJsZV9jb250aW51ZUV4ZWN1dGlvbj1mdW5jdGlvbigpe1J8fFF8fChSPSEwLGYoVikpfTtleHBvcnRzLnVuc3RhYmxlX2dldEN1cnJlbnRQcmlvcml0eUxldmVsPWZ1bmN0aW9uKCl7cmV0dXJuIFB9O2V4cG9ydHMudW5zdGFibGVfZ2V0Rmlyc3RDYWxsYmFja05vZGU9ZnVuY3Rpb24oKXtyZXR1cm4gSihMKX07XG5leHBvcnRzLnVuc3RhYmxlX25leHQ9ZnVuY3Rpb24oYSl7c3dpdGNoKFApe2Nhc2UgMTpjYXNlIDI6Y2FzZSAzOnZhciBiPTM7YnJlYWs7ZGVmYXVsdDpiPVB9dmFyIGM9UDtQPWI7dHJ5e3JldHVybiBhKCl9ZmluYWxseXtQPWN9fTtleHBvcnRzLnVuc3RhYmxlX3BhdXNlRXhlY3V0aW9uPWZ1bmN0aW9uKCl7fTtleHBvcnRzLnVuc3RhYmxlX3JlcXVlc3RQYWludD1XO2V4cG9ydHMudW5zdGFibGVfcnVuV2l0aFByaW9yaXR5PWZ1bmN0aW9uKGEsYil7c3dpdGNoKGEpe2Nhc2UgMTpjYXNlIDI6Y2FzZSAzOmNhc2UgNDpjYXNlIDU6YnJlYWs7ZGVmYXVsdDphPTN9dmFyIGM9UDtQPWE7dHJ5e3JldHVybiBiKCl9ZmluYWxseXtQPWN9fTtcbmV4cG9ydHMudW5zdGFibGVfc2NoZWR1bGVDYWxsYmFjaz1mdW5jdGlvbihhLGIsYyl7dmFyIGQ9ZXhwb3J0cy51bnN0YWJsZV9ub3coKTtcIm9iamVjdFwiPT09dHlwZW9mIGMmJm51bGwhPT1jPyhjPWMuZGVsYXksYz1cIm51bWJlclwiPT09dHlwZW9mIGMmJjA8Yz9kK2M6ZCk6Yz1kO3N3aXRjaChhKXtjYXNlIDE6dmFyIGU9LTE7YnJlYWs7Y2FzZSAyOmU9MjUwO2JyZWFrO2Nhc2UgNTplPTEwNzM3NDE4MjM7YnJlYWs7Y2FzZSA0OmU9MUU0O2JyZWFrO2RlZmF1bHQ6ZT01RTN9ZT1jK2U7YT17aWQ6TisrLGNhbGxiYWNrOmIscHJpb3JpdHlMZXZlbDphLHN0YXJ0VGltZTpjLGV4cGlyYXRpb25UaW1lOmUsc29ydEluZGV4Oi0xfTtjPmQ/KGEuc29ydEluZGV4PWMsSChNLGEpLG51bGw9PT1KKEwpJiZhPT09SihNKSYmKFM/aCgpOlM9ITAsZyhVLGMtZCkpKTooYS5zb3J0SW5kZXg9ZSxIKEwsYSksUnx8UXx8KFI9ITAsZihWKSkpO3JldHVybiBhfTtcbmV4cG9ydHMudW5zdGFibGVfd3JhcENhbGxiYWNrPWZ1bmN0aW9uKGEpe3ZhciBiPVA7cmV0dXJuIGZ1bmN0aW9uKCl7dmFyIGM9UDtQPWI7dHJ5e3JldHVybiBhLmFwcGx5KHRoaXMsYXJndW1lbnRzKX1maW5hbGx5e1A9Y319fTtcbiIsIi8qKiBAbGljZW5zZSBSZWFjdCB2MTYuMTMuMVxuICogcmVhY3QtaXMucHJvZHVjdGlvbi5taW4uanNcbiAqXG4gKiBDb3B5cmlnaHQgKGMpIEZhY2Vib29rLCBJbmMuIGFuZCBpdHMgYWZmaWxpYXRlcy5cbiAqXG4gKiBUaGlzIHNvdXJjZSBjb2RlIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSBNSVQgbGljZW5zZSBmb3VuZCBpbiB0aGVcbiAqIExJQ0VOU0UgZmlsZSBpbiB0aGUgcm9vdCBkaXJlY3Rvcnkgb2YgdGhpcyBzb3VyY2UgdHJlZS5cbiAqL1xuXG4ndXNlIHN0cmljdCc7dmFyIGI9XCJmdW5jdGlvblwiPT09dHlwZW9mIFN5bWJvbCYmU3ltYm9sLmZvcixjPWI/U3ltYm9sLmZvcihcInJlYWN0LmVsZW1lbnRcIik6NjAxMDMsZD1iP1N5bWJvbC5mb3IoXCJyZWFjdC5wb3J0YWxcIik6NjAxMDYsZT1iP1N5bWJvbC5mb3IoXCJyZWFjdC5mcmFnbWVudFwiKTo2MDEwNyxmPWI/U3ltYm9sLmZvcihcInJlYWN0LnN0cmljdF9tb2RlXCIpOjYwMTA4LGc9Yj9TeW1ib2wuZm9yKFwicmVhY3QucHJvZmlsZXJcIik6NjAxMTQsaD1iP1N5bWJvbC5mb3IoXCJyZWFjdC5wcm92aWRlclwiKTo2MDEwOSxrPWI/U3ltYm9sLmZvcihcInJlYWN0LmNvbnRleHRcIik6NjAxMTAsbD1iP1N5bWJvbC5mb3IoXCJyZWFjdC5hc3luY19tb2RlXCIpOjYwMTExLG09Yj9TeW1ib2wuZm9yKFwicmVhY3QuY29uY3VycmVudF9tb2RlXCIpOjYwMTExLG49Yj9TeW1ib2wuZm9yKFwicmVhY3QuZm9yd2FyZF9yZWZcIik6NjAxMTIscD1iP1N5bWJvbC5mb3IoXCJyZWFjdC5zdXNwZW5zZVwiKTo2MDExMyxxPWI/XG5TeW1ib2wuZm9yKFwicmVhY3Quc3VzcGVuc2VfbGlzdFwiKTo2MDEyMCxyPWI/U3ltYm9sLmZvcihcInJlYWN0Lm1lbW9cIik6NjAxMTUsdD1iP1N5bWJvbC5mb3IoXCJyZWFjdC5sYXp5XCIpOjYwMTE2LHY9Yj9TeW1ib2wuZm9yKFwicmVhY3QuYmxvY2tcIik6NjAxMjEsdz1iP1N5bWJvbC5mb3IoXCJyZWFjdC5mdW5kYW1lbnRhbFwiKTo2MDExNyx4PWI/U3ltYm9sLmZvcihcInJlYWN0LnJlc3BvbmRlclwiKTo2MDExOCx5PWI/U3ltYm9sLmZvcihcInJlYWN0LnNjb3BlXCIpOjYwMTE5O1xuZnVuY3Rpb24geihhKXtpZihcIm9iamVjdFwiPT09dHlwZW9mIGEmJm51bGwhPT1hKXt2YXIgdT1hLiQkdHlwZW9mO3N3aXRjaCh1KXtjYXNlIGM6c3dpdGNoKGE9YS50eXBlLGEpe2Nhc2UgbDpjYXNlIG06Y2FzZSBlOmNhc2UgZzpjYXNlIGY6Y2FzZSBwOnJldHVybiBhO2RlZmF1bHQ6c3dpdGNoKGE9YSYmYS4kJHR5cGVvZixhKXtjYXNlIGs6Y2FzZSBuOmNhc2UgdDpjYXNlIHI6Y2FzZSBoOnJldHVybiBhO2RlZmF1bHQ6cmV0dXJuIHV9fWNhc2UgZDpyZXR1cm4gdX19fWZ1bmN0aW9uIEEoYSl7cmV0dXJuIHooYSk9PT1tfWV4cG9ydHMuQXN5bmNNb2RlPWw7ZXhwb3J0cy5Db25jdXJyZW50TW9kZT1tO2V4cG9ydHMuQ29udGV4dENvbnN1bWVyPWs7ZXhwb3J0cy5Db250ZXh0UHJvdmlkZXI9aDtleHBvcnRzLkVsZW1lbnQ9YztleHBvcnRzLkZvcndhcmRSZWY9bjtleHBvcnRzLkZyYWdtZW50PWU7ZXhwb3J0cy5MYXp5PXQ7ZXhwb3J0cy5NZW1vPXI7ZXhwb3J0cy5Qb3J0YWw9ZDtcbmV4cG9ydHMuUHJvZmlsZXI9ZztleHBvcnRzLlN0cmljdE1vZGU9ZjtleHBvcnRzLlN1c3BlbnNlPXA7ZXhwb3J0cy5pc0FzeW5jTW9kZT1mdW5jdGlvbihhKXtyZXR1cm4gQShhKXx8eihhKT09PWx9O2V4cG9ydHMuaXNDb25jdXJyZW50TW9kZT1BO2V4cG9ydHMuaXNDb250ZXh0Q29uc3VtZXI9ZnVuY3Rpb24oYSl7cmV0dXJuIHooYSk9PT1rfTtleHBvcnRzLmlzQ29udGV4dFByb3ZpZGVyPWZ1bmN0aW9uKGEpe3JldHVybiB6KGEpPT09aH07ZXhwb3J0cy5pc0VsZW1lbnQ9ZnVuY3Rpb24oYSl7cmV0dXJuXCJvYmplY3RcIj09PXR5cGVvZiBhJiZudWxsIT09YSYmYS4kJHR5cGVvZj09PWN9O2V4cG9ydHMuaXNGb3J3YXJkUmVmPWZ1bmN0aW9uKGEpe3JldHVybiB6KGEpPT09bn07ZXhwb3J0cy5pc0ZyYWdtZW50PWZ1bmN0aW9uKGEpe3JldHVybiB6KGEpPT09ZX07ZXhwb3J0cy5pc0xhenk9ZnVuY3Rpb24oYSl7cmV0dXJuIHooYSk9PT10fTtcbmV4cG9ydHMuaXNNZW1vPWZ1bmN0aW9uKGEpe3JldHVybiB6KGEpPT09cn07ZXhwb3J0cy5pc1BvcnRhbD1mdW5jdGlvbihhKXtyZXR1cm4geihhKT09PWR9O2V4cG9ydHMuaXNQcm9maWxlcj1mdW5jdGlvbihhKXtyZXR1cm4geihhKT09PWd9O2V4cG9ydHMuaXNTdHJpY3RNb2RlPWZ1bmN0aW9uKGEpe3JldHVybiB6KGEpPT09Zn07ZXhwb3J0cy5pc1N1c3BlbnNlPWZ1bmN0aW9uKGEpe3JldHVybiB6KGEpPT09cH07XG5leHBvcnRzLmlzVmFsaWRFbGVtZW50VHlwZT1mdW5jdGlvbihhKXtyZXR1cm5cInN0cmluZ1wiPT09dHlwZW9mIGF8fFwiZnVuY3Rpb25cIj09PXR5cGVvZiBhfHxhPT09ZXx8YT09PW18fGE9PT1nfHxhPT09Znx8YT09PXB8fGE9PT1xfHxcIm9iamVjdFwiPT09dHlwZW9mIGEmJm51bGwhPT1hJiYoYS4kJHR5cGVvZj09PXR8fGEuJCR0eXBlb2Y9PT1yfHxhLiQkdHlwZW9mPT09aHx8YS4kJHR5cGVvZj09PWt8fGEuJCR0eXBlb2Y9PT1ufHxhLiQkdHlwZW9mPT09d3x8YS4kJHR5cGVvZj09PXh8fGEuJCR0eXBlb2Y9PT15fHxhLiQkdHlwZW9mPT09dil9O2V4cG9ydHMudHlwZU9mPXo7XG4iLCJlbnVtIENvbXBsZXRpb25UeXBlIHtcbiAgU2VhcmNoRW5naW5lcyxcbiAgSGlzdG9yeSxcbiAgQm9va21hcmtzLFxufVxuXG5leHBvcnQgZGVmYXVsdCBDb21wbGV0aW9uVHlwZTtcbiIsImVudW0gVGFiRmxhZyB7XG4gIEN1cnJlbnRUYWIgPSBcIiVcIixcbiAgTGFzdFRhYiA9IFwiI1wiLFxuICBOb25lID0gXCJcIixcbn1cblxuZXhwb3J0IGRlZmF1bHQgVGFiRmxhZztcbiIsIi8vIEltcG9ydHNcbmltcG9ydCBfX19DU1NfTE9BREVSX0FQSV9TT1VSQ0VNQVBfSU1QT1JUX19fIGZyb20gXCIuLi8uLi9ub2RlX21vZHVsZXMvY3NzLWxvYWRlci9kaXN0L3J1bnRpbWUvY3NzV2l0aE1hcHBpbmdUb1N0cmluZy5qc1wiO1xuaW1wb3J0IF9fX0NTU19MT0FERVJfQVBJX0lNUE9SVF9fXyBmcm9tIFwiLi4vLi4vbm9kZV9tb2R1bGVzL2Nzcy1sb2FkZXIvZGlzdC9ydW50aW1lL2FwaS5qc1wiO1xudmFyIF9fX0NTU19MT0FERVJfRVhQT1JUX19fID0gX19fQ1NTX0xPQURFUl9BUElfSU1QT1JUX19fKF9fX0NTU19MT0FERVJfQVBJX1NPVVJDRU1BUF9JTVBPUlRfX18pO1xuLy8gTW9kdWxlXG5fX19DU1NfTE9BREVSX0VYUE9SVF9fXy5wdXNoKFttb2R1bGUuaWQsIFwiaHRtbCwgYm9keSwgKiB7XFxuICBtYXJnaW46IDA7XFxuICBwYWRkaW5nOiAwO1xcblxcbiAgZm9udC1zdHlsZTogbm9ybWFsO1xcbiAgZm9udC1mYW1pbHk6IG1vbm9zcGFjZTtcXG4gIGZvbnQtc2l6ZTogMTJweDtcXG4gIGxpbmUtaGVpZ2h0OiAxNnB4O1xcbn1cXG5cXG5pbnB1dCB7XFxuICBmb250LXN0eWxlOiBub3JtYWw7XFxuICBmb250LWZhbWlseTogbW9ub3NwYWNlO1xcbiAgZm9udC1zaXplOiAxMnB4O1xcbiAgbGluZS1oZWlnaHQ6IDE2cHg7XFxufVxcblxcbmJvZHkge1xcbiAgcG9zaXRpb246IGFic29sdXRlO1xcbiAgYm90dG9tOiAwO1xcbiAgbGVmdDogMDtcXG4gIHJpZ2h0OiAwO1xcbiAgb3ZlcmZsb3c6IGhpZGRlbjtcXG59XFxuXFxuLnZpbXZpeGVuLWNvbnNvbGUge1xcbiAgYm90dG9tOiAwO1xcbiAgbWFyZ2luOiAwO1xcbiAgcGFkZGluZzogMDtcXG59XFxuXCIsIFwiXCIse1widmVyc2lvblwiOjMsXCJzb3VyY2VzXCI6W1wid2VicGFjazovLy4vc3JjL2NvbnNvbGUvaW5kZXguY3NzXCJdLFwibmFtZXNcIjpbXSxcIm1hcHBpbmdzXCI6XCJBQUFBO0VBQ0UsU0FBUztFQUNULFVBQVU7O0VBRVYsa0JBQWtCO0VBQ2xCLHNCQUFzQjtFQUN0QixlQUFlO0VBQ2YsaUJBQWlCO0FBQ25COztBQUVBO0VBQ0Usa0JBQWtCO0VBQ2xCLHNCQUFzQjtFQUN0QixlQUFlO0VBQ2YsaUJBQWlCO0FBQ25COztBQUVBO0VBQ0Usa0JBQWtCO0VBQ2xCLFNBQVM7RUFDVCxPQUFPO0VBQ1AsUUFBUTtFQUNSLGdCQUFnQjtBQUNsQjs7QUFFQTtFQUNFLFNBQVM7RUFDVCxTQUFTO0VBQ1QsVUFBVTtBQUNaXCIsXCJzb3VyY2VzQ29udGVudFwiOltcImh0bWwsIGJvZHksICoge1xcbiAgbWFyZ2luOiAwO1xcbiAgcGFkZGluZzogMDtcXG5cXG4gIGZvbnQtc3R5bGU6IG5vcm1hbDtcXG4gIGZvbnQtZmFtaWx5OiBtb25vc3BhY2U7XFxuICBmb250LXNpemU6IDEycHg7XFxuICBsaW5lLWhlaWdodDogMTZweDtcXG59XFxuXFxuaW5wdXQge1xcbiAgZm9udC1zdHlsZTogbm9ybWFsO1xcbiAgZm9udC1mYW1pbHk6IG1vbm9zcGFjZTtcXG4gIGZvbnQtc2l6ZTogMTJweDtcXG4gIGxpbmUtaGVpZ2h0OiAxNnB4O1xcbn1cXG5cXG5ib2R5IHtcXG4gIHBvc2l0aW9uOiBhYnNvbHV0ZTtcXG4gIGJvdHRvbTogMDtcXG4gIGxlZnQ6IDA7XFxuICByaWdodDogMDtcXG4gIG92ZXJmbG93OiBoaWRkZW47XFxufVxcblxcbi52aW12aXhlbi1jb25zb2xlIHtcXG4gIGJvdHRvbTogMDtcXG4gIG1hcmdpbjogMDtcXG4gIHBhZGRpbmc6IDA7XFxufVxcblwiXSxcInNvdXJjZVJvb3RcIjpcIlwifV0pO1xuLy8gRXhwb3J0c1xuZXhwb3J0IGRlZmF1bHQgX19fQ1NTX0xPQURFUl9FWFBPUlRfX187XG4iLCJpbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgc3R5bGVkIGZyb20gXCIuLi8uLi9jb2xvcnNjaGVtZS9zdHlsZWRcIjtcblxuY29uc3QgQ29udGFpbmVyID0gc3R5bGVkLmRpdmBcbiAgYmFja2dyb3VuZC1jb2xvcjogJHsoeyB0aGVtZSB9KSA9PiB0aGVtZS5jb21tYW5kQmFja2dyb3VuZH07XG4gIGNvbG9yOiAkeyh7IHRoZW1lIH0pID0+IHRoZW1lLmNvbW1hbmRGb3JlZ3JvdW5kfTtcbiAgZGlzcGxheTogZmxleDtcbmA7XG5cbmNvbnN0IFByb21wdCA9IHN0eWxlZC5pYFxuICBmb250LXN0eWxlOiBub3JtYWw7XG5gO1xuXG5jb25zdCBJbnB1dElubmVyID0gc3R5bGVkLmlucHV0YFxuICBib3JkZXI6IG5vbmU7XG4gIGZsZXgtZ3JvdzogMTtcbiAgYmFja2dyb3VuZC1jb2xvcjogJHsoeyB0aGVtZSB9KSA9PiB0aGVtZS5jb21tYW5kQmFja2dyb3VuZH07XG4gIGNvbG9yOiAkeyh7IHRoZW1lIH0pID0+IHRoZW1lLmNvbW1hbmRGb3JlZ3JvdW5kfTtcbmA7XG5cbmludGVyZmFjZSBQcm9wcyB7XG4gIHByb21wdDogc3RyaW5nO1xuICB2YWx1ZTogc3RyaW5nO1xuICBvbkJsdXI6IChlOiBSZWFjdC5Gb2N1c0V2ZW50PEhUTUxJbnB1dEVsZW1lbnQ+KSA9PiB2b2lkO1xuICBvbktleURvd246IChlOiBSZWFjdC5LZXlib2FyZEV2ZW50PEhUTUxJbnB1dEVsZW1lbnQ+KSA9PiB2b2lkO1xuICBvbkNoYW5nZTogKGU6IFJlYWN0LkNoYW5nZUV2ZW50PEhUTUxJbnB1dEVsZW1lbnQ+KSA9PiB2b2lkO1xufVxuXG5jb25zdCBJbnB1dDogUmVhY3QuRkM8UHJvcHM+ID0gKHByb3BzKSA9PiB7XG4gIGNvbnN0IGlucHV0ID0gUmVhY3QudXNlUmVmPEhUTUxJbnB1dEVsZW1lbnQ+KG51bGwpO1xuXG4gIFJlYWN0LnVzZUVmZmVjdCgoKSA9PiB7XG4gICAgaW5wdXQ/LmN1cnJlbnQ/LmZvY3VzKCk7XG4gIH0sIFtdKTtcblxuICByZXR1cm4gKFxuICAgIDxDb250YWluZXI+XG4gICAgICA8UHJvbXB0Pntwcm9wcy5wcm9tcHR9PC9Qcm9tcHQ+XG4gICAgICA8SW5wdXRJbm5lclxuICAgICAgICByZWY9e2lucHV0fVxuICAgICAgICBvbkJsdXI9e3Byb3BzLm9uQmx1cn1cbiAgICAgICAgb25LZXlEb3duPXtwcm9wcy5vbktleURvd259XG4gICAgICAgIG9uQ2hhbmdlPXtwcm9wcy5vbkNoYW5nZX1cbiAgICAgICAgdmFsdWU9e3Byb3BzLnZhbHVlfVxuICAgICAgLz5cbiAgICA8L0NvbnRhaW5lcj5cbiAgKTtcbn07XG5cbmV4cG9ydCBkZWZhdWx0IElucHV0O1xuIiwiaW1wb3J0IFJlYWN0IGZyb20gXCJyZWFjdFwiO1xuaW1wb3J0IENvbnNvbGVGcmFtZUNsaWVudCBmcm9tIFwiLi4vY2xpZW50cy9Db25zb2xlRnJhbWVDbGllbnRcIjtcblxuY29uc3QgdXNlQXV0b1Jlc2l6ZSA9ICgpID0+IHtcbiAgY29uc3QgW3ByZXZXaWR0aCwgc2V0UHJldldpZHRoXSA9IFJlYWN0LnVzZVN0YXRlKC0xKTtcbiAgY29uc3QgW3ByZXZIZWlnaHQsIHNldFByZXZIZWlnaHRdID0gUmVhY3QudXNlU3RhdGUoLTEpO1xuXG4gIGNvbnN0IGNvbnNvbGVGcmFtZUNsaWVudCA9IFJlYWN0LnVzZU1lbW8oKCkgPT4ge1xuICAgIHJldHVybiBuZXcgQ29uc29sZUZyYW1lQ2xpZW50KCk7XG4gIH0sIFtdKTtcblxuICBSZWFjdC51c2VMYXlvdXRFZmZlY3QoKCkgPT4ge1xuICAgIGNvbnN0IHsgc2Nyb2xsV2lkdGg6IHdpZHRoLCBzY3JvbGxIZWlnaHQ6IGhlaWdodCB9ID1cbiAgICAgIGRvY3VtZW50LmdldEVsZW1lbnRCeUlkKFwidmltdml4ZW4tY29uc29sZVwiKSE7XG4gICAgY29uc29sZUZyYW1lQ2xpZW50LnJlc2l6ZSh3aWR0aCwgaGVpZ2h0KTtcblxuICAgIGlmICh3aWR0aCA9PT0gcHJldldpZHRoICYmIGhlaWdodCA9PT0gcHJldkhlaWdodCkge1xuICAgICAgcmV0dXJuO1xuICAgIH1cblxuICAgIHNldFByZXZXaWR0aCh3aWR0aCk7XG4gICAgc2V0UHJldkhlaWdodChoZWlnaHQpO1xuICB9KTtcbn07XG5cbmV4cG9ydCBkZWZhdWx0IHVzZUF1dG9SZXNpemU7XG4iLCJleHBvcnQgY29uc3QgU0hPV19DT01NQU5EID0gXCJzaG93LmNvbW1hbmRcIjtcbmV4cG9ydCBjb25zdCBTSE9XX0VSUk9SID0gXCJzaG93LmVycm9yXCI7XG5leHBvcnQgY29uc3QgU0hPV19JTkZPID0gXCJzaG93LmluZm9cIjtcbmV4cG9ydCBjb25zdCBISURFX0NPTU1BTkQgPSBcImhpZGUuY29tbWFuZFwiO1xuZXhwb3J0IGNvbnN0IFNIT1dfRklORCA9IFwic2hvdy5maW5kXCI7XG5leHBvcnQgY29uc3QgSElERSA9IFwiaGlkZVwiO1xuXG5leHBvcnQgaW50ZXJmYWNlIEhpZGVBY3Rpb24ge1xuICB0eXBlOiB0eXBlb2YgSElERTtcbn1cblxuZXhwb3J0IGludGVyZmFjZSBTaG93Q29tbWFuZCB7XG4gIHR5cGU6IHR5cGVvZiBTSE9XX0NPTU1BTkQ7XG4gIHRleHQ6IHN0cmluZztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBTaG93RmluZEFjdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBTSE9XX0ZJTkQ7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgU2hvd0Vycm9yQWN0aW9uIHtcbiAgdHlwZTogdHlwZW9mIFNIT1dfRVJST1I7XG4gIHRleHQ6IHN0cmluZztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBTaG93SW5mb0FjdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBTSE9XX0lORk87XG4gIHRleHQ6IHN0cmluZztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBIaWRlQ29tbWFuZEFjdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBISURFX0NPTU1BTkQ7XG59XG5cbmV4cG9ydCB0eXBlIEFwcEFjdGlvbiA9XG4gIHwgSGlkZUFjdGlvblxuICB8IFNob3dDb21tYW5kXG4gIHwgU2hvd0ZpbmRBY3Rpb25cbiAgfCBTaG93RXJyb3JBY3Rpb25cbiAgfCBTaG93SW5mb0FjdGlvblxuICB8IEhpZGVDb21tYW5kQWN0aW9uO1xuXG5jb25zdCBoaWRlID0gKCk6IEhpZGVBY3Rpb24gPT4ge1xuICByZXR1cm4ge1xuICAgIHR5cGU6IEhJREUsXG4gIH07XG59O1xuXG5jb25zdCBzaG93Q29tbWFuZCA9ICh0ZXh0OiBzdHJpbmcpOiBTaG93Q29tbWFuZCA9PiB7XG4gIHJldHVybiB7XG4gICAgdHlwZTogU0hPV19DT01NQU5ELFxuICAgIHRleHQsXG4gIH07XG59O1xuXG5jb25zdCBzaG93RmluZCA9ICgpOiBTaG93RmluZEFjdGlvbiA9PiB7XG4gIHJldHVybiB7XG4gICAgdHlwZTogU0hPV19GSU5ELFxuICB9O1xufTtcblxuY29uc3Qgc2hvd0Vycm9yID0gKHRleHQ6IHN0cmluZyk6IFNob3dFcnJvckFjdGlvbiA9PiB7XG4gIHJldHVybiB7XG4gICAgdHlwZTogU0hPV19FUlJPUixcbiAgICB0ZXh0OiB0ZXh0LFxuICB9O1xufTtcblxuY29uc3Qgc2hvd0luZm8gPSAodGV4dDogc3RyaW5nKTogU2hvd0luZm9BY3Rpb24gPT4ge1xuICByZXR1cm4ge1xuICAgIHR5cGU6IFNIT1dfSU5GTyxcbiAgICB0ZXh0OiB0ZXh0LFxuICB9O1xufTtcblxuY29uc3QgaGlkZUNvbW1hbmQgPSAoKTogSGlkZUNvbW1hbmRBY3Rpb24gPT4ge1xuICByZXR1cm4ge1xuICAgIHR5cGU6IEhJREVfQ09NTUFORCxcbiAgfTtcbn07XG5cbmV4cG9ydCB7IGhpZGUsIHNob3dDb21tYW5kLCBzaG93RmluZCwgc2hvd0Vycm9yLCBzaG93SW5mbywgaGlkZUNvbW1hbmQgfTtcbiIsImltcG9ydCBSZWFjdCBmcm9tIFwicmVhY3RcIjtcbmltcG9ydCB7IFN0YXRlLCBkZWZhdWx0U3RhdGUgfSBmcm9tIFwiLi9yZWN1ZXJcIjtcbmltcG9ydCB7IEFwcEFjdGlvbiB9IGZyb20gXCIuL2FjdGlvbnNcIjtcblxuZXhwb3J0IGNvbnN0IEFwcFN0YXRlQ29udGV4dCA9IFJlYWN0LmNyZWF0ZUNvbnRleHQ8U3RhdGU+KGRlZmF1bHRTdGF0ZSk7XG5cbmV4cG9ydCBjb25zdCBBcHBEaXNwYXRjaENvbnRleHQgPSBSZWFjdC5jcmVhdGVDb250ZXh0PFxuICAoYWN0aW9uOiBBcHBBY3Rpb24pID0+IHZvaWRcbj4oKCkgPT4ge30pO1xuIiwiaW1wb3J0IHtcbiAgSElERSxcbiAgSElERV9DT01NQU5ELFxuICBTSE9XX0NPTU1BTkQsXG4gIFNIT1dfRVJST1IsXG4gIFNIT1dfRklORCxcbiAgU0hPV19JTkZPLFxuICBBcHBBY3Rpb24sXG59IGZyb20gXCIuL2FjdGlvbnNcIjtcblxuZXhwb3J0IGludGVyZmFjZSBTdGF0ZSB7XG4gIG1vZGU6IHN0cmluZztcbiAgbWVzc2FnZVRleHQ6IHN0cmluZztcbiAgY29uc29sZVRleHQ6IHN0cmluZztcbn1cblxuZXhwb3J0IGNvbnN0IGRlZmF1bHRTdGF0ZSA9IHtcbiAgbW9kZTogXCJcIixcbiAgbWVzc2FnZVRleHQ6IFwiXCIsXG4gIGNvbnNvbGVUZXh0OiBcIlwiLFxufTtcblxuLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG1heC1saW5lcy1wZXItZnVuY3Rpb25cbmV4cG9ydCBkZWZhdWx0IGZ1bmN0aW9uIHJlZHVjZXIoXG4gIHN0YXRlOiBTdGF0ZSA9IGRlZmF1bHRTdGF0ZSxcbiAgYWN0aW9uOiBBcHBBY3Rpb25cbik6IFN0YXRlIHtcbiAgc3dpdGNoIChhY3Rpb24udHlwZSkge1xuICAgIGNhc2UgSElERTpcbiAgICAgIHJldHVybiB7IC4uLnN0YXRlLCBtb2RlOiBcIlwiIH07XG4gICAgY2FzZSBTSE9XX0NPTU1BTkQ6XG4gICAgICByZXR1cm4ge1xuICAgICAgICAuLi5zdGF0ZSxcbiAgICAgICAgbW9kZTogXCJjb21tYW5kXCIsXG4gICAgICAgIGNvbnNvbGVUZXh0OiBhY3Rpb24udGV4dCxcbiAgICAgIH07XG4gICAgY2FzZSBTSE9XX0ZJTkQ6XG4gICAgICByZXR1cm4geyAuLi5zdGF0ZSwgbW9kZTogXCJmaW5kXCIsIGNvbnNvbGVUZXh0OiBcIlwiIH07XG4gICAgY2FzZSBTSE9XX0VSUk9SOlxuICAgICAgcmV0dXJuIHsgLi4uc3RhdGUsIG1vZGU6IFwiZXJyb3JcIiwgbWVzc2FnZVRleHQ6IGFjdGlvbi50ZXh0IH07XG4gICAgY2FzZSBTSE9XX0lORk86XG4gICAgICByZXR1cm4geyAuLi5zdGF0ZSwgbW9kZTogXCJpbmZvXCIsIG1lc3NhZ2VUZXh0OiBhY3Rpb24udGV4dCB9O1xuICAgIGNhc2UgSElERV9DT01NQU5EOlxuICAgICAgcmV0dXJuIHtcbiAgICAgICAgLi4uc3RhdGUsXG4gICAgICAgIG1vZGU6XG4gICAgICAgICAgc3RhdGUubW9kZSA9PT0gXCJjb21tYW5kXCIgfHwgc3RhdGUubW9kZSA9PT0gXCJmaW5kXCIgPyBcIlwiIDogc3RhdGUubW9kZSxcbiAgICAgIH07XG4gICAgZGVmYXVsdDpcbiAgICAgIHJldHVybiBzdGF0ZTtcbiAgfVxufVxuIiwiaW1wb3J0IENvbXBsZXRpb25UeXBlIGZyb20gXCIuLi8uLi9zaGFyZWQvQ29tcGxldGlvblR5cGVcIjtcbmltcG9ydCBDb21wbGV0aW9ucyBmcm9tIFwiLi4vQ29tcGxldGlvbnNcIjtcblxuZXhwb3J0IGNvbnN0IElOSVRfQ09NUExFVElPTlMgPSBcInJlc2V0LmNvbXBsZXRpb25zXCI7XG5leHBvcnQgY29uc3QgU0VUX0NPTVBMRVRJT05fU09VUkNFID0gXCJzZXQuY29tcGxldGlvbi5zb3VyY2VcIjtcbmV4cG9ydCBjb25zdCBTRVRfQ09NUExFVElPTlMgPSBcInNldC5jb21wbGV0aW9uc1wiO1xuZXhwb3J0IGNvbnN0IENPTVBMRVRJT05fTkVYVCA9IFwiY29tcGxldGlvbi5uZXh0XCI7XG5leHBvcnQgY29uc3QgQ09NUExFVElPTl9QUkVWID0gXCJjb21wbGV0aW9uLnByZXZcIjtcblxuZXhwb3J0IGludGVyZmFjZSBJbml0Q29tcGxldGlvbkFjdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBJTklUX0NPTVBMRVRJT05TO1xuICBjb21wbGV0aW9uVHlwZXM6IENvbXBsZXRpb25UeXBlW107XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgU2V0Q29tcGxldGlvblNvdXJjZUFjdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBTRVRfQ09NUExFVElPTl9TT1VSQ0U7XG4gIGNvbXBsZXRpb25Tb3VyY2U6IHN0cmluZztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBTZXRDb21wbGV0aW9uc0FjdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBTRVRfQ09NUExFVElPTlM7XG4gIGNvbXBsZXRpb25zOiBDb21wbGV0aW9ucztcbn1cblxuZXhwb3J0IGludGVyZmFjZSBDb21wbGV0aW9uTmV4dEFjdGlvbiB7XG4gIHR5cGU6IHR5cGVvZiBDT01QTEVUSU9OX05FWFQ7XG59XG5cbmV4cG9ydCBpbnRlcmZhY2UgQ29tcGxldGlvblByZXZBY3Rpb24ge1xuICB0eXBlOiB0eXBlb2YgQ09NUExFVElPTl9QUkVWO1xufVxuXG5leHBvcnQgdHlwZSBDb21wbGV0aW9uQWN0aW9uID1cbiAgfCBJbml0Q29tcGxldGlvbkFjdGlvblxuICB8IFNldENvbXBsZXRpb25Tb3VyY2VBY3Rpb25cbiAgfCBTZXRDb21wbGV0aW9uc0FjdGlvblxuICB8IENvbXBsZXRpb25OZXh0QWN0aW9uXG4gIHwgQ29tcGxldGlvblByZXZBY3Rpb247XG5cbmV4cG9ydCBjb25zdCBpbml0Q29tcGxldGlvbiA9IChcbiAgY29tcGxldGlvblR5cGVzOiBDb21wbGV0aW9uVHlwZVtdXG4pOiBJbml0Q29tcGxldGlvbkFjdGlvbiA9PiB7XG4gIHJldHVybiB7XG4gICAgdHlwZTogSU5JVF9DT01QTEVUSU9OUyxcbiAgICBjb21wbGV0aW9uVHlwZXMsXG4gIH07XG59O1xuZXhwb3J0IGNvbnN0IHNldENvbXBsZXRpb25Tb3VyY2UgPSAoXG4gIHF1ZXJ5OiBzdHJpbmdcbik6IFNldENvbXBsZXRpb25Tb3VyY2VBY3Rpb24gPT4ge1xuICByZXR1cm4ge1xuICAgIHR5cGU6IFNFVF9DT01QTEVUSU9OX1NPVVJDRSxcbiAgICBjb21wbGV0aW9uU291cmNlOiBxdWVyeSxcbiAgfTtcbn07XG5cbmV4cG9ydCBjb25zdCBzZXRDb21wbGV0aW9ucyA9IChcbiAgY29tcGxldGlvbnM6IENvbXBsZXRpb25zXG4pOiBTZXRDb21wbGV0aW9uc0FjdGlvbiA9PiB7XG4gIHJldHVybiB7XG4gICAgdHlwZTogU0VUX0NPTVBMRVRJT05TLFxuICAgIGNvbXBsZXRpb25zLFxuICB9O1xufTtcblxuZXhwb3J0IGNvbnN0IHNlbGVjdE5leHQgPSAoKTogQ29tcGxldGlvbk5leHRBY3Rpb24gPT4ge1xuICByZXR1cm4ge1xuICAgIHR5cGU6IENPTVBMRVRJT05fTkVYVCxcbiAgfTtcbn07XG5cbmV4cG9ydCBjb25zdCBzZWxlY3RQcmV2ID0gKCk6IENvbXBsZXRpb25QcmV2QWN0aW9uID0+IHtcbiAgcmV0dXJuIHtcbiAgICB0eXBlOiBDT01QTEVUSU9OX1BSRVYsXG4gIH07XG59O1xuIiwiZXhwb3J0IGVudW0gQ29tbWFuZCB7XG4gIE9wZW4gPSBcIm9wZW5cIixcbiAgVGFiT3BlbiA9IFwidGFib3BlblwiLFxuICBXaW5kb3dPcGVuID0gXCJ3aW5vcGVuXCIsXG4gIEJ1ZmZlciA9IFwiYnVmZmVyXCIsXG4gIEJ1ZmZlckRlbGV0ZSA9IFwiYmRlbGV0ZVwiLFxuICBCdWZmZXJEZWxldGVGb3JjZSA9IFwiYmRlbGV0ZSFcIixcbiAgQnVmZmVyc0RlbGV0ZSA9IFwiYmRlbGV0ZXNcIixcbiAgQnVmZmVyc0RlbGV0ZUZvcmNlID0gXCJiZGVsZXRlcyFcIixcbiAgQWRkQm9va21hcmsgPSBcImFkZGJvb2ttYXJrXCIsXG4gIFF1aXQgPSBcInF1aXRcIixcbiAgUXVpdEFsbCA9IFwicXVpdGFsbFwiLFxuICBTZXQgPSBcInNldFwiLFxuICBIZWxwID0gXCJoZWxwXCIsXG59XG4iLCJpbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgeyBTdGF0ZSwgZGVmYXVsdFN0YXRlIH0gZnJvbSBcIi4vcmVkdWNlclwiO1xuaW1wb3J0IHsgQ29tcGxldGlvbkFjdGlvbiB9IGZyb20gXCIuL2FjdGlvbnNcIjtcblxuZXhwb3J0IGNvbnN0IENvbXBsZXRpb25TdGF0ZUNvbnRleHQgPSBSZWFjdC5jcmVhdGVDb250ZXh0PFN0YXRlPihkZWZhdWx0U3RhdGUpO1xuXG5leHBvcnQgY29uc3QgQ29tcGxldGlvbkRpc3BhdGNoQ29udGV4dCA9IFJlYWN0LmNyZWF0ZUNvbnRleHQ8XG4gIChhY3Rpb246IENvbXBsZXRpb25BY3Rpb24pID0+IHZvaWRcbj4oKCkgPT4ge30pO1xuIiwiaW1wb3J0IENvbXBsZXRpb25zIGZyb20gXCIuLi9Db21wbGV0aW9uc1wiO1xuaW1wb3J0IENvbXBsZXRpb25UeXBlIGZyb20gXCIuLi8uLi9zaGFyZWQvQ29tcGxldGlvblR5cGVcIjtcbmltcG9ydCB7XG4gIElOSVRfQ09NUExFVElPTlMsXG4gIFNFVF9DT01QTEVUSU9OX1NPVVJDRSxcbiAgU0VUX0NPTVBMRVRJT05TLFxuICBDT01QTEVUSU9OX05FWFQsXG4gIENPTVBMRVRJT05fUFJFVixcbiAgQ29tcGxldGlvbkFjdGlvbixcbn0gZnJvbSBcIi4vYWN0aW9uc1wiO1xuXG5leHBvcnQgaW50ZXJmYWNlIFN0YXRlIHtcbiAgY29tcGxldGlvblR5cGVzPzogQ29tcGxldGlvblR5cGVbXTtcbiAgY29tcGxldGlvblNvdXJjZTogc3RyaW5nO1xuICBjb21wbGV0aW9uczogQ29tcGxldGlvbnM7XG4gIHNlbGVjdDogbnVtYmVyO1xufVxuXG5leHBvcnQgY29uc3QgZGVmYXVsdFN0YXRlID0ge1xuICBjb21wbGV0aW9uVHlwZXM6IHVuZGVmaW5lZCxcbiAgY29tcGxldGlvblNvdXJjZTogXCJcIixcbiAgY29tcGxldGlvbnM6IFtdLFxuICBzZWxlY3Q6IC0xLFxufTtcblxuY29uc3QgbmV4dFNlbGVjdGlvbiA9IChzdGF0ZTogU3RhdGUpOiBudW1iZXIgPT4ge1xuICBjb25zdCBsZW5ndGggPSBzdGF0ZS5jb21wbGV0aW9uc1xuICAgIC5tYXAoKGcpID0+IGcuaXRlbXMubGVuZ3RoKVxuICAgIC5yZWR1Y2UoKHgsIHkpID0+IHggKyB5LCAwKTtcbiAgaWYgKGxlbmd0aCA9PT0gMCkge1xuICAgIHJldHVybiAtMTtcbiAgfVxuICBpZiAoc3RhdGUuc2VsZWN0IDwgMCkge1xuICAgIHJldHVybiAwO1xuICB9XG4gIGlmIChzdGF0ZS5zZWxlY3QgKyAxIDwgbGVuZ3RoKSB7XG4gICAgcmV0dXJuIHN0YXRlLnNlbGVjdCArIDE7XG4gIH1cbiAgcmV0dXJuIC0xO1xufTtcblxuY29uc3QgcHJldlNlbGVjdGlvbiA9IChzdGF0ZTogU3RhdGUpOiBudW1iZXIgPT4ge1xuICBpZiAoc3RhdGUuY29tcGxldGlvbnMubGVuZ3RoID09PSAwKSB7XG4gICAgcmV0dXJuIC0xO1xuICB9XG4gIGNvbnN0IGxlbmd0aCA9IHN0YXRlLmNvbXBsZXRpb25zXG4gICAgLm1hcCgoZykgPT4gZy5pdGVtcy5sZW5ndGgpXG4gICAgLnJlZHVjZSgoeCwgeSkgPT4geCArIHkpO1xuICBpZiAoc3RhdGUuc2VsZWN0IDwgMCkge1xuICAgIHJldHVybiBsZW5ndGggLSAxO1xuICB9XG4gIHJldHVybiBzdGF0ZS5zZWxlY3QgLSAxO1xufTtcblxuLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIG1heC1saW5lcy1wZXItZnVuY3Rpb25cbmV4cG9ydCBkZWZhdWx0IGZ1bmN0aW9uIHJlZHVjZXIoXG4gIHN0YXRlOiBTdGF0ZSA9IGRlZmF1bHRTdGF0ZSxcbiAgYWN0aW9uOiBDb21wbGV0aW9uQWN0aW9uXG4pOiBTdGF0ZSB7XG4gIHN3aXRjaCAoYWN0aW9uLnR5cGUpIHtcbiAgICBjYXNlIElOSVRfQ09NUExFVElPTlM6XG4gICAgICByZXR1cm4ge1xuICAgICAgICAuLi5zdGF0ZSxcbiAgICAgICAgY29tcGxldGlvblR5cGVzOiBhY3Rpb24uY29tcGxldGlvblR5cGVzLFxuICAgICAgICBjb21wbGV0aW9uczogW10sXG4gICAgICAgIHNlbGVjdDogLTEsXG4gICAgICB9O1xuICAgIGNhc2UgU0VUX0NPTVBMRVRJT05fU09VUkNFOlxuICAgICAgcmV0dXJuIHtcbiAgICAgICAgLi4uc3RhdGUsXG4gICAgICAgIGNvbXBsZXRpb25Tb3VyY2U6IGFjdGlvbi5jb21wbGV0aW9uU291cmNlLFxuICAgICAgICBzZWxlY3Q6IC0xLFxuICAgICAgfTtcbiAgICBjYXNlIFNFVF9DT01QTEVUSU9OUzpcbiAgICAgIHJldHVybiB7XG4gICAgICAgIC4uLnN0YXRlLFxuICAgICAgICBjb21wbGV0aW9uczogYWN0aW9uLmNvbXBsZXRpb25zLFxuICAgICAgfTtcbiAgICBjYXNlIENPTVBMRVRJT05fTkVYVDoge1xuICAgICAgY29uc3Qgc2VsZWN0ID0gbmV4dFNlbGVjdGlvbihzdGF0ZSk7XG4gICAgICByZXR1cm4ge1xuICAgICAgICAuLi5zdGF0ZSxcbiAgICAgICAgc2VsZWN0OiBzZWxlY3QsXG4gICAgICB9O1xuICAgIH1cbiAgICBjYXNlIENPTVBMRVRJT05fUFJFVjoge1xuICAgICAgY29uc3Qgc2VsZWN0ID0gcHJldlNlbGVjdGlvbihzdGF0ZSk7XG4gICAgICByZXR1cm4ge1xuICAgICAgICAuLi5zdGF0ZSxcbiAgICAgICAgc2VsZWN0OiBzZWxlY3QsXG4gICAgICB9O1xuICAgIH1cbiAgICBkZWZhdWx0OlxuICAgICAgcmV0dXJuIHN0YXRlO1xuICB9XG59XG4iLCJpbXBvcnQgeyBDb21tYW5kIH0gZnJvbSBcIi4uLy4uL3NoYXJlZC9Db21tYW5kXCI7XG5cbmV4cG9ydCBjbGFzcyBVbmtub3duQ29tbWFuZEVycm9yIGV4dGVuZHMgRXJyb3Ige1xuICBjb25zdHJ1Y3Rvcih2YWx1ZTogc3RyaW5nKSB7XG4gICAgc3VwZXIoYHVua25vd24gY29tbWFuZCAnJHt2YWx1ZX0nYCk7XG4gIH1cbn1cblxuZXhwb3J0IGRlZmF1bHQgY2xhc3MgQ29tbWFuZFBhcnNlciB7XG4gIHBhcnNlKHZhbHVlOiBzdHJpbmcpOiBDb21tYW5kIHtcbiAgICBzd2l0Y2ggKHZhbHVlKSB7XG4gICAgICBjYXNlIFwib1wiOlxuICAgICAgY2FzZSBcIm9wZW5cIjpcbiAgICAgICAgcmV0dXJuIENvbW1hbmQuT3BlbjtcbiAgICAgIGNhc2UgXCJ0XCI6XG4gICAgICBjYXNlIFwidGFib3BlblwiOlxuICAgICAgICByZXR1cm4gQ29tbWFuZC5UYWJPcGVuO1xuICAgICAgY2FzZSBcIndcIjpcbiAgICAgIGNhc2UgXCJ3aW5vcGVuXCI6XG4gICAgICAgIHJldHVybiBDb21tYW5kLldpbmRvd09wZW47XG4gICAgICBjYXNlIFwiYlwiOlxuICAgICAgY2FzZSBcImJ1ZmZlclwiOlxuICAgICAgICByZXR1cm4gQ29tbWFuZC5CdWZmZXI7XG4gICAgICBjYXNlIFwiYmRcIjpcbiAgICAgIGNhc2UgXCJiZGVsXCI6XG4gICAgICBjYXNlIFwiYmRlbGV0ZVwiOlxuICAgICAgICByZXR1cm4gQ29tbWFuZC5CdWZmZXJEZWxldGU7XG4gICAgICBjYXNlIFwiYmQhXCI6XG4gICAgICBjYXNlIFwiYmRlbCFcIjpcbiAgICAgIGNhc2UgXCJiZGVsZXRlIVwiOlxuICAgICAgICByZXR1cm4gQ29tbWFuZC5CdWZmZXJEZWxldGVGb3JjZTtcbiAgICAgIGNhc2UgXCJiZGVsZXRlc1wiOlxuICAgICAgICByZXR1cm4gQ29tbWFuZC5CdWZmZXJzRGVsZXRlO1xuICAgICAgY2FzZSBcImJkZWxldGVzIVwiOlxuICAgICAgICByZXR1cm4gQ29tbWFuZC5CdWZmZXJzRGVsZXRlRm9yY2U7XG4gICAgICBjYXNlIFwiYWRkYm9va21hcmtcIjpcbiAgICAgICAgcmV0dXJuIENvbW1hbmQuQWRkQm9va21hcms7XG4gICAgICBjYXNlIFwicVwiOlxuICAgICAgY2FzZSBcInF1aXRcIjpcbiAgICAgICAgcmV0dXJuIENvbW1hbmQuUXVpdDtcbiAgICAgIGNhc2UgXCJxYVwiOlxuICAgICAgY2FzZSBcInF1aXRhbGxcIjpcbiAgICAgICAgcmV0dXJuIENvbW1hbmQuUXVpdEFsbDtcbiAgICAgIGNhc2UgXCJzZXRcIjpcbiAgICAgICAgcmV0dXJuIENvbW1hbmQuU2V0O1xuICAgICAgY2FzZSBcImhcIjpcbiAgICAgIGNhc2UgXCJoZWxwXCI6XG4gICAgICAgIHJldHVybiBDb21tYW5kLkhlbHA7XG4gICAgfVxuICAgIHRocm93IG5ldyBVbmtub3duQ29tbWFuZEVycm9yKHZhbHVlKTtcbiAgfVxufVxuIiwiaW1wb3J0IFJlYWN0IGZyb20gXCJyZWFjdFwiO1xuaW1wb3J0IENvbG9yU2NoZW1lIGZyb20gXCIuLi8uLi9zaGFyZWQvQ29sb3JTY2hlbWVcIjtcblxuZXhwb3J0IGNvbnN0IENvbG9yU2NoZW1lQ29udGV4dCA9IFJlYWN0LmNyZWF0ZUNvbnRleHQ8Q29sb3JTY2hlbWU+KFxuICBDb2xvclNjaGVtZS5TeXN0ZW1cbik7XG5cbmV4cG9ydCBjb25zdCBDb2xvclNjaGVtZVVwZGF0ZUNvbnRleHQgPSBSZWFjdC5jcmVhdGVDb250ZXh0PFxuICAoY29sb3JzY2hlbWU6IENvbG9yU2NoZW1lKSA9PiB2b2lkXG4+KCgpID0+IHt9KTtcbiIsIlwidXNlIHN0cmljdFwiO1xuXG52YXIgaXNPbGRJRSA9IGZ1bmN0aW9uIGlzT2xkSUUoKSB7XG4gIHZhciBtZW1vO1xuICByZXR1cm4gZnVuY3Rpb24gbWVtb3JpemUoKSB7XG4gICAgaWYgKHR5cGVvZiBtZW1vID09PSAndW5kZWZpbmVkJykge1xuICAgICAgLy8gVGVzdCBmb3IgSUUgPD0gOSBhcyBwcm9wb3NlZCBieSBCcm93c2VyaGFja3NcbiAgICAgIC8vIEBzZWUgaHR0cDovL2Jyb3dzZXJoYWNrcy5jb20vI2hhY2stZTcxZDg2OTJmNjUzMzQxNzNmZWU3MTVjMjIyY2I4MDVcbiAgICAgIC8vIFRlc3RzIGZvciBleGlzdGVuY2Ugb2Ygc3RhbmRhcmQgZ2xvYmFscyBpcyB0byBhbGxvdyBzdHlsZS1sb2FkZXJcbiAgICAgIC8vIHRvIG9wZXJhdGUgY29ycmVjdGx5IGludG8gbm9uLXN0YW5kYXJkIGVudmlyb25tZW50c1xuICAgICAgLy8gQHNlZSBodHRwczovL2dpdGh1Yi5jb20vd2VicGFjay1jb250cmliL3N0eWxlLWxvYWRlci9pc3N1ZXMvMTc3XG4gICAgICBtZW1vID0gQm9vbGVhbih3aW5kb3cgJiYgZG9jdW1lbnQgJiYgZG9jdW1lbnQuYWxsICYmICF3aW5kb3cuYXRvYik7XG4gICAgfVxuXG4gICAgcmV0dXJuIG1lbW87XG4gIH07XG59KCk7XG5cbnZhciBnZXRUYXJnZXQgPSBmdW5jdGlvbiBnZXRUYXJnZXQoKSB7XG4gIHZhciBtZW1vID0ge307XG4gIHJldHVybiBmdW5jdGlvbiBtZW1vcml6ZSh0YXJnZXQpIHtcbiAgICBpZiAodHlwZW9mIG1lbW9bdGFyZ2V0XSA9PT0gJ3VuZGVmaW5lZCcpIHtcbiAgICAgIHZhciBzdHlsZVRhcmdldCA9IGRvY3VtZW50LnF1ZXJ5U2VsZWN0b3IodGFyZ2V0KTsgLy8gU3BlY2lhbCBjYXNlIHRvIHJldHVybiBoZWFkIG9mIGlmcmFtZSBpbnN0ZWFkIG9mIGlmcmFtZSBpdHNlbGZcblxuICAgICAgaWYgKHdpbmRvdy5IVE1MSUZyYW1lRWxlbWVudCAmJiBzdHlsZVRhcmdldCBpbnN0YW5jZW9mIHdpbmRvdy5IVE1MSUZyYW1lRWxlbWVudCkge1xuICAgICAgICB0cnkge1xuICAgICAgICAgIC8vIFRoaXMgd2lsbCB0aHJvdyBhbiBleGNlcHRpb24gaWYgYWNjZXNzIHRvIGlmcmFtZSBpcyBibG9ja2VkXG4gICAgICAgICAgLy8gZHVlIHRvIGNyb3NzLW9yaWdpbiByZXN0cmljdGlvbnNcbiAgICAgICAgICBzdHlsZVRhcmdldCA9IHN0eWxlVGFyZ2V0LmNvbnRlbnREb2N1bWVudC5oZWFkO1xuICAgICAgICB9IGNhdGNoIChlKSB7XG4gICAgICAgICAgLy8gaXN0YW5idWwgaWdub3JlIG5leHRcbiAgICAgICAgICBzdHlsZVRhcmdldCA9IG51bGw7XG4gICAgICAgIH1cbiAgICAgIH1cblxuICAgICAgbWVtb1t0YXJnZXRdID0gc3R5bGVUYXJnZXQ7XG4gICAgfVxuXG4gICAgcmV0dXJuIG1lbW9bdGFyZ2V0XTtcbiAgfTtcbn0oKTtcblxudmFyIHN0eWxlc0luRG9tID0gW107XG5cbmZ1bmN0aW9uIGdldEluZGV4QnlJZGVudGlmaWVyKGlkZW50aWZpZXIpIHtcbiAgdmFyIHJlc3VsdCA9IC0xO1xuXG4gIGZvciAodmFyIGkgPSAwOyBpIDwgc3R5bGVzSW5Eb20ubGVuZ3RoOyBpKyspIHtcbiAgICBpZiAoc3R5bGVzSW5Eb21baV0uaWRlbnRpZmllciA9PT0gaWRlbnRpZmllcikge1xuICAgICAgcmVzdWx0ID0gaTtcbiAgICAgIGJyZWFrO1xuICAgIH1cbiAgfVxuXG4gIHJldHVybiByZXN1bHQ7XG59XG5cbmZ1bmN0aW9uIG1vZHVsZXNUb0RvbShsaXN0LCBvcHRpb25zKSB7XG4gIHZhciBpZENvdW50TWFwID0ge307XG4gIHZhciBpZGVudGlmaWVycyA9IFtdO1xuXG4gIGZvciAodmFyIGkgPSAwOyBpIDwgbGlzdC5sZW5ndGg7IGkrKykge1xuICAgIHZhciBpdGVtID0gbGlzdFtpXTtcbiAgICB2YXIgaWQgPSBvcHRpb25zLmJhc2UgPyBpdGVtWzBdICsgb3B0aW9ucy5iYXNlIDogaXRlbVswXTtcbiAgICB2YXIgY291bnQgPSBpZENvdW50TWFwW2lkXSB8fCAwO1xuICAgIHZhciBpZGVudGlmaWVyID0gXCJcIi5jb25jYXQoaWQsIFwiIFwiKS5jb25jYXQoY291bnQpO1xuICAgIGlkQ291bnRNYXBbaWRdID0gY291bnQgKyAxO1xuICAgIHZhciBpbmRleCA9IGdldEluZGV4QnlJZGVudGlmaWVyKGlkZW50aWZpZXIpO1xuICAgIHZhciBvYmogPSB7XG4gICAgICBjc3M6IGl0ZW1bMV0sXG4gICAgICBtZWRpYTogaXRlbVsyXSxcbiAgICAgIHNvdXJjZU1hcDogaXRlbVszXVxuICAgIH07XG5cbiAgICBpZiAoaW5kZXggIT09IC0xKSB7XG4gICAgICBzdHlsZXNJbkRvbVtpbmRleF0ucmVmZXJlbmNlcysrO1xuICAgICAgc3R5bGVzSW5Eb21baW5kZXhdLnVwZGF0ZXIob2JqKTtcbiAgICB9IGVsc2Uge1xuICAgICAgc3R5bGVzSW5Eb20ucHVzaCh7XG4gICAgICAgIGlkZW50aWZpZXI6IGlkZW50aWZpZXIsXG4gICAgICAgIHVwZGF0ZXI6IGFkZFN0eWxlKG9iaiwgb3B0aW9ucyksXG4gICAgICAgIHJlZmVyZW5jZXM6IDFcbiAgICAgIH0pO1xuICAgIH1cblxuICAgIGlkZW50aWZpZXJzLnB1c2goaWRlbnRpZmllcik7XG4gIH1cblxuICByZXR1cm4gaWRlbnRpZmllcnM7XG59XG5cbmZ1bmN0aW9uIGluc2VydFN0eWxlRWxlbWVudChvcHRpb25zKSB7XG4gIHZhciBzdHlsZSA9IGRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoJ3N0eWxlJyk7XG4gIHZhciBhdHRyaWJ1dGVzID0gb3B0aW9ucy5hdHRyaWJ1dGVzIHx8IHt9O1xuXG4gIGlmICh0eXBlb2YgYXR0cmlidXRlcy5ub25jZSA9PT0gJ3VuZGVmaW5lZCcpIHtcbiAgICB2YXIgbm9uY2UgPSB0eXBlb2YgX193ZWJwYWNrX25vbmNlX18gIT09ICd1bmRlZmluZWQnID8gX193ZWJwYWNrX25vbmNlX18gOiBudWxsO1xuXG4gICAgaWYgKG5vbmNlKSB7XG4gICAgICBhdHRyaWJ1dGVzLm5vbmNlID0gbm9uY2U7XG4gICAgfVxuICB9XG5cbiAgT2JqZWN0LmtleXMoYXR0cmlidXRlcykuZm9yRWFjaChmdW5jdGlvbiAoa2V5KSB7XG4gICAgc3R5bGUuc2V0QXR0cmlidXRlKGtleSwgYXR0cmlidXRlc1trZXldKTtcbiAgfSk7XG5cbiAgaWYgKHR5cGVvZiBvcHRpb25zLmluc2VydCA9PT0gJ2Z1bmN0aW9uJykge1xuICAgIG9wdGlvbnMuaW5zZXJ0KHN0eWxlKTtcbiAgfSBlbHNlIHtcbiAgICB2YXIgdGFyZ2V0ID0gZ2V0VGFyZ2V0KG9wdGlvbnMuaW5zZXJ0IHx8ICdoZWFkJyk7XG5cbiAgICBpZiAoIXRhcmdldCkge1xuICAgICAgdGhyb3cgbmV3IEVycm9yKFwiQ291bGRuJ3QgZmluZCBhIHN0eWxlIHRhcmdldC4gVGhpcyBwcm9iYWJseSBtZWFucyB0aGF0IHRoZSB2YWx1ZSBmb3IgdGhlICdpbnNlcnQnIHBhcmFtZXRlciBpcyBpbnZhbGlkLlwiKTtcbiAgICB9XG5cbiAgICB0YXJnZXQuYXBwZW5kQ2hpbGQoc3R5bGUpO1xuICB9XG5cbiAgcmV0dXJuIHN0eWxlO1xufVxuXG5mdW5jdGlvbiByZW1vdmVTdHlsZUVsZW1lbnQoc3R5bGUpIHtcbiAgLy8gaXN0YW5idWwgaWdub3JlIGlmXG4gIGlmIChzdHlsZS5wYXJlbnROb2RlID09PSBudWxsKSB7XG4gICAgcmV0dXJuIGZhbHNlO1xuICB9XG5cbiAgc3R5bGUucGFyZW50Tm9kZS5yZW1vdmVDaGlsZChzdHlsZSk7XG59XG4vKiBpc3RhbmJ1bCBpZ25vcmUgbmV4dCAgKi9cblxuXG52YXIgcmVwbGFjZVRleHQgPSBmdW5jdGlvbiByZXBsYWNlVGV4dCgpIHtcbiAgdmFyIHRleHRTdG9yZSA9IFtdO1xuICByZXR1cm4gZnVuY3Rpb24gcmVwbGFjZShpbmRleCwgcmVwbGFjZW1lbnQpIHtcbiAgICB0ZXh0U3RvcmVbaW5kZXhdID0gcmVwbGFjZW1lbnQ7XG4gICAgcmV0dXJuIHRleHRTdG9yZS5maWx0ZXIoQm9vbGVhbikuam9pbignXFxuJyk7XG4gIH07XG59KCk7XG5cbmZ1bmN0aW9uIGFwcGx5VG9TaW5nbGV0b25UYWcoc3R5bGUsIGluZGV4LCByZW1vdmUsIG9iaikge1xuICB2YXIgY3NzID0gcmVtb3ZlID8gJycgOiBvYmoubWVkaWEgPyBcIkBtZWRpYSBcIi5jb25jYXQob2JqLm1lZGlhLCBcIiB7XCIpLmNvbmNhdChvYmouY3NzLCBcIn1cIikgOiBvYmouY3NzOyAvLyBGb3Igb2xkIElFXG5cbiAgLyogaXN0YW5idWwgaWdub3JlIGlmICAqL1xuXG4gIGlmIChzdHlsZS5zdHlsZVNoZWV0KSB7XG4gICAgc3R5bGUuc3R5bGVTaGVldC5jc3NUZXh0ID0gcmVwbGFjZVRleHQoaW5kZXgsIGNzcyk7XG4gIH0gZWxzZSB7XG4gICAgdmFyIGNzc05vZGUgPSBkb2N1bWVudC5jcmVhdGVUZXh0Tm9kZShjc3MpO1xuICAgIHZhciBjaGlsZE5vZGVzID0gc3R5bGUuY2hpbGROb2RlcztcblxuICAgIGlmIChjaGlsZE5vZGVzW2luZGV4XSkge1xuICAgICAgc3R5bGUucmVtb3ZlQ2hpbGQoY2hpbGROb2Rlc1tpbmRleF0pO1xuICAgIH1cblxuICAgIGlmIChjaGlsZE5vZGVzLmxlbmd0aCkge1xuICAgICAgc3R5bGUuaW5zZXJ0QmVmb3JlKGNzc05vZGUsIGNoaWxkTm9kZXNbaW5kZXhdKTtcbiAgICB9IGVsc2Uge1xuICAgICAgc3R5bGUuYXBwZW5kQ2hpbGQoY3NzTm9kZSk7XG4gICAgfVxuICB9XG59XG5cbmZ1bmN0aW9uIGFwcGx5VG9UYWcoc3R5bGUsIG9wdGlvbnMsIG9iaikge1xuICB2YXIgY3NzID0gb2JqLmNzcztcbiAgdmFyIG1lZGlhID0gb2JqLm1lZGlhO1xuICB2YXIgc291cmNlTWFwID0gb2JqLnNvdXJjZU1hcDtcblxuICBpZiAobWVkaWEpIHtcbiAgICBzdHlsZS5zZXRBdHRyaWJ1dGUoJ21lZGlhJywgbWVkaWEpO1xuICB9IGVsc2Uge1xuICAgIHN0eWxlLnJlbW92ZUF0dHJpYnV0ZSgnbWVkaWEnKTtcbiAgfVxuXG4gIGlmIChzb3VyY2VNYXAgJiYgdHlwZW9mIGJ0b2EgIT09ICd1bmRlZmluZWQnKSB7XG4gICAgY3NzICs9IFwiXFxuLyojIHNvdXJjZU1hcHBpbmdVUkw9ZGF0YTphcHBsaWNhdGlvbi9qc29uO2Jhc2U2NCxcIi5jb25jYXQoYnRvYSh1bmVzY2FwZShlbmNvZGVVUklDb21wb25lbnQoSlNPTi5zdHJpbmdpZnkoc291cmNlTWFwKSkpKSwgXCIgKi9cIik7XG4gIH0gLy8gRm9yIG9sZCBJRVxuXG4gIC8qIGlzdGFuYnVsIGlnbm9yZSBpZiAgKi9cblxuXG4gIGlmIChzdHlsZS5zdHlsZVNoZWV0KSB7XG4gICAgc3R5bGUuc3R5bGVTaGVldC5jc3NUZXh0ID0gY3NzO1xuICB9IGVsc2Uge1xuICAgIHdoaWxlIChzdHlsZS5maXJzdENoaWxkKSB7XG4gICAgICBzdHlsZS5yZW1vdmVDaGlsZChzdHlsZS5maXJzdENoaWxkKTtcbiAgICB9XG5cbiAgICBzdHlsZS5hcHBlbmRDaGlsZChkb2N1bWVudC5jcmVhdGVUZXh0Tm9kZShjc3MpKTtcbiAgfVxufVxuXG52YXIgc2luZ2xldG9uID0gbnVsbDtcbnZhciBzaW5nbGV0b25Db3VudGVyID0gMDtcblxuZnVuY3Rpb24gYWRkU3R5bGUob2JqLCBvcHRpb25zKSB7XG4gIHZhciBzdHlsZTtcbiAgdmFyIHVwZGF0ZTtcbiAgdmFyIHJlbW92ZTtcblxuICBpZiAob3B0aW9ucy5zaW5nbGV0b24pIHtcbiAgICB2YXIgc3R5bGVJbmRleCA9IHNpbmdsZXRvbkNvdW50ZXIrKztcbiAgICBzdHlsZSA9IHNpbmdsZXRvbiB8fCAoc2luZ2xldG9uID0gaW5zZXJ0U3R5bGVFbGVtZW50KG9wdGlvbnMpKTtcbiAgICB1cGRhdGUgPSBhcHBseVRvU2luZ2xldG9uVGFnLmJpbmQobnVsbCwgc3R5bGUsIHN0eWxlSW5kZXgsIGZhbHNlKTtcbiAgICByZW1vdmUgPSBhcHBseVRvU2luZ2xldG9uVGFnLmJpbmQobnVsbCwgc3R5bGUsIHN0eWxlSW5kZXgsIHRydWUpO1xuICB9IGVsc2Uge1xuICAgIHN0eWxlID0gaW5zZXJ0U3R5bGVFbGVtZW50KG9wdGlvbnMpO1xuICAgIHVwZGF0ZSA9IGFwcGx5VG9UYWcuYmluZChudWxsLCBzdHlsZSwgb3B0aW9ucyk7XG5cbiAgICByZW1vdmUgPSBmdW5jdGlvbiByZW1vdmUoKSB7XG4gICAgICByZW1vdmVTdHlsZUVsZW1lbnQoc3R5bGUpO1xuICAgIH07XG4gIH1cblxuICB1cGRhdGUob2JqKTtcbiAgcmV0dXJuIGZ1bmN0aW9uIHVwZGF0ZVN0eWxlKG5ld09iaikge1xuICAgIGlmIChuZXdPYmopIHtcbiAgICAgIGlmIChuZXdPYmouY3NzID09PSBvYmouY3NzICYmIG5ld09iai5tZWRpYSA9PT0gb2JqLm1lZGlhICYmIG5ld09iai5zb3VyY2VNYXAgPT09IG9iai5zb3VyY2VNYXApIHtcbiAgICAgICAgcmV0dXJuO1xuICAgICAgfVxuXG4gICAgICB1cGRhdGUob2JqID0gbmV3T2JqKTtcbiAgICB9IGVsc2Uge1xuICAgICAgcmVtb3ZlKCk7XG4gICAgfVxuICB9O1xufVxuXG5tb2R1bGUuZXhwb3J0cyA9IGZ1bmN0aW9uIChsaXN0LCBvcHRpb25zKSB7XG4gIG9wdGlvbnMgPSBvcHRpb25zIHx8IHt9OyAvLyBGb3JjZSBzaW5nbGUtdGFnIHNvbHV0aW9uIG9uIElFNi05LCB3aGljaCBoYXMgYSBoYXJkIGxpbWl0IG9uIHRoZSAjIG9mIDxzdHlsZT5cbiAgLy8gdGFncyBpdCB3aWxsIGFsbG93IG9uIGEgcGFnZVxuXG4gIGlmICghb3B0aW9ucy5zaW5nbGV0b24gJiYgdHlwZW9mIG9wdGlvbnMuc2luZ2xldG9uICE9PSAnYm9vbGVhbicpIHtcbiAgICBvcHRpb25zLnNpbmdsZXRvbiA9IGlzT2xkSUUoKTtcbiAgfVxuXG4gIGxpc3QgPSBsaXN0IHx8IFtdO1xuICB2YXIgbGFzdElkZW50aWZpZXJzID0gbW9kdWxlc1RvRG9tKGxpc3QsIG9wdGlvbnMpO1xuICByZXR1cm4gZnVuY3Rpb24gdXBkYXRlKG5ld0xpc3QpIHtcbiAgICBuZXdMaXN0ID0gbmV3TGlzdCB8fCBbXTtcblxuICAgIGlmIChPYmplY3QucHJvdG90eXBlLnRvU3RyaW5nLmNhbGwobmV3TGlzdCkgIT09ICdbb2JqZWN0IEFycmF5XScpIHtcbiAgICAgIHJldHVybjtcbiAgICB9XG5cbiAgICBmb3IgKHZhciBpID0gMDsgaSA8IGxhc3RJZGVudGlmaWVycy5sZW5ndGg7IGkrKykge1xuICAgICAgdmFyIGlkZW50aWZpZXIgPSBsYXN0SWRlbnRpZmllcnNbaV07XG4gICAgICB2YXIgaW5kZXggPSBnZXRJbmRleEJ5SWRlbnRpZmllcihpZGVudGlmaWVyKTtcbiAgICAgIHN0eWxlc0luRG9tW2luZGV4XS5yZWZlcmVuY2VzLS07XG4gICAgfVxuXG4gICAgdmFyIG5ld0xhc3RJZGVudGlmaWVycyA9IG1vZHVsZXNUb0RvbShuZXdMaXN0LCBvcHRpb25zKTtcblxuICAgIGZvciAodmFyIF9pID0gMDsgX2kgPCBsYXN0SWRlbnRpZmllcnMubGVuZ3RoOyBfaSsrKSB7XG4gICAgICB2YXIgX2lkZW50aWZpZXIgPSBsYXN0SWRlbnRpZmllcnNbX2ldO1xuXG4gICAgICB2YXIgX2luZGV4ID0gZ2V0SW5kZXhCeUlkZW50aWZpZXIoX2lkZW50aWZpZXIpO1xuXG4gICAgICBpZiAoc3R5bGVzSW5Eb21bX2luZGV4XS5yZWZlcmVuY2VzID09PSAwKSB7XG4gICAgICAgIHN0eWxlc0luRG9tW19pbmRleF0udXBkYXRlcigpO1xuXG4gICAgICAgIHN0eWxlc0luRG9tLnNwbGljZShfaW5kZXgsIDEpO1xuICAgICAgfVxuICAgIH1cblxuICAgIGxhc3RJZGVudGlmaWVycyA9IG5ld0xhc3RJZGVudGlmaWVycztcbiAgfTtcbn07IiwiXCJ1c2Ugc3RyaWN0XCI7XG5cbmZ1bmN0aW9uIF9zbGljZWRUb0FycmF5KGFyciwgaSkgeyByZXR1cm4gX2FycmF5V2l0aEhvbGVzKGFycikgfHwgX2l0ZXJhYmxlVG9BcnJheUxpbWl0KGFyciwgaSkgfHwgX3Vuc3VwcG9ydGVkSXRlcmFibGVUb0FycmF5KGFyciwgaSkgfHwgX25vbkl0ZXJhYmxlUmVzdCgpOyB9XG5cbmZ1bmN0aW9uIF9ub25JdGVyYWJsZVJlc3QoKSB7IHRocm93IG5ldyBUeXBlRXJyb3IoXCJJbnZhbGlkIGF0dGVtcHQgdG8gZGVzdHJ1Y3R1cmUgbm9uLWl0ZXJhYmxlIGluc3RhbmNlLlxcbkluIG9yZGVyIHRvIGJlIGl0ZXJhYmxlLCBub24tYXJyYXkgb2JqZWN0cyBtdXN0IGhhdmUgYSBbU3ltYm9sLml0ZXJhdG9yXSgpIG1ldGhvZC5cIik7IH1cblxuZnVuY3Rpb24gX3Vuc3VwcG9ydGVkSXRlcmFibGVUb0FycmF5KG8sIG1pbkxlbikgeyBpZiAoIW8pIHJldHVybjsgaWYgKHR5cGVvZiBvID09PSBcInN0cmluZ1wiKSByZXR1cm4gX2FycmF5TGlrZVRvQXJyYXkobywgbWluTGVuKTsgdmFyIG4gPSBPYmplY3QucHJvdG90eXBlLnRvU3RyaW5nLmNhbGwobykuc2xpY2UoOCwgLTEpOyBpZiAobiA9PT0gXCJPYmplY3RcIiAmJiBvLmNvbnN0cnVjdG9yKSBuID0gby5jb25zdHJ1Y3Rvci5uYW1lOyBpZiAobiA9PT0gXCJNYXBcIiB8fCBuID09PSBcIlNldFwiKSByZXR1cm4gQXJyYXkuZnJvbShvKTsgaWYgKG4gPT09IFwiQXJndW1lbnRzXCIgfHwgL14oPzpVaXxJKW50KD86OHwxNnwzMikoPzpDbGFtcGVkKT9BcnJheSQvLnRlc3QobikpIHJldHVybiBfYXJyYXlMaWtlVG9BcnJheShvLCBtaW5MZW4pOyB9XG5cbmZ1bmN0aW9uIF9hcnJheUxpa2VUb0FycmF5KGFyciwgbGVuKSB7IGlmIChsZW4gPT0gbnVsbCB8fCBsZW4gPiBhcnIubGVuZ3RoKSBsZW4gPSBhcnIubGVuZ3RoOyBmb3IgKHZhciBpID0gMCwgYXJyMiA9IG5ldyBBcnJheShsZW4pOyBpIDwgbGVuOyBpKyspIHsgYXJyMltpXSA9IGFycltpXTsgfSByZXR1cm4gYXJyMjsgfVxuXG5mdW5jdGlvbiBfaXRlcmFibGVUb0FycmF5TGltaXQoYXJyLCBpKSB7IHZhciBfaSA9IGFyciAmJiAodHlwZW9mIFN5bWJvbCAhPT0gXCJ1bmRlZmluZWRcIiAmJiBhcnJbU3ltYm9sLml0ZXJhdG9yXSB8fCBhcnJbXCJAQGl0ZXJhdG9yXCJdKTsgaWYgKF9pID09IG51bGwpIHJldHVybjsgdmFyIF9hcnIgPSBbXTsgdmFyIF9uID0gdHJ1ZTsgdmFyIF9kID0gZmFsc2U7IHZhciBfcywgX2U7IHRyeSB7IGZvciAoX2kgPSBfaS5jYWxsKGFycik7ICEoX24gPSAoX3MgPSBfaS5uZXh0KCkpLmRvbmUpOyBfbiA9IHRydWUpIHsgX2Fyci5wdXNoKF9zLnZhbHVlKTsgaWYgKGkgJiYgX2Fyci5sZW5ndGggPT09IGkpIGJyZWFrOyB9IH0gY2F0Y2ggKGVycikgeyBfZCA9IHRydWU7IF9lID0gZXJyOyB9IGZpbmFsbHkgeyB0cnkgeyBpZiAoIV9uICYmIF9pW1wicmV0dXJuXCJdICE9IG51bGwpIF9pW1wicmV0dXJuXCJdKCk7IH0gZmluYWxseSB7IGlmIChfZCkgdGhyb3cgX2U7IH0gfSByZXR1cm4gX2FycjsgfVxuXG5mdW5jdGlvbiBfYXJyYXlXaXRoSG9sZXMoYXJyKSB7IGlmIChBcnJheS5pc0FycmF5KGFycikpIHJldHVybiBhcnI7IH1cblxubW9kdWxlLmV4cG9ydHMgPSBmdW5jdGlvbiBjc3NXaXRoTWFwcGluZ1RvU3RyaW5nKGl0ZW0pIHtcbiAgdmFyIF9pdGVtID0gX3NsaWNlZFRvQXJyYXkoaXRlbSwgNCksXG4gICAgICBjb250ZW50ID0gX2l0ZW1bMV0sXG4gICAgICBjc3NNYXBwaW5nID0gX2l0ZW1bM107XG5cbiAgaWYgKHR5cGVvZiBidG9hID09PSBcImZ1bmN0aW9uXCIpIHtcbiAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tdW5kZWZcbiAgICB2YXIgYmFzZTY0ID0gYnRvYSh1bmVzY2FwZShlbmNvZGVVUklDb21wb25lbnQoSlNPTi5zdHJpbmdpZnkoY3NzTWFwcGluZykpKSk7XG4gICAgdmFyIGRhdGEgPSBcInNvdXJjZU1hcHBpbmdVUkw9ZGF0YTphcHBsaWNhdGlvbi9qc29uO2NoYXJzZXQ9dXRmLTg7YmFzZTY0LFwiLmNvbmNhdChiYXNlNjQpO1xuICAgIHZhciBzb3VyY2VNYXBwaW5nID0gXCIvKiMgXCIuY29uY2F0KGRhdGEsIFwiICovXCIpO1xuICAgIHZhciBzb3VyY2VVUkxzID0gY3NzTWFwcGluZy5zb3VyY2VzLm1hcChmdW5jdGlvbiAoc291cmNlKSB7XG4gICAgICByZXR1cm4gXCIvKiMgc291cmNlVVJMPVwiLmNvbmNhdChjc3NNYXBwaW5nLnNvdXJjZVJvb3QgfHwgXCJcIikuY29uY2F0KHNvdXJjZSwgXCIgKi9cIik7XG4gICAgfSk7XG4gICAgcmV0dXJuIFtjb250ZW50XS5jb25jYXQoc291cmNlVVJMcykuY29uY2F0KFtzb3VyY2VNYXBwaW5nXSkuam9pbihcIlxcblwiKTtcbiAgfVxuXG4gIHJldHVybiBbY29udGVudF0uam9pbihcIlxcblwiKTtcbn07IiwiXCJ1c2Ugc3RyaWN0XCI7XG5cbi8qXG4gIE1JVCBMaWNlbnNlIGh0dHA6Ly93d3cub3BlbnNvdXJjZS5vcmcvbGljZW5zZXMvbWl0LWxpY2Vuc2UucGhwXG4gIEF1dGhvciBUb2JpYXMgS29wcGVycyBAc29rcmFcbiovXG4vLyBjc3MgYmFzZSBjb2RlLCBpbmplY3RlZCBieSB0aGUgY3NzLWxvYWRlclxuLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIGZ1bmMtbmFtZXNcbm1vZHVsZS5leHBvcnRzID0gZnVuY3Rpb24gKGNzc1dpdGhNYXBwaW5nVG9TdHJpbmcpIHtcbiAgdmFyIGxpc3QgPSBbXTsgLy8gcmV0dXJuIHRoZSBsaXN0IG9mIG1vZHVsZXMgYXMgY3NzIHN0cmluZ1xuXG4gIGxpc3QudG9TdHJpbmcgPSBmdW5jdGlvbiB0b1N0cmluZygpIHtcbiAgICByZXR1cm4gdGhpcy5tYXAoZnVuY3Rpb24gKGl0ZW0pIHtcbiAgICAgIHZhciBjb250ZW50ID0gY3NzV2l0aE1hcHBpbmdUb1N0cmluZyhpdGVtKTtcblxuICAgICAgaWYgKGl0ZW1bMl0pIHtcbiAgICAgICAgcmV0dXJuIFwiQG1lZGlhIFwiLmNvbmNhdChpdGVtWzJdLCBcIiB7XCIpLmNvbmNhdChjb250ZW50LCBcIn1cIik7XG4gICAgICB9XG5cbiAgICAgIHJldHVybiBjb250ZW50O1xuICAgIH0pLmpvaW4oXCJcIik7XG4gIH07IC8vIGltcG9ydCBhIGxpc3Qgb2YgbW9kdWxlcyBpbnRvIHRoZSBsaXN0XG4gIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBmdW5jLW5hbWVzXG5cblxuICBsaXN0LmkgPSBmdW5jdGlvbiAobW9kdWxlcywgbWVkaWFRdWVyeSwgZGVkdXBlKSB7XG4gICAgaWYgKHR5cGVvZiBtb2R1bGVzID09PSBcInN0cmluZ1wiKSB7XG4gICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tcGFyYW0tcmVhc3NpZ25cbiAgICAgIG1vZHVsZXMgPSBbW251bGwsIG1vZHVsZXMsIFwiXCJdXTtcbiAgICB9XG5cbiAgICB2YXIgYWxyZWFkeUltcG9ydGVkTW9kdWxlcyA9IHt9O1xuXG4gICAgaWYgKGRlZHVwZSkge1xuICAgICAgZm9yICh2YXIgaSA9IDA7IGkgPCB0aGlzLmxlbmd0aDsgaSsrKSB7XG4gICAgICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBwcmVmZXItZGVzdHJ1Y3R1cmluZ1xuICAgICAgICB2YXIgaWQgPSB0aGlzW2ldWzBdO1xuXG4gICAgICAgIGlmIChpZCAhPSBudWxsKSB7XG4gICAgICAgICAgYWxyZWFkeUltcG9ydGVkTW9kdWxlc1tpZF0gPSB0cnVlO1xuICAgICAgICB9XG4gICAgICB9XG4gICAgfVxuXG4gICAgZm9yICh2YXIgX2kgPSAwOyBfaSA8IG1vZHVsZXMubGVuZ3RoOyBfaSsrKSB7XG4gICAgICB2YXIgaXRlbSA9IFtdLmNvbmNhdChtb2R1bGVzW19pXSk7XG5cbiAgICAgIGlmIChkZWR1cGUgJiYgYWxyZWFkeUltcG9ydGVkTW9kdWxlc1tpdGVtWzBdXSkge1xuICAgICAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgbm8tY29udGludWVcbiAgICAgICAgY29udGludWU7XG4gICAgICB9XG5cbiAgICAgIGlmIChtZWRpYVF1ZXJ5KSB7XG4gICAgICAgIGlmICghaXRlbVsyXSkge1xuICAgICAgICAgIGl0ZW1bMl0gPSBtZWRpYVF1ZXJ5O1xuICAgICAgICB9IGVsc2Uge1xuICAgICAgICAgIGl0ZW1bMl0gPSBcIlwiLmNvbmNhdChtZWRpYVF1ZXJ5LCBcIiBhbmQgXCIpLmNvbmNhdChpdGVtWzJdKTtcbiAgICAgICAgfVxuICAgICAgfVxuXG4gICAgICBsaXN0LnB1c2goaXRlbSk7XG4gICAgfVxuICB9O1xuXG4gIHJldHVybiBsaXN0O1xufTsiLCJpbXBvcnQgKiBhcyBtZXNzYWdlcyBmcm9tIFwiLi4vc2hhcmVkL21lc3NhZ2VzXCI7XG5pbXBvcnQgQ29uc29sZSBmcm9tIFwiLi9jb21wb25lbnRzL0NvbnNvbGVcIjtcbmltcG9ydCBcIi4vaW5kZXguY3NzXCI7XG5pbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgUmVhY3RET00gZnJvbSBcInJlYWN0LWRvbVwiO1xuaW1wb3J0IENvbG9yU2NoZW1lUHJvdmlkZXIgZnJvbSBcIi4vY29sb3JzY2hlbWUvcHJvdmlkZXJzXCI7XG5pbXBvcnQgeyBBcHBQcm92aWRlciB9IGZyb20gXCIuL2FwcC9wcm92aWRlclwiO1xuaW1wb3J0IHtcbiAgdXNlQ29tbWFuZE1vZGUsXG4gIHVzZUZpbmRNb2RlLFxuICB1c2VJbmZvTWVzc2FnZSxcbiAgdXNlRXJyb3JNZXNzYWdlLFxuICB1c2VIaWRlLFxufSBmcm9tIFwiLi9hcHAvaG9va3NcIjtcblxuY29uc3QgUm9vdENvbXBvbmVudDogUmVhY3QuRkMgPSAoKSA9PiB7XG4gIGNvbnN0IGhpZGUgPSB1c2VIaWRlKCk7XG4gIGNvbnN0IHsgc2hvdzogc2hvd0NvbW1hbmQgfSA9IHVzZUNvbW1hbmRNb2RlKCk7XG4gIGNvbnN0IHsgc2hvdzogc2hvd0ZpbmQgfSA9IHVzZUZpbmRNb2RlKCk7XG4gIGNvbnN0IHsgc2hvdzogc2hvd0Vycm9yIH0gPSB1c2VFcnJvck1lc3NhZ2UoKTtcbiAgY29uc3QgeyBzaG93OiBzaG93SW5mbyB9ID0gdXNlSW5mb01lc3NhZ2UoKTtcblxuICBSZWFjdC51c2VFZmZlY3QoKCkgPT4ge1xuICAgIGNvbnN0IG9uTWVzc2FnZSA9IGFzeW5jIChtZXNzYWdlOiBhbnkpOiBQcm9taXNlPGFueT4gPT4ge1xuICAgICAgY29uc3QgbXNnID0gbWVzc2FnZXMudmFsdWVPZihtZXNzYWdlKTtcbiAgICAgIHN3aXRjaCAobXNnLnR5cGUpIHtcbiAgICAgICAgY2FzZSBtZXNzYWdlcy5DT05TT0xFX1NIT1dfQ09NTUFORDpcbiAgICAgICAgICBzaG93Q29tbWFuZChtc2cuY29tbWFuZCk7XG4gICAgICAgICAgYnJlYWs7XG4gICAgICAgIGNhc2UgbWVzc2FnZXMuQ09OU09MRV9TSE9XX0ZJTkQ6XG4gICAgICAgICAgc2hvd0ZpbmQoKTtcbiAgICAgICAgICBicmVhaztcbiAgICAgICAgY2FzZSBtZXNzYWdlcy5DT05TT0xFX1NIT1dfRVJST1I6XG4gICAgICAgICAgc2hvd0Vycm9yKG1zZy50ZXh0KTtcbiAgICAgICAgICBicmVhaztcbiAgICAgICAgY2FzZSBtZXNzYWdlcy5DT05TT0xFX1NIT1dfSU5GTzpcbiAgICAgICAgICBzaG93SW5mbyhtc2cudGV4dCk7XG4gICAgICAgICAgYnJlYWs7XG4gICAgICAgIGNhc2UgbWVzc2FnZXMuQ09OU09MRV9ISURFOlxuICAgICAgICAgIGhpZGUoKTtcbiAgICAgICAgICBicmVhaztcbiAgICAgIH1cbiAgICB9O1xuXG4gICAgYnJvd3Nlci5ydW50aW1lLm9uTWVzc2FnZS5hZGRMaXN0ZW5lcihvbk1lc3NhZ2UpO1xuICAgIGNvbnN0IHBvcnQgPSBicm93c2VyLnJ1bnRpbWUuY29ubmVjdCh1bmRlZmluZWQsIHtcbiAgICAgIG5hbWU6IFwidmltdml4ZW4tY29uc29sZVwiLFxuICAgIH0pO1xuICAgIHBvcnQub25NZXNzYWdlLmFkZExpc3RlbmVyKG9uTWVzc2FnZSk7XG4gIH0sIFtdKTtcblxuICByZXR1cm4gPENvbnNvbGUgLz47XG59O1xuXG5jb25zdCBBcHA6IFJlYWN0LkZDID0gKCkgPT4gKFxuICA8QXBwUHJvdmlkZXI+XG4gICAgPENvbG9yU2NoZW1lUHJvdmlkZXI+XG4gICAgICA8Um9vdENvbXBvbmVudCAvPlxuICAgIDwvQ29sb3JTY2hlbWVQcm92aWRlcj5cbiAgPC9BcHBQcm92aWRlcj5cbik7XG5cbndpbmRvdy5hZGRFdmVudExpc3RlbmVyKFwiRE9NQ29udGVudExvYWRlZFwiLCAoKSA9PiB7XG4gIGNvbnN0IHdyYXBwZXIgPSBkb2N1bWVudC5nZXRFbGVtZW50QnlJZChcInZpbXZpeGVuLWNvbnNvbGVcIik7XG4gIFJlYWN0RE9NLnJlbmRlcig8QXBwIC8+LCB3cmFwcGVyKTtcbn0pO1xuIiwiaW1wb3J0IFJlYWN0IGZyb20gXCJyZWFjdFwiO1xuaW1wb3J0IEZpbmRQcm9tcHQgZnJvbSBcIi4vRmluZFByb21wdFwiO1xuaW1wb3J0IENvbW1hbmRQcm9tcHQgZnJvbSBcIi4vQ29tbWFuZFByb21wdFwiO1xuaW1wb3J0IEluZm9NZXNzYWdlIGZyb20gXCIuL0luZm9NZXNzYWdlXCI7XG5pbXBvcnQgRXJyb3JNZXNzYWdlIGZyb20gXCIuL0Vycm9yTWVzc2FnZVwiO1xuaW1wb3J0IHsgdXNlQ29sb3JTY2hlbWVSZWZyZXNoIH0gZnJvbSBcIi4uL2NvbG9yc2NoZW1lL2hvb2tzXCI7XG5pbXBvcnQge1xuICB1c2VDb21tYW5kTW9kZSxcbiAgdXNlRXJyb3JNZXNzYWdlLFxuICB1c2VGaW5kTW9kZSxcbiAgdXNlSW5mb01lc3NhZ2UsXG59IGZyb20gXCIuLi9hcHAvaG9va3NcIjtcblxuY29uc3QgQ29uc29sZTogUmVhY3QuRkMgPSAoKSA9PiB7XG4gIGNvbnN0IHJlZnJlc2hDb2xvclNjaGVtZSA9IHVzZUNvbG9yU2NoZW1lUmVmcmVzaCgpO1xuICBjb25zdCB7IHZpc2libGU6IHZpc2libGVDb21tYW5kLCBpbml0aWFsSW5wdXRWYWx1ZSB9ID0gdXNlQ29tbWFuZE1vZGUoKTtcbiAgY29uc3QgeyB2aXNpYmxlOiB2aXNpYmxlRmluZCB9ID0gdXNlRmluZE1vZGUoKTtcbiAgY29uc3QgeyB2aXNpYmxlOiB2aXNpYmxlSW5mbywgbWVzc2FnZTogaW5mb01lc3NhZ2UgfSA9IHVzZUluZm9NZXNzYWdlKCk7XG4gIGNvbnN0IHsgdmlzaWJsZTogdmlzaWJsZUVycm9yLCBtZXNzYWdlOiBlcnJvck1lc3NhZ2UgfSA9IHVzZUVycm9yTWVzc2FnZSgpO1xuXG4gIFJlYWN0LnVzZUVmZmVjdCgoKSA9PiB7XG4gICAgaWYgKHZpc2libGVDb21tYW5kIHx8IHZpc2libGVGaW5kIHx8IHZpc2libGVJbmZvIHx8IHZpc2libGVFcnJvcikge1xuICAgICAgcmVmcmVzaENvbG9yU2NoZW1lKCk7XG4gICAgfVxuICB9LCBbdmlzaWJsZUNvbW1hbmQsIHZpc2libGVGaW5kLCB2aXNpYmxlSW5mbywgdmlzaWJsZUVycm9yXSk7XG5cbiAgaWYgKHZpc2libGVDb21tYW5kKSB7XG4gICAgcmV0dXJuIDxDb21tYW5kUHJvbXB0IGluaXRpYWxJbnB1dFZhbHVlPXtpbml0aWFsSW5wdXRWYWx1ZX0gLz47XG4gIH0gZWxzZSBpZiAodmlzaWJsZUZpbmQpIHtcbiAgICByZXR1cm4gPEZpbmRQcm9tcHQgLz47XG4gIH0gZWxzZSBpZiAodmlzaWJsZUluZm8pIHtcbiAgICByZXR1cm4gPEluZm9NZXNzYWdlPntpbmZvTWVzc2FnZX08L0luZm9NZXNzYWdlPjtcbiAgfSBlbHNlIGlmICh2aXNpYmxlRXJyb3IpIHtcbiAgICByZXR1cm4gPEVycm9yTWVzc2FnZT57ZXJyb3JNZXNzYWdlfTwvRXJyb3JNZXNzYWdlPjtcbiAgfVxuICByZXR1cm4gbnVsbDtcbn07XG5cbmV4cG9ydCBkZWZhdWx0IENvbnNvbGU7XG4iLCJpbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgSW5wdXQgZnJvbSBcIi4vY29uc29sZS9JbnB1dFwiO1xuaW1wb3J0IHN0eWxlZCBmcm9tIFwic3R5bGVkLWNvbXBvbmVudHNcIjtcbmltcG9ydCB1c2VBdXRvUmVzaXplIGZyb20gXCIuLi9ob29rcy91c2VBdXRvUmVzaXplXCI7XG5pbXBvcnQgeyB1c2VFeGVjRmluZCwgdXNlSGlkZSB9IGZyb20gXCIuLi9hcHAvaG9va3NcIjtcblxuY29uc3QgQ29uc29sZVdyYXBwZXIgPSBzdHlsZWQuZGl2YFxuICBib3JkZXItdG9wOiAxcHggc29saWQgZ3JheTtcbmA7XG5cbmNvbnN0IEZpbmRQcm9tcHQ6IFJlYWN0LkZDID0gKCkgPT4ge1xuICBjb25zdCBbaW5wdXRWYWx1ZSwgc2V0SW5wdXRWYWx1ZV0gPSBSZWFjdC51c2VTdGF0ZShcIlwiKTtcbiAgY29uc3QgaGlkZSA9IHVzZUhpZGUoKTtcbiAgY29uc3QgZXhlY0ZpbmQgPSB1c2VFeGVjRmluZCgpO1xuXG4gIGNvbnN0IG9uQmx1ciA9ICgpID0+IHtcbiAgICBoaWRlKCk7XG4gIH07XG5cbiAgdXNlQXV0b1Jlc2l6ZSgpO1xuXG4gIGNvbnN0IGRvRW50ZXIgPSAoZTogUmVhY3QuS2V5Ym9hcmRFdmVudDxIVE1MSW5wdXRFbGVtZW50PikgPT4ge1xuICAgIGUuc3RvcFByb3BhZ2F0aW9uKCk7XG4gICAgZS5wcmV2ZW50RGVmYXVsdCgpO1xuXG4gICAgY29uc3QgdmFsdWUgPSAoZS50YXJnZXQgYXMgSFRNTElucHV0RWxlbWVudCkudmFsdWU7XG4gICAgZXhlY0ZpbmQodmFsdWUgPT09IFwiXCIgPyB1bmRlZmluZWQgOiB2YWx1ZSk7XG4gICAgaGlkZSgpO1xuICB9O1xuXG4gIGNvbnN0IG9uS2V5RG93biA9IChlOiBSZWFjdC5LZXlib2FyZEV2ZW50PEhUTUxJbnB1dEVsZW1lbnQ+KSA9PiB7XG4gICAgc3dpdGNoIChlLmtleSkge1xuICAgICAgY2FzZSBcIkVzY2FwZVwiOlxuICAgICAgICBoaWRlKCk7XG4gICAgICAgIGJyZWFrO1xuICAgICAgY2FzZSBcIkVudGVyXCI6XG4gICAgICAgIGRvRW50ZXIoZSk7XG4gICAgICAgIGJyZWFrO1xuICAgIH1cbiAgfTtcblxuICBjb25zdCBvbkNoYW5nZSA9IChlOiBSZWFjdC5DaGFuZ2VFdmVudDxIVE1MSW5wdXRFbGVtZW50PikgPT4ge1xuICAgIHNldElucHV0VmFsdWUoZS50YXJnZXQudmFsdWUpO1xuICB9O1xuXG4gIHJldHVybiAoXG4gICAgPENvbnNvbGVXcmFwcGVyPlxuICAgICAgPElucHV0XG4gICAgICAgIHByb21wdD17XCIvXCJ9XG4gICAgICAgIG9uQmx1cj17b25CbHVyfVxuICAgICAgICBvbktleURvd249e29uS2V5RG93bn1cbiAgICAgICAgb25DaGFuZ2U9e29uQ2hhbmdlfVxuICAgICAgICB2YWx1ZT17aW5wdXRWYWx1ZX1cbiAgICAgIC8+XG4gICAgPC9Db25zb2xlV3JhcHBlcj5cbiAgKTtcbn07XG5cbmV4cG9ydCBkZWZhdWx0IEZpbmRQcm9tcHQ7XG4iLCJpbXBvcnQgKiBhcyBtZXNzYWdlcyBmcm9tIFwiLi4vLi4vc2hhcmVkL21lc3NhZ2VzXCI7XG5cbmV4cG9ydCBkZWZhdWx0IGNsYXNzIENvbnNvbGVGcmFtZUNsaWVudCB7XG4gIGFzeW5jIHJlc2l6ZSh3aWR0aDogbnVtYmVyLCBoZWlnaHQ6IG51bWJlcik6IFByb21pc2U8dm9pZD4ge1xuICAgIGF3YWl0IGJyb3dzZXIucnVudGltZS5zZW5kTWVzc2FnZSh7XG4gICAgICB0eXBlOiBtZXNzYWdlcy5DT05TT0xFX1JFU0laRSxcbiAgICAgIHdpZHRoLFxuICAgICAgaGVpZ2h0LFxuICAgIH0pO1xuICB9XG59XG4iLCJpbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgQ29tcGxldGlvbiBmcm9tIFwiLi9jb25zb2xlL0NvbXBsZXRpb25cIjtcbmltcG9ydCBJbnB1dCBmcm9tIFwiLi9jb25zb2xlLy9JbnB1dFwiO1xuaW1wb3J0IHN0eWxlZCBmcm9tIFwic3R5bGVkLWNvbXBvbmVudHNcIjtcbmltcG9ydCB7IHVzZUNvbXBsZXRpb25zLCB1c2VTZWxlY3RDb21wbGV0aW9uIH0gZnJvbSBcIi4uL2NvbXBsZXRpb24vaG9va3NcIjtcbmltcG9ydCB1c2VBdXRvUmVzaXplIGZyb20gXCIuLi9ob29rcy91c2VBdXRvUmVzaXplXCI7XG5pbXBvcnQgeyBDb21wbGV0aW9uUHJvdmlkZXIgfSBmcm9tIFwiLi4vY29tcGxldGlvbi9wcm92aWRlclwiO1xuaW1wb3J0IHsgdXNlRXhlY0NvbW1hbmQsIHVzZUhpZGUgfSBmcm9tIFwiLi4vYXBwL2hvb2tzXCI7XG5cbmNvbnN0IENPTVBMRVRJT05fTUFYX0lURU1TID0gMzM7XG5cbmNvbnN0IENvbnNvbGVXcmFwcGVyID0gc3R5bGVkLmRpdmBcbiAgYm9yZGVyLXRvcDogMXB4IHNvbGlkIGdyYXk7XG5gO1xuXG5pbnRlcmZhY2UgUHJvcHMge1xuICBpbml0aWFsSW5wdXRWYWx1ZTogc3RyaW5nO1xufVxuXG5jb25zdCBDb21tYW5kUHJvbXB0SW5uZXI6IFJlYWN0LkZDPFByb3BzPiA9ICh7IGluaXRpYWxJbnB1dFZhbHVlIH0pID0+IHtcbiAgY29uc3QgaGlkZSA9IHVzZUhpZGUoKTtcbiAgY29uc3QgW2lucHV0VmFsdWUsIHNldElucHV0VmFsdWVdID0gUmVhY3QudXNlU3RhdGUoaW5pdGlhbElucHV0VmFsdWUpO1xuICBjb25zdCB7IGNvbXBsZXRpb25zLCB1cGRhdGVDb21wbGV0aW9ucyB9ID0gdXNlQ29tcGxldGlvbnMoKTtcbiAgY29uc3QgeyBzZWxlY3QsIGN1cnJlbnRWYWx1ZSwgc2VsZWN0TmV4dCwgc2VsZWN0UHJldiB9ID1cbiAgICB1c2VTZWxlY3RDb21wbGV0aW9uKCk7XG4gIGNvbnN0IGV4ZWNDb21tYW5kID0gdXNlRXhlY0NvbW1hbmQoKTtcblxuICB1c2VBdXRvUmVzaXplKCk7XG5cbiAgY29uc3Qgb25CbHVyID0gKCkgPT4ge1xuICAgIGhpZGUoKTtcbiAgfTtcblxuICBjb25zdCBpc0NhbmNlbEtleSA9IFJlYWN0LnVzZUNhbGxiYWNrKFxuICAgIChlOiBSZWFjdC5LZXlib2FyZEV2ZW50PEhUTUxJbnB1dEVsZW1lbnQ+KSA9PlxuICAgICAgZS5rZXkgPT09IFwiRXNjYXBlXCIgfHxcbiAgICAgIChlLmN0cmxLZXkgJiYgZS5rZXkgPT09IFwiW1wiKSB8fFxuICAgICAgKGUuY3RybEtleSAmJiBlLmtleSA9PT0gXCJjXCIpLFxuICAgIFtdXG4gICk7XG5cbiAgY29uc3QgaXNOZXh0S2V5ID0gUmVhY3QudXNlQ2FsbGJhY2soXG4gICAgKGU6IFJlYWN0LktleWJvYXJkRXZlbnQ8SFRNTElucHV0RWxlbWVudD4pID0+XG4gICAgICAoIWUuc2hpZnRLZXkgJiYgZS5rZXkgPT09IFwiVGFiXCIpIHx8IChlLmN0cmxLZXkgJiYgZS5rZXkgPT09IFwiblwiKSxcbiAgICBbXVxuICApO1xuXG4gIGNvbnN0IGlzUHJldktleSA9IFJlYWN0LnVzZUNhbGxiYWNrKFxuICAgIChlOiBSZWFjdC5LZXlib2FyZEV2ZW50PEhUTUxJbnB1dEVsZW1lbnQ+KSA9PlxuICAgICAgKGUuc2hpZnRLZXkgJiYgZS5rZXkgPT09IFwiVGFiXCIpIHx8IChlLmN0cmxLZXkgJiYgZS5rZXkgPT09IFwicFwiKSxcbiAgICBbXVxuICApO1xuXG4gIGNvbnN0IGlzRW50ZXJLZXkgPSBSZWFjdC51c2VDYWxsYmFjayhcbiAgICAoZTogUmVhY3QuS2V5Ym9hcmRFdmVudDxIVE1MSW5wdXRFbGVtZW50PikgPT5cbiAgICAgIGUua2V5ID09PSBcIkVudGVyXCIgfHwgKGUuY3RybEtleSAmJiBlLmtleSA9PT0gXCJtXCIpLFxuICAgIFtdXG4gICk7XG5cbiAgY29uc3Qgb25LZXlEb3duID0gKGU6IFJlYWN0LktleWJvYXJkRXZlbnQ8SFRNTElucHV0RWxlbWVudD4pID0+IHtcbiAgICBpZiAoaXNDYW5jZWxLZXkoZSkpIHtcbiAgICAgIGhpZGUoKTtcbiAgICB9IGVsc2UgaWYgKGlzRW50ZXJLZXkoZSkpIHtcbiAgICAgIGNvbnN0IHZhbHVlID0gKGUudGFyZ2V0IGFzIEhUTUxJbnB1dEVsZW1lbnQpLnZhbHVlO1xuICAgICAgZXhlY0NvbW1hbmQodmFsdWUpO1xuICAgICAgaGlkZSgpO1xuICAgIH0gZWxzZSBpZiAoaXNOZXh0S2V5KGUpKSB7XG4gICAgICBzZWxlY3ROZXh0KCk7XG4gICAgfSBlbHNlIGlmIChpc1ByZXZLZXkoZSkpIHtcbiAgICAgIHNlbGVjdFByZXYoKTtcbiAgICB9IGVsc2Uge1xuICAgICAgcmV0dXJuO1xuICAgIH1cblxuICAgIGUuc3RvcFByb3BhZ2F0aW9uKCk7XG4gICAgZS5wcmV2ZW50RGVmYXVsdCgpO1xuICB9O1xuXG4gIGNvbnN0IG9uQ2hhbmdlID0gKGU6IFJlYWN0LkNoYW5nZUV2ZW50PEhUTUxJbnB1dEVsZW1lbnQ+KSA9PiB7XG4gICAgY29uc3QgdGV4dCA9IGUudGFyZ2V0LnZhbHVlO1xuICAgIHNldElucHV0VmFsdWUodGV4dCk7XG4gIH07XG5cbiAgUmVhY3QudXNlRWZmZWN0KCgpID0+IHtcbiAgICB1cGRhdGVDb21wbGV0aW9ucyhpbnB1dFZhbHVlKTtcbiAgfSwgW2lucHV0VmFsdWVdKTtcblxuICByZXR1cm4gKFxuICAgIDxDb25zb2xlV3JhcHBlcj5cbiAgICAgIDxDb21wbGV0aW9uXG4gICAgICAgIHNpemU9e0NPTVBMRVRJT05fTUFYX0lURU1TfVxuICAgICAgICBjb21wbGV0aW9ucz17Y29tcGxldGlvbnN9XG4gICAgICAgIHNlbGVjdD17c2VsZWN0fVxuICAgICAgLz5cbiAgICAgIDxJbnB1dFxuICAgICAgICBwcm9tcHQ9e1wiOlwifVxuICAgICAgICBvbkJsdXI9e29uQmx1cn1cbiAgICAgICAgb25LZXlEb3duPXtvbktleURvd259XG4gICAgICAgIG9uQ2hhbmdlPXtvbkNoYW5nZX1cbiAgICAgICAgdmFsdWU9e3NlbGVjdCA9PSAtMSA/IGlucHV0VmFsdWUgOiBjdXJyZW50VmFsdWV9XG4gICAgICAvPlxuICAgIDwvQ29uc29sZVdyYXBwZXI+XG4gICk7XG59O1xuXG5jb25zdCBDb21tYW5kUHJvbXB0OiBSZWFjdC5GQzxQcm9wcz4gPSAoeyBpbml0aWFsSW5wdXRWYWx1ZSB9KSA9PiAoXG4gIDxDb21wbGV0aW9uUHJvdmlkZXIgaW5pdGlhbElucHV0VmFsdWU9e2luaXRpYWxJbnB1dFZhbHVlfT5cbiAgICA8Q29tbWFuZFByb21wdElubmVyIGluaXRpYWxJbnB1dFZhbHVlPXtpbml0aWFsSW5wdXRWYWx1ZX0gLz5cbiAgPC9Db21wbGV0aW9uUHJvdmlkZXI+XG4pO1xuXG5leHBvcnQgZGVmYXVsdCBDb21tYW5kUHJvbXB0O1xuIiwiaW1wb3J0IFJlYWN0IGZyb20gXCJyZWFjdFwiO1xuaW1wb3J0IENvbXBsZXRpb25JdGVtIGZyb20gXCIuL0NvbXBsZXRpb25JdGVtXCI7XG5pbXBvcnQgQ29tcGxldGlvblRpdGxlIGZyb20gXCIuL0NvbXBsZXRpb25UaXRsZVwiO1xuXG5pbnRlcmZhY2UgSXRlbSB7XG4gIGljb24/OiBzdHJpbmc7XG4gIGNhcHRpb24/OiBzdHJpbmc7XG4gIHVybD86IHN0cmluZztcbn1cblxuaW50ZXJmYWNlIEdyb3VwIHtcbiAgbmFtZTogc3RyaW5nO1xuICBpdGVtczogSXRlbVtdO1xufVxuXG5pbnRlcmZhY2UgUHJvcHMge1xuICBzZWxlY3Q6IG51bWJlcjtcbiAgc2l6ZTogbnVtYmVyO1xuICBjb21wbGV0aW9uczogR3JvdXBbXTtcbn1cblxuY29uc3QgQ29tcGxldGlvbjogUmVhY3QuRkM8UHJvcHM+ID0gKHsgc2VsZWN0LCBzaXplLCBjb21wbGV0aW9ucyB9KSA9PiB7XG4gIGNvbnN0IFt2aWV3T2Zmc2V0LCBzZXRWaWV3T2Zmc2V0XSA9IFJlYWN0LnVzZVN0YXRlKDApO1xuICBjb25zdCBbcHJldlNlbGVjdCwgc2V0UHJldlNlbGVjdF0gPSBSZWFjdC51c2VTdGF0ZSgtMSk7XG5cbiAgUmVhY3QudXNlRWZmZWN0KCgpID0+IHtcbiAgICBpZiAoc2VsZWN0ID09PSBwcmV2U2VsZWN0KSB7XG4gICAgICByZXR1cm47XG4gICAgfVxuXG4gICAgY29uc3Qgdmlld1NlbGVjdCA9ICgoKSA9PiB7XG4gICAgICBsZXQgaW5kZXggPSAwO1xuICAgICAgZm9yIChsZXQgaSA9IDA7IGkgPCBjb21wbGV0aW9ucy5sZW5ndGg7ICsraSkge1xuICAgICAgICArK2luZGV4O1xuICAgICAgICBjb25zdCBnID0gY29tcGxldGlvbnNbaV07XG4gICAgICAgIGlmIChzZWxlY3QgKyBpICsgMSA8IGluZGV4ICsgZy5pdGVtcy5sZW5ndGgpIHtcbiAgICAgICAgICByZXR1cm4gc2VsZWN0ICsgaSArIDE7XG4gICAgICAgIH1cbiAgICAgICAgaW5kZXggKz0gZy5pdGVtcy5sZW5ndGg7XG4gICAgICB9XG4gICAgICByZXR1cm4gLTE7XG4gICAgfSkoKTtcblxuICAgIGNvbnN0IG5leHRWaWV3T2Zmc2V0ID0gKCgpID0+IHtcbiAgICAgIGlmIChwcmV2U2VsZWN0IDwgc2VsZWN0KSB7XG4gICAgICAgIHJldHVybiBNYXRoLm1heCh2aWV3T2Zmc2V0LCB2aWV3U2VsZWN0IC0gc2l6ZSArIDEpO1xuICAgICAgfSBlbHNlIGlmIChwcmV2U2VsZWN0ID4gc2VsZWN0KSB7XG4gICAgICAgIHJldHVybiBNYXRoLm1pbih2aWV3T2Zmc2V0LCB2aWV3U2VsZWN0KTtcbiAgICAgIH1cbiAgICAgIHJldHVybiAwO1xuICAgIH0pKCk7XG5cbiAgICBzZXRQcmV2U2VsZWN0KHNlbGVjdCk7XG4gICAgc2V0Vmlld09mZnNldChuZXh0Vmlld09mZnNldCk7XG4gIH0sIFtzZWxlY3RdKTtcblxuICBsZXQgaXRlbUluZGV4ID0gMDtcbiAgbGV0IHZpZXdJbmRleCA9IDA7XG4gIGNvbnN0IGdyb3VwczogQXJyYXk8SlNYLkVsZW1lbnQ+ID0gW107XG5cbiAgY29tcGxldGlvbnMuZm9yRWFjaCgoZ3JvdXAsIGdyb3VwSW5kZXgpID0+IHtcbiAgICBjb25zdCBpdGVtcyA9IFtdO1xuICAgIGNvbnN0IHRpdGxlID0gKFxuICAgICAgPENvbXBsZXRpb25UaXRsZVxuICAgICAgICBpZD17YHRpdGxlLSR7Z3JvdXBJbmRleH1gfVxuICAgICAgICBrZXk9e2Bncm91cC0ke2dyb3VwSW5kZXh9YH1cbiAgICAgICAgc2hvd249e3ZpZXdPZmZzZXQgPD0gdmlld0luZGV4ICYmIHZpZXdJbmRleCA8IHZpZXdPZmZzZXQgKyBzaXplfVxuICAgICAgICB0aXRsZT17Z3JvdXAubmFtZX1cbiAgICAgIC8+XG4gICAgKTtcbiAgICArK3ZpZXdJbmRleDtcbiAgICBmb3IgKGNvbnN0IGl0ZW0gb2YgZ3JvdXAuaXRlbXMpIHtcbiAgICAgIGl0ZW1zLnB1c2goXG4gICAgICAgIDxDb21wbGV0aW9uSXRlbVxuICAgICAgICAgIHNob3duPXt2aWV3T2Zmc2V0IDw9IHZpZXdJbmRleCAmJiB2aWV3SW5kZXggPCB2aWV3T2Zmc2V0ICsgc2l6ZX1cbiAgICAgICAgICBrZXk9e2BpdGVtLSR7aXRlbUluZGV4fWB9XG4gICAgICAgICAgaWNvbj17aXRlbS5pY29ufVxuICAgICAgICAgIGNhcHRpb249e2l0ZW0uY2FwdGlvbn1cbiAgICAgICAgICB1cmw9e2l0ZW0udXJsfVxuICAgICAgICAgIGhpZ2hsaWdodD17aXRlbUluZGV4ID09PSBzZWxlY3R9XG4gICAgICAgICAgYXJpYS1zZWxlY3RlZD17aXRlbUluZGV4ID09PSBzZWxlY3R9XG4gICAgICAgICAgcm9sZT1cIm1lbnVpdGVtXCJcbiAgICAgICAgLz5cbiAgICAgICk7XG4gICAgICArK3ZpZXdJbmRleDtcbiAgICAgICsraXRlbUluZGV4O1xuICAgIH1cbiAgICBncm91cHMucHVzaChcbiAgICAgIDxkaXZcbiAgICAgICAga2V5PXtgZ3JvdXAtJHtncm91cEluZGV4fWB9XG4gICAgICAgIHJvbGU9XCJncm91cFwiXG4gICAgICAgIGFyaWEtZGVzY3JpYmVkYnk9e2B0aXRsZS0ke2dyb3VwSW5kZXh9YH1cbiAgICAgID5cbiAgICAgICAge3RpdGxlfVxuICAgICAgICA8dWw+e2l0ZW1zfTwvdWw+XG4gICAgICA8L2Rpdj5cbiAgICApO1xuICB9KTtcblxuICByZXR1cm4gPGRpdiByb2xlPVwibWVudVwiPntncm91cHN9PC9kaXY+O1xufTtcblxuZXhwb3J0IGRlZmF1bHQgQ29tcGxldGlvbjtcbiIsImltcG9ydCBSZWFjdCBmcm9tIFwicmVhY3RcIjtcbmltcG9ydCBzdHlsZWQgZnJvbSBcIi4uLy4uL2NvbG9yc2NoZW1lL3N0eWxlZFwiO1xuXG5jb25zdCBDb250YWluZXIgPSBzdHlsZWQubGk8e1xuICBzaG93bjogYm9vbGVhbjtcbiAgaWNvbjogc3RyaW5nO1xuICBoaWdobGlnaHQ6IGJvb2xlYW47XG59PmBcbiAgYmFja2dyb3VuZC1pbWFnZTogJHsoeyBpY29uIH0pID0+IFwidXJsKFwiICsgaWNvbiArIFwiKVwifTtcbiAgYmFja2dyb3VuZC1jb2xvcjogJHsoeyBoaWdobGlnaHQsIHRoZW1lIH0pID0+XG4gICAgaGlnaGxpZ2h0XG4gICAgICA/IHRoZW1lLmNvbXBsZXRpb25TZWxlY3RlZEJhY2tncm91bmRcbiAgICAgIDogdGhlbWUuY29tcGxldGlvbkl0ZW1CYWNrZ3JvdW5kfTtcbiAgY29sb3I6ICR7KHsgaGlnaGxpZ2h0LCB0aGVtZSB9KSA9PlxuICAgIGhpZ2hsaWdodFxuICAgICAgPyB0aGVtZS5jb21wbGV0aW9uU2VsZWN0ZWRGb3JlZ3JvdW5kXG4gICAgICA6IHRoZW1lLmNvbXBsZXRpb25JdGVtRm9yZWdyb3VuZH07XG4gIGRpc3BsYXk6ICR7KHsgc2hvd24gfSkgPT4gKHNob3duID8gXCJkaXNwbGF5XCIgOiBcIm5vbmVcIil9O1xuICBwYWRkaW5nLWxlZnQ6IDEuOHJlbTtcbiAgYmFja2dyb3VuZC1wb3NpdGlvbjogMCBjZW50ZXI7XG4gIGJhY2tncm91bmQtc2l6ZTogY29udGFpbjtcbiAgYmFja2dyb3VuZC1yZXBlYXQ6IG5vLXJlcGVhdDtcbiAgd2hpdGUtc3BhY2U6IHByZTtcbmA7XG5cbmNvbnN0IENhcHRpb24gPSBzdHlsZWQuc3BhbmBcbiAgZGlzcGxheTogaW5saW5lLWJsb2NrO1xuICB3aWR0aDogNDAlO1xuICB0ZXh0LW92ZXJmbG93OiBlbGxpcHNpcztcbiAgb3ZlcmZsb3c6IGhpZGRlbjtcbmA7XG5cbmNvbnN0IERlc2NyaXB0aW9uID0gc3R5bGVkLnNwYW5gXG4gIGRpc3BsYXk6IGlubGluZS1ibG9jaztcbiAgY29sb3I6ICR7KHsgdGhlbWUgfSkgPT4gdGhlbWUuY29tcGxldGlvbkl0ZW1EZXNjcmlwdGlvbkZvcmVncm91bmR9O1xuICB3aWR0aDogNjAlO1xuICB0ZXh0LW92ZXJmbG93OiBlbGxpcHNpcztcbiAgb3ZlcmZsb3c6IGhpZGRlbjtcbmA7XG5cbmludGVyZmFjZSBQcm9wcyBleHRlbmRzIFJlYWN0LkhUTUxBdHRyaWJ1dGVzPEhUTUxFbGVtZW50PiB7XG4gIHNob3duOiBib29sZWFuO1xuICBoaWdobGlnaHQ6IGJvb2xlYW47XG4gIGNhcHRpb24/OiBzdHJpbmc7XG4gIHVybD86IHN0cmluZztcbiAgaWNvbj86IHN0cmluZztcbn1cblxuY29uc3QgQ29tcGxldGlvbkl0ZW06IFJlYWN0LkZDPFByb3BzPiA9IChwcm9wcykgPT4gKFxuICA8Q29udGFpbmVyXG4gICAgaWNvbj17cHJvcHMuaWNvbiB8fCBcIlwifVxuICAgIGFyaWEtbGFiZWxsZWRieT17YGNvbXBsZXRpb24taXRlbS0ke3Byb3BzLmNhcHRpb259YH1cbiAgICB7Li4ucHJvcHN9XG4gID5cbiAgICA8Q2FwdGlvbiBpZD17YGNvbXBsZXRpb24taXRlbS0ke3Byb3BzLmNhcHRpb259YH0+e3Byb3BzLmNhcHRpb259PC9DYXB0aW9uPlxuICAgIDxEZXNjcmlwdGlvbj57cHJvcHMudXJsfTwvRGVzY3JpcHRpb24+XG4gIDwvQ29udGFpbmVyPlxuKTtcblxuZXhwb3J0IGRlZmF1bHQgQ29tcGxldGlvbkl0ZW07XG4iLCJpbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgc3R5bGVkIGZyb20gXCIuLi8uLi9jb2xvcnNjaGVtZS9zdHlsZWRcIjtcblxuY29uc3QgTGkgPSBzdHlsZWQubGk8eyBzaG93bjogYm9vbGVhbiB9PmBcbiAgZGlzcGxheTogJHsoeyBzaG93biB9KSA9PiAoc2hvd24gPyBcImRpc3BsYXlcIiA6IFwibm9uZVwiKX07XG4gIGJhY2tncm91bmQtY29sb3I6ICR7KHsgdGhlbWUgfSkgPT4gdGhlbWUuY29tcGxldGlvblRpdGxlQmFja2dyb3VuZH07XG4gIGNvbG9yOiAkeyh7IHRoZW1lIH0pID0+IHRoZW1lLmNvbXBsZXRpb25UaXRsZUZvcmVncm91bmR9O1xuICBmb250LXdlaWdodDogYm9sZDtcbiAgbWFyZ2luOiAwO1xuICBwYWRkaW5nOiAwO1xuYDtcblxuaW50ZXJmYWNlIFByb3BzIGV4dGVuZHMgUmVhY3QuSFRNTEF0dHJpYnV0ZXM8SFRNTEVsZW1lbnQ+IHtcbiAgc2hvd246IGJvb2xlYW47XG4gIHRpdGxlOiBzdHJpbmc7XG59XG5cbmNvbnN0IENvbXBsZXRpb25UaXRsZTogUmVhY3QuRkM8UHJvcHM+ID0gKHByb3BzKSA9PiAoXG4gIDxMaSB7Li4ucHJvcHN9Pntwcm9wcy50aXRsZX08L0xpPlxuKTtcblxuZXhwb3J0IGRlZmF1bHQgQ29tcGxldGlvblRpdGxlO1xuIiwiaW1wb3J0IFJlYWN0IGZyb20gXCJyZWFjdFwiO1xuaW1wb3J0ICogYXMgYWN0aW9ucyBmcm9tIFwiLi9hY3Rpb25zXCI7XG5pbXBvcnQgeyBDb21tYW5kIH0gZnJvbSBcIi4uLy4uL3NoYXJlZC9Db21tYW5kXCI7XG5pbXBvcnQgVGFiRmxhZyBmcm9tIFwiLi4vLi4vc2hhcmVkL1RhYkZsYWdcIjtcbmltcG9ydCB7IENvbXBsZXRpb25TdGF0ZUNvbnRleHQsIENvbXBsZXRpb25EaXNwYXRjaENvbnRleHQgfSBmcm9tIFwiLi9jb250ZXh0XCI7XG5pbXBvcnQgQ29tcGxldGlvbkNsaWVudCBmcm9tIFwiLi4vY2xpZW50cy9Db21wbGV0aW9uQ2xpZW50XCI7XG5pbXBvcnQgQ29tbWFuZExpbmVQYXJzZXIsIHtcbiAgQ29tbWFuZExpbmUsXG4gIElucHV0UGhhc2UsXG59IGZyb20gXCIuLi9jb21tYW5kbGluZS9Db21tYW5kTGluZVBhcnNlclwiO1xuaW1wb3J0IHsgVW5rbm93bkNvbW1hbmRFcnJvciB9IGZyb20gXCIuLi9jb21tYW5kbGluZS9Db21tYW5kUGFyc2VyXCI7XG5pbXBvcnQgQ29tcGxldGlvbnMgZnJvbSBcIi4uL0NvbXBsZXRpb25zXCI7XG5pbXBvcnQgQ29tcGxldGlvblR5cGUgZnJvbSBcIi4uLy4uL3NoYXJlZC9Db21wbGV0aW9uVHlwZVwiO1xuXG5jb25zdCBjb21tYW5kRG9jcyA9IHtcbiAgW0NvbW1hbmQuU2V0XTogXCJTZXQgYSB2YWx1ZSBvZiB0aGUgcHJvcGVydHlcIixcbiAgW0NvbW1hbmQuT3Blbl06IFwiT3BlbiBhIFVSTCBvciBzZWFyY2ggYnkga2V5d29yZHMgaW4gY3VycmVudCB0YWJcIixcbiAgW0NvbW1hbmQuVGFiT3Blbl06IFwiT3BlbiBhIFVSTCBvciBzZWFyY2ggYnkga2V5d29yZHMgaW4gbmV3IHRhYlwiLFxuICBbQ29tbWFuZC5XaW5kb3dPcGVuXTogXCJPcGVuIGEgVVJMIG9yIHNlYXJjaCBieSBrZXl3b3JkcyBpbiBuZXcgd2luZG93XCIsXG4gIFtDb21tYW5kLkJ1ZmZlcl06IFwiU2VsZWN0IHRhYnMgYnkgbWF0Y2hlZCBrZXl3b3Jkc1wiLFxuICBbQ29tbWFuZC5CdWZmZXJEZWxldGVdOiBcIkNsb3NlIGEgY2VydGFpbiB0YWIgbWF0Y2hlZCBieSBrZXl3b3Jkc1wiLFxuICBbQ29tbWFuZC5CdWZmZXJzRGVsZXRlXTogXCJDbG9zZSBhbGwgdGFicyBtYXRjaGVkIGJ5IGtleXdvcmRzXCIsXG4gIFtDb21tYW5kLlF1aXRdOiBcIkNsb3NlIHRoZSBjdXJyZW50IHRhYlwiLFxuICBbQ29tbWFuZC5RdWl0QWxsXTogXCJDbG9zZSBhbGwgdGFic1wiLFxuICBbQ29tbWFuZC5BZGRCb29rbWFya106IFwiQWRkIGN1cnJlbnQgcGFnZSB0byBib29rbWFya3NcIixcbiAgW0NvbW1hbmQuSGVscF06IFwiT3BlbiBWaW0gVml4ZW4gaGVscCBpbiBuZXcgdGFiXCIsXG59O1xuXG5jb25zdCBwcm9wZXJ0eURvY3M6IHsgW2tleTogc3RyaW5nXTogc3RyaW5nIH0gPSB7XG4gIGhpbnRjaGFyczogXCJoaW50IGNoYXJhY3RlcnMgb24gZm9sbG93IG1vZGVcIixcbiAgc21vb3Roc2Nyb2xsOiBcInNtb290aCBzY3JvbGxcIixcbiAgY29tcGxldGU6IFwid2hpY2ggYXJlIGNvbXBsZXRlZCBhdCB0aGUgb3BlbiBwYWdlXCIsXG4gIGNvbG9yc2NoZW1lOiBcImNvbG9yIHNjaGVtZSBvZiB0aGUgY29uc29sZVwiLFxufTtcblxuY29uc3QgY29tcGxldGlvbkNsaWVudCA9IG5ldyBDb21wbGV0aW9uQ2xpZW50KCk7XG5cbmNvbnN0IHVzZURlbGF5ZWRDYWxsYmFjayA9IDxUIGV4dGVuZHMgdW5rbm93biwgVSBleHRlbmRzIHVua25vd24+KFxuICBjYWxsYmFjazogKGFyZzE6IFQsIGFyZzI6IFUpID0+IHZvaWQsXG4gIHRpbWVvdXQ6IG51bWJlclxuKSA9PiB7XG4gIGNvbnN0IFt0aW1lciwgc2V0VGltZXJdID0gUmVhY3QudXNlU3RhdGU8XG4gICAgUmV0dXJuVHlwZTx0eXBlb2Ygc2V0VGltZW91dD4gfCB1bmRlZmluZWRcbiAgPigpO1xuICBjb25zdCBbZW5hYmxlZCwgc2V0RW5hYmxlZF0gPSBSZWFjdC51c2VTdGF0ZShmYWxzZSk7XG5cbiAgY29uc3QgZW5hYmxlRGVsYXkgPSBSZWFjdC51c2VDYWxsYmFjaygoKSA9PiB7XG4gICAgc2V0RW5hYmxlZCh0cnVlKTtcbiAgfSwgW3NldEVuYWJsZWRdKTtcblxuICBjb25zdCBkZWxheWVkQ2FsbGJhY2sgPSBSZWFjdC51c2VDYWxsYmFjayhcbiAgICAoYXJnMTogVCwgYXJnMjogVSkgPT4ge1xuICAgICAgaWYgKGVuYWJsZWQpIHtcbiAgICAgICAgaWYgKHR5cGVvZiB0aW1lciAhPT0gXCJ1bmRlZmluZWRcIikge1xuICAgICAgICAgIGNsZWFyVGltZW91dCh0aW1lcik7XG4gICAgICAgIH1cbiAgICAgICAgY29uc3QgaWQgPSBzZXRUaW1lb3V0KCgpID0+IHtcbiAgICAgICAgICBjYWxsYmFjayhhcmcxLCBhcmcyKTtcbiAgICAgICAgICBjbGVhclRpbWVvdXQodGltZXIhKTtcbiAgICAgICAgICBzZXRUaW1lcih1bmRlZmluZWQpO1xuICAgICAgICB9LCB0aW1lb3V0KTtcbiAgICAgICAgc2V0VGltZXIoaWQpO1xuICAgICAgfSBlbHNlIHtcbiAgICAgICAgY2FsbGJhY2soYXJnMSwgYXJnMik7XG4gICAgICB9XG4gICAgfSxcbiAgICBbZW5hYmxlZCwgdGltZXJdXG4gICk7XG5cbiAgcmV0dXJuIHsgZW5hYmxlRGVsYXksIGRlbGF5ZWRDYWxsYmFjayB9O1xufTtcblxuY29uc3QgZ2V0Q29tbWFuZENvbXBsZXRpb25zID0gYXN5bmMgKHF1ZXJ5OiBzdHJpbmcpOiBQcm9taXNlPENvbXBsZXRpb25zPiA9PiB7XG4gIGNvbnN0IGl0ZW1zID0gT2JqZWN0LmVudHJpZXMoY29tbWFuZERvY3MpXG4gICAgLmZpbHRlcigoW25hbWVdKSA9PiBuYW1lLnN0YXJ0c1dpdGgocXVlcnkpKVxuICAgIC5tYXAoKFtuYW1lLCBkb2NdKSA9PiAoe1xuICAgICAgY2FwdGlvbjogbmFtZSxcbiAgICAgIGNvbnRlbnQ6IG5hbWUsXG4gICAgICB1cmw6IGRvYyxcbiAgICB9KSk7XG4gIHJldHVybiBbXG4gICAge1xuICAgICAgbmFtZTogXCJDb25zb2xlIENvbW1hbmRcIixcbiAgICAgIGl0ZW1zLFxuICAgIH0sXG4gIF07XG59O1xuXG5jb25zdCBnZXRPcGVuQ29tcGxldGlvbnMgPSBhc3luYyAoXG4gIGNvbW1hbmQ6IHN0cmluZyxcbiAgcXVlcnk6IHN0cmluZyxcbiAgY29tcGxldGlvblR5cGVzOiBDb21wbGV0aW9uVHlwZVtdXG4pOiBQcm9taXNlPENvbXBsZXRpb25zPiA9PiB7XG4gIGNvbnN0IGNvbXBsZXRpb25zOiBDb21wbGV0aW9ucyA9IFtdO1xuICBmb3IgKGNvbnN0IHR5cGUgb2YgY29tcGxldGlvblR5cGVzKSB7XG4gICAgc3dpdGNoICh0eXBlKSB7XG4gICAgICBjYXNlIENvbXBsZXRpb25UeXBlLlNlYXJjaEVuZ2luZXM6IHtcbiAgICAgICAgY29uc3QgaXRlbXMgPSBhd2FpdCBjb21wbGV0aW9uQ2xpZW50LnJlcXVlc3RTZWFyY2hFbmdpbmVzKHF1ZXJ5KTtcbiAgICAgICAgaWYgKGl0ZW1zLmxlbmd0aCA9PT0gMCkge1xuICAgICAgICAgIGJyZWFrO1xuICAgICAgICB9XG4gICAgICAgIGNvbXBsZXRpb25zLnB1c2goe1xuICAgICAgICAgIG5hbWU6IFwiU2VhcmNoIEVuZ2luZXNcIixcbiAgICAgICAgICBpdGVtczogaXRlbXMubWFwKChrZXkpID0+ICh7XG4gICAgICAgICAgICBjYXB0aW9uOiBrZXkudGl0bGUsXG4gICAgICAgICAgICBjb250ZW50OiBjb21tYW5kICsgXCIgXCIgKyBrZXkudGl0bGUsXG4gICAgICAgICAgfSkpLFxuICAgICAgICB9KTtcbiAgICAgICAgYnJlYWs7XG4gICAgICB9XG4gICAgICBjYXNlIENvbXBsZXRpb25UeXBlLkhpc3Rvcnk6IHtcbiAgICAgICAgY29uc3QgaXRlbXMgPSBhd2FpdCBjb21wbGV0aW9uQ2xpZW50LnJlcXVlc3RIaXN0b3J5KHF1ZXJ5KTtcbiAgICAgICAgaWYgKGl0ZW1zLmxlbmd0aCA9PT0gMCkge1xuICAgICAgICAgIGJyZWFrO1xuICAgICAgICB9XG4gICAgICAgIGNvbXBsZXRpb25zLnB1c2goe1xuICAgICAgICAgIG5hbWU6IFwiSGlzdG9yeVwiLFxuICAgICAgICAgIGl0ZW1zOiBpdGVtcy5tYXAoKGl0ZW0pID0+ICh7XG4gICAgICAgICAgICBjYXB0aW9uOiBpdGVtLnRpdGxlLFxuICAgICAgICAgICAgY29udGVudDogY29tbWFuZCArIFwiIFwiICsgaXRlbS51cmwsXG4gICAgICAgICAgICB1cmw6IGl0ZW0udXJsLFxuICAgICAgICAgIH0pKSxcbiAgICAgICAgfSk7XG4gICAgICAgIGJyZWFrO1xuICAgICAgfVxuICAgICAgY2FzZSBDb21wbGV0aW9uVHlwZS5Cb29rbWFya3M6IHtcbiAgICAgICAgY29uc3QgaXRlbXMgPSBhd2FpdCBjb21wbGV0aW9uQ2xpZW50LnJlcXVlc3RCb29rbWFya3MocXVlcnkpO1xuICAgICAgICBpZiAoaXRlbXMubGVuZ3RoID09PSAwKSB7XG4gICAgICAgICAgYnJlYWs7XG4gICAgICAgIH1cbiAgICAgICAgY29tcGxldGlvbnMucHVzaCh7XG4gICAgICAgICAgbmFtZTogXCJCb29rbWFya3NcIixcbiAgICAgICAgICBpdGVtczogaXRlbXMubWFwKChpdGVtKSA9PiAoe1xuICAgICAgICAgICAgY2FwdGlvbjogaXRlbS50aXRsZSxcbiAgICAgICAgICAgIGNvbnRlbnQ6IGNvbW1hbmQgKyBcIiBcIiArIGl0ZW0udXJsLFxuICAgICAgICAgICAgdXJsOiBpdGVtLnVybCxcbiAgICAgICAgICB9KSksXG4gICAgICAgIH0pO1xuICAgICAgICBicmVhaztcbiAgICAgIH1cbiAgICB9XG4gIH1cbiAgcmV0dXJuIGNvbXBsZXRpb25zO1xufTtcblxuZXhwb3J0IGNvbnN0IGdldFRhYkNvbXBsZXRpb25zID0gYXN5bmMgKFxuICBjb21tYW5kOiBzdHJpbmcsXG4gIHF1ZXJ5OiBzdHJpbmcsXG4gIGV4Y2x1ZGVQaW5uZWQ6IGJvb2xlYW5cbik6IFByb21pc2U8Q29tcGxldGlvbnM+ID0+IHtcbiAgY29uc3QgaXRlbXMgPSBhd2FpdCBjb21wbGV0aW9uQ2xpZW50LnJlcXVlc3RUYWJzKHF1ZXJ5LCBleGNsdWRlUGlubmVkKTtcbiAgaWYgKGl0ZW1zLmxlbmd0aCA9PT0gMCkge1xuICAgIHJldHVybiBbXTtcbiAgfVxuXG4gIHJldHVybiBbXG4gICAge1xuICAgICAgbmFtZTogXCJCdWZmZXJzXCIsXG4gICAgICBpdGVtczogaXRlbXMubWFwKChpdGVtKSA9PiAoe1xuICAgICAgICBjb250ZW50OiBjb21tYW5kICsgXCIgXCIgKyBpdGVtLnVybCxcbiAgICAgICAgY2FwdGlvbjogYCR7aXRlbS5pbmRleH06ICR7XG4gICAgICAgICAgaXRlbS5mbGFnICE9IFRhYkZsYWcuTm9uZSA/IGl0ZW0uZmxhZyA6IFwiIFwiXG4gICAgICAgIH0gJHtpdGVtLnRpdGxlfWAsXG4gICAgICAgIHVybDogaXRlbS51cmwsXG4gICAgICAgIGljb246IGl0ZW0uZmF2aWNvblVybCxcbiAgICAgIH0pKSxcbiAgICB9LFxuICBdO1xufTtcblxuZXhwb3J0IGNvbnN0IGdldFByb3BlcnR5Q29tcGxldGlvbnMgPSBhc3luYyAoXG4gIGNvbW1hbmQ6IHN0cmluZyxcbiAgcXVlcnk6IHN0cmluZ1xuKTogUHJvbWlzZTxDb21wbGV0aW9ucz4gPT4ge1xuICBjb25zdCBwcm9wZXJ0aWVzID0gYXdhaXQgY29tcGxldGlvbkNsaWVudC5nZXRQcm9wZXJ0aWVzKCk7XG4gIGNvbnN0IGl0ZW1zID0gcHJvcGVydGllc1xuICAgIC5tYXAoKGl0ZW0pID0+IHtcbiAgICAgIGNvbnN0IGRlc2MgPSBwcm9wZXJ0eURvY3NbaXRlbS5uYW1lXSB8fCBcIlwiO1xuICAgICAgaWYgKGl0ZW0udHlwZSA9PT0gXCJib29sZWFuXCIpIHtcbiAgICAgICAgcmV0dXJuIFtcbiAgICAgICAgICB7XG4gICAgICAgICAgICBjYXB0aW9uOiBpdGVtLm5hbWUsXG4gICAgICAgICAgICBjb250ZW50OiBjb21tYW5kICsgXCIgXCIgKyBpdGVtLm5hbWUsXG4gICAgICAgICAgICB1cmw6IFwiRW5hYmxlIFwiICsgZGVzYyxcbiAgICAgICAgICB9LFxuICAgICAgICAgIHtcbiAgICAgICAgICAgIGNhcHRpb246IFwibm9cIiArIGl0ZW0ubmFtZSxcbiAgICAgICAgICAgIGNvbnRlbnQ6IGNvbW1hbmQgKyBcIiBub1wiICsgaXRlbS5uYW1lLFxuICAgICAgICAgICAgdXJsOiBcIkRpc2FibGUgXCIgKyBkZXNjLFxuICAgICAgICAgIH0sXG4gICAgICAgIF07XG4gICAgICB9IGVsc2Uge1xuICAgICAgICByZXR1cm4gW1xuICAgICAgICAgIHtcbiAgICAgICAgICAgIGNhcHRpb246IGl0ZW0ubmFtZSxcbiAgICAgICAgICAgIGNvbnRlbnQ6IGNvbW1hbmQgKyBcIiBcIiArIGl0ZW0ubmFtZSxcbiAgICAgICAgICAgIHVybDogXCJTZXQgXCIgKyBkZXNjLFxuICAgICAgICAgIH0sXG4gICAgICAgIF07XG4gICAgICB9XG4gICAgfSlcbiAgICAucmVkdWNlKChhY2MsIHZhbCkgPT4gYWNjLmNvbmNhdCh2YWwpLCBbXSlcbiAgICAuZmlsdGVyKChpdGVtKSA9PiBpdGVtLmNhcHRpb24uc3RhcnRzV2l0aChxdWVyeSkpO1xuICByZXR1cm4gW3sgbmFtZTogXCJQcm9wZXJ0aWVzXCIsIGl0ZW1zIH1dO1xufTtcblxuZXhwb3J0IGNvbnN0IHVzZUNvbXBsZXRpb25zID0gKCkgPT4ge1xuICBjb25zdCBzdGF0ZSA9IFJlYWN0LnVzZUNvbnRleHQoQ29tcGxldGlvblN0YXRlQ29udGV4dCk7XG4gIGNvbnN0IGRpc3BhdGNoID0gUmVhY3QudXNlQ29udGV4dChDb21wbGV0aW9uRGlzcGF0Y2hDb250ZXh0KTtcbiAgY29uc3QgY29tbWFuZExpbmVQYXJzZXIgPSBSZWFjdC51c2VNZW1vKCgpID0+IG5ldyBDb21tYW5kTGluZVBhcnNlcigpLCBbXSk7XG5cbiAgY29uc3QgdXBkYXRlQ29tcGxldGlvbnMgPSBSZWFjdC51c2VDYWxsYmFjaygoc291cmNlOiBzdHJpbmcpID0+IHtcbiAgICBkaXNwYXRjaChhY3Rpb25zLnNldENvbXBsZXRpb25Tb3VyY2Uoc291cmNlKSk7XG4gIH0sIFtdKTtcblxuICBjb25zdCBpbml0Q29tcGxldGlvbiA9IFJlYWN0LnVzZUNhbGxiYWNrKChzb3VyY2U6IHN0cmluZykgPT4ge1xuICAgIGNvbXBsZXRpb25DbGllbnQuZ2V0Q29tcGxldGlvblR5cGVzKCkudGhlbigoY29tcGxldGlvblR5cGVzKSA9PiB7XG4gICAgICBkaXNwYXRjaChhY3Rpb25zLmluaXRDb21wbGV0aW9uKGNvbXBsZXRpb25UeXBlcykpO1xuICAgICAgZGlzcGF0Y2goYWN0aW9ucy5zZXRDb21wbGV0aW9uU291cmNlKHNvdXJjZSkpO1xuICAgIH0pO1xuICB9LCBbXSk7XG5cbiAgY29uc3QgeyBkZWxheWVkQ2FsbGJhY2s6IHF1ZXJ5Q29tcGxldGlvbnMsIGVuYWJsZURlbGF5IH0gPSB1c2VEZWxheWVkQ2FsbGJhY2soXG4gICAgUmVhY3QudXNlQ2FsbGJhY2soXG4gICAgICAodGV4dDogc3RyaW5nLCBjb21wbGV0aW9uVHlwZXM/OiBDb21wbGV0aW9uVHlwZVtdKSA9PiB7XG4gICAgICAgIGNvbnN0IHBoYXNlID0gY29tbWFuZExpbmVQYXJzZXIuaW5wdXRQaGFzZSh0ZXh0KTtcbiAgICAgICAgaWYgKHBoYXNlID09PSBJbnB1dFBoYXNlLk9uQ29tbWFuZCkge1xuICAgICAgICAgIGdldENvbW1hbmRDb21wbGV0aW9ucyh0ZXh0KS50aGVuKChjb21wbGV0aW9ucykgPT5cbiAgICAgICAgICAgIGRpc3BhdGNoKGFjdGlvbnMuc2V0Q29tcGxldGlvbnMoY29tcGxldGlvbnMpKVxuICAgICAgICAgICk7XG4gICAgICAgIH0gZWxzZSB7XG4gICAgICAgICAgbGV0IGNtZDogQ29tbWFuZExpbmUgfCBudWxsID0gbnVsbDtcbiAgICAgICAgICB0cnkge1xuICAgICAgICAgICAgY21kID0gY29tbWFuZExpbmVQYXJzZXIucGFyc2UodGV4dCk7XG4gICAgICAgICAgfSBjYXRjaCAoZSkge1xuICAgICAgICAgICAgaWYgKGUgaW5zdGFuY2VvZiBVbmtub3duQ29tbWFuZEVycm9yKSB7XG4gICAgICAgICAgICAgIHJldHVybjtcbiAgICAgICAgICAgIH1cbiAgICAgICAgICB9XG4gICAgICAgICAgc3dpdGNoIChjbWQ/LmNvbW1hbmQpIHtcbiAgICAgICAgICAgIGNhc2UgQ29tbWFuZC5PcGVuOlxuICAgICAgICAgICAgY2FzZSBDb21tYW5kLlRhYk9wZW46XG4gICAgICAgICAgICBjYXNlIENvbW1hbmQuV2luZG93T3BlbjpcbiAgICAgICAgICAgICAgaWYgKCFjb21wbGV0aW9uVHlwZXMpIHtcbiAgICAgICAgICAgICAgICBpbml0Q29tcGxldGlvbih0ZXh0KTtcbiAgICAgICAgICAgICAgICByZXR1cm47XG4gICAgICAgICAgICAgIH1cblxuICAgICAgICAgICAgICBnZXRPcGVuQ29tcGxldGlvbnMoY21kLmNvbW1hbmQsIGNtZC5hcmdzLCBjb21wbGV0aW9uVHlwZXMpLnRoZW4oXG4gICAgICAgICAgICAgICAgKGNvbXBsZXRpb25zKSA9PiBkaXNwYXRjaChhY3Rpb25zLnNldENvbXBsZXRpb25zKGNvbXBsZXRpb25zKSlcbiAgICAgICAgICAgICAgKTtcbiAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICBjYXNlIENvbW1hbmQuQnVmZmVyOlxuICAgICAgICAgICAgICBnZXRUYWJDb21wbGV0aW9ucyhjbWQuY29tbWFuZCwgY21kLmFyZ3MsIGZhbHNlKS50aGVuKFxuICAgICAgICAgICAgICAgIChjb21wbGV0aW9ucykgPT4gZGlzcGF0Y2goYWN0aW9ucy5zZXRDb21wbGV0aW9ucyhjb21wbGV0aW9ucykpXG4gICAgICAgICAgICAgICk7XG4gICAgICAgICAgICAgIGJyZWFrO1xuICAgICAgICAgICAgY2FzZSBDb21tYW5kLkJ1ZmZlckRlbGV0ZTpcbiAgICAgICAgICAgIGNhc2UgQ29tbWFuZC5CdWZmZXJzRGVsZXRlOlxuICAgICAgICAgICAgICBnZXRUYWJDb21wbGV0aW9ucyhjbWQuY29tbWFuZCwgY21kLmFyZ3MsIHRydWUpLnRoZW4oXG4gICAgICAgICAgICAgICAgKGNvbXBsZXRpb25zKSA9PiBkaXNwYXRjaChhY3Rpb25zLnNldENvbXBsZXRpb25zKGNvbXBsZXRpb25zKSlcbiAgICAgICAgICAgICAgKTtcbiAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgICBjYXNlIENvbW1hbmQuQnVmZmVyRGVsZXRlRm9yY2U6XG4gICAgICAgICAgICBjYXNlIENvbW1hbmQuQnVmZmVyc0RlbGV0ZUZvcmNlOlxuICAgICAgICAgICAgICBnZXRUYWJDb21wbGV0aW9ucyhjbWQuY29tbWFuZCwgY21kLmFyZ3MsIGZhbHNlKS50aGVuKFxuICAgICAgICAgICAgICAgIChjb21wbGV0aW9ucykgPT4gZGlzcGF0Y2goYWN0aW9ucy5zZXRDb21wbGV0aW9ucyhjb21wbGV0aW9ucykpXG4gICAgICAgICAgICAgICk7XG4gICAgICAgICAgICAgIGJyZWFrO1xuICAgICAgICAgICAgY2FzZSBDb21tYW5kLlNldDpcbiAgICAgICAgICAgICAgZ2V0UHJvcGVydHlDb21wbGV0aW9ucyhjbWQuY29tbWFuZCwgY21kLmFyZ3MpLnRoZW4oXG4gICAgICAgICAgICAgICAgKGNvbXBsZXRpb25zKSA9PiBkaXNwYXRjaChhY3Rpb25zLnNldENvbXBsZXRpb25zKGNvbXBsZXRpb25zKSlcbiAgICAgICAgICAgICAgKTtcbiAgICAgICAgICAgICAgYnJlYWs7XG4gICAgICAgICAgfVxuICAgICAgICAgIGVuYWJsZURlbGF5KCk7XG4gICAgICAgIH1cbiAgICAgIH0sXG4gICAgICBbZGlzcGF0Y2hdXG4gICAgKSxcbiAgICAxMDBcbiAgKTtcblxuICBSZWFjdC51c2VFZmZlY3QoKCkgPT4ge1xuICAgIHF1ZXJ5Q29tcGxldGlvbnMoc3RhdGUuY29tcGxldGlvblNvdXJjZSwgc3RhdGUuY29tcGxldGlvblR5cGVzKTtcbiAgfSwgW3N0YXRlLmNvbXBsZXRpb25Tb3VyY2UsIHN0YXRlLmNvbXBsZXRpb25UeXBlc10pO1xuXG4gIHJldHVybiB7XG4gICAgY29tcGxldGlvbnM6IHN0YXRlLmNvbXBsZXRpb25zLFxuICAgIHVwZGF0ZUNvbXBsZXRpb25zLFxuICAgIGluaXRDb21wbGV0aW9uLFxuICB9O1xufTtcblxuZXhwb3J0IGNvbnN0IHVzZVNlbGVjdENvbXBsZXRpb24gPSAoKSA9PiB7XG4gIGNvbnN0IHN0YXRlID0gUmVhY3QudXNlQ29udGV4dChDb21wbGV0aW9uU3RhdGVDb250ZXh0KTtcbiAgY29uc3QgZGlzcGF0Y2ggPSBSZWFjdC51c2VDb250ZXh0KENvbXBsZXRpb25EaXNwYXRjaENvbnRleHQpO1xuICBjb25zdCBuZXh0ID0gUmVhY3QudXNlQ2FsbGJhY2soXG4gICAgKCkgPT4gZGlzcGF0Y2goYWN0aW9ucy5zZWxlY3ROZXh0KCkpLFxuICAgIFtkaXNwYXRjaF1cbiAgKTtcbiAgY29uc3QgcHJldiA9IFJlYWN0LnVzZUNhbGxiYWNrKFxuICAgICgpID0+IGRpc3BhdGNoKGFjdGlvbnMuc2VsZWN0UHJldigpKSxcbiAgICBbZGlzcGF0Y2hdXG4gICk7XG4gIGNvbnN0IGN1cnJlbnRWYWx1ZSA9IFJlYWN0LnVzZU1lbW8oKCkgPT4ge1xuICAgIGlmIChzdGF0ZS5zZWxlY3QgPCAwKSB7XG4gICAgICByZXR1cm4gc3RhdGUuY29tcGxldGlvblNvdXJjZTtcbiAgICB9XG4gICAgY29uc3QgaXRlbXMgPSBzdGF0ZS5jb21wbGV0aW9ucy5tYXAoKGcpID0+IGcuaXRlbXMpLmZsYXQoKTtcbiAgICByZXR1cm4gaXRlbXNbc3RhdGUuc2VsZWN0XT8uY29udGVudCB8fCBcIlwiO1xuICB9LCBbc3RhdGUuY29tcGxldGlvblNvdXJjZSwgc3RhdGUuc2VsZWN0XSk7XG5cbiAgcmV0dXJuIHtcbiAgICBzZWxlY3Q6IHN0YXRlLnNlbGVjdCxcbiAgICBjdXJyZW50VmFsdWUsXG4gICAgc2VsZWN0TmV4dDogbmV4dCxcbiAgICBzZWxlY3RQcmV2OiBwcmV2LFxuICB9O1xufTtcbiIsImltcG9ydCAqIGFzIG1lc3NhZ2VzIGZyb20gXCIuLi8uLi9zaGFyZWQvbWVzc2FnZXNcIjtcbmltcG9ydCB7XG4gIENvbnNvbGVHZXRDb21wbGV0aW9uVHlwZXNSZXNwb25zZSxcbiAgQ29uc29sZUdldFByb3BlcnRpZXNSZXNwb25zZSxcbiAgQ29uc29sZVJlcXVlc3RCb29rbWFya3NSZXNwb25zZSxcbiAgQ29uc29sZVJlcXVlc3RIaXN0b3J5UmVzcG9uc2UsXG4gIENvbnNvbGVSZXF1ZXN0U2VhcmNoRW5naW5lc1Jlc3BvbnNlLFxuICBDb25zb2xlUmVxdWVzdFRhYnNSZXNwb25zZSxcbn0gZnJvbSBcIi4uLy4uL3NoYXJlZC9tZXNzYWdlc1wiO1xuaW1wb3J0IENvbXBsZXRpb25UeXBlIGZyb20gXCIuLi8uLi9zaGFyZWQvQ29tcGxldGlvblR5cGVcIjtcbmltcG9ydCBUYWJGbGFnIGZyb20gXCIuLi8uLi9zaGFyZWQvVGFiRmxhZ1wiO1xuXG5leHBvcnQgdHlwZSBTZWFyY2hFbmdpbmVzID0ge1xuICB0aXRsZTogc3RyaW5nO1xufTtcblxuZXhwb3J0IHR5cGUgQm9va21hcmtJdGVtID0ge1xuICB0aXRsZTogc3RyaW5nO1xuICB1cmw6IHN0cmluZztcbn07XG5cbmV4cG9ydCB0eXBlIEhpc3RvcnlJdGVtID0ge1xuICB0aXRsZTogc3RyaW5nO1xuICB1cmw6IHN0cmluZztcbn07XG5cbmV4cG9ydCB0eXBlIFRhYkl0ZW0gPSB7XG4gIGluZGV4OiBudW1iZXI7XG4gIGZsYWc6IFRhYkZsYWc7XG4gIHRpdGxlOiBzdHJpbmc7XG4gIHVybDogc3RyaW5nO1xuICBmYXZpY29uVXJsPzogc3RyaW5nO1xufTtcblxuZXhwb3J0IHR5cGUgUHJvcGVydHkgPSB7XG4gIG5hbWU6IHN0cmluZztcbiAgdHlwZTogXCJzdHJpbmdcIiB8IFwiYm9vbGVhblwiIHwgXCJudW1iZXJcIjtcbn07XG5cbmV4cG9ydCBkZWZhdWx0IGNsYXNzIENvbXBsZXRpb25DbGllbnQge1xuICBhc3luYyBnZXRDb21wbGV0aW9uVHlwZXMoKTogUHJvbWlzZTxDb21wbGV0aW9uVHlwZVtdPiB7XG4gICAgY29uc3QgcmVzcCA9IChhd2FpdCBicm93c2VyLnJ1bnRpbWUuc2VuZE1lc3NhZ2Uoe1xuICAgICAgdHlwZTogbWVzc2FnZXMuQ09OU09MRV9HRVRfQ09NUExFVElPTl9UWVBFUyxcbiAgICB9KSkgYXMgQ29uc29sZUdldENvbXBsZXRpb25UeXBlc1Jlc3BvbnNlO1xuICAgIHJldHVybiByZXNwO1xuICB9XG5cbiAgYXN5bmMgcmVxdWVzdFNlYXJjaEVuZ2luZXMocXVlcnk6IHN0cmluZyk6IFByb21pc2U8U2VhcmNoRW5naW5lc1tdPiB7XG4gICAgY29uc3QgcmVzcCA9IChhd2FpdCBicm93c2VyLnJ1bnRpbWUuc2VuZE1lc3NhZ2Uoe1xuICAgICAgdHlwZTogbWVzc2FnZXMuQ09OU09MRV9SRVFVRVNUX1NFQVJDSF9FTkdJTkVTX01FU1NBR0UsXG4gICAgICBxdWVyeSxcbiAgICB9KSkgYXMgQ29uc29sZVJlcXVlc3RTZWFyY2hFbmdpbmVzUmVzcG9uc2U7XG4gICAgcmV0dXJuIHJlc3A7XG4gIH1cblxuICBhc3luYyByZXF1ZXN0Qm9va21hcmtzKHF1ZXJ5OiBzdHJpbmcpOiBQcm9taXNlPEJvb2ttYXJrSXRlbVtdPiB7XG4gICAgY29uc3QgcmVzcCA9IChhd2FpdCBicm93c2VyLnJ1bnRpbWUuc2VuZE1lc3NhZ2Uoe1xuICAgICAgdHlwZTogbWVzc2FnZXMuQ09OU09MRV9SRVFVRVNUX0JPT0tNQVJLUyxcbiAgICAgIHF1ZXJ5LFxuICAgIH0pKSBhcyBDb25zb2xlUmVxdWVzdEJvb2ttYXJrc1Jlc3BvbnNlO1xuICAgIHJldHVybiByZXNwO1xuICB9XG5cbiAgYXN5bmMgcmVxdWVzdEhpc3RvcnkocXVlcnk6IHN0cmluZyk6IFByb21pc2U8SGlzdG9yeUl0ZW1bXT4ge1xuICAgIGNvbnN0IHJlc3AgPSAoYXdhaXQgYnJvd3Nlci5ydW50aW1lLnNlbmRNZXNzYWdlKHtcbiAgICAgIHR5cGU6IG1lc3NhZ2VzLkNPTlNPTEVfUkVRVUVTVF9ISVNUT1JZLFxuICAgICAgcXVlcnksXG4gICAgfSkpIGFzIENvbnNvbGVSZXF1ZXN0SGlzdG9yeVJlc3BvbnNlO1xuICAgIHJldHVybiByZXNwO1xuICB9XG5cbiAgYXN5bmMgcmVxdWVzdFRhYnMocXVlcnk6IHN0cmluZywgZXhjbHVkZVBpbm5lZDogYm9vbGVhbik6IFByb21pc2U8VGFiSXRlbVtdPiB7XG4gICAgY29uc3QgcmVzcCA9IChhd2FpdCBicm93c2VyLnJ1bnRpbWUuc2VuZE1lc3NhZ2Uoe1xuICAgICAgdHlwZTogbWVzc2FnZXMuQ09OU09MRV9SRVFVRVNUX1RBQlMsXG4gICAgICBxdWVyeSxcbiAgICAgIGV4Y2x1ZGVQaW5uZWQsXG4gICAgfSkpIGFzIENvbnNvbGVSZXF1ZXN0VGFic1Jlc3BvbnNlO1xuICAgIHJldHVybiByZXNwO1xuICB9XG5cbiAgYXN5bmMgZ2V0UHJvcGVydGllcygpOiBQcm9taXNlPFByb3BlcnR5W10+IHtcbiAgICBjb25zdCByZXNwID0gKGF3YWl0IGJyb3dzZXIucnVudGltZS5zZW5kTWVzc2FnZSh7XG4gICAgICB0eXBlOiBtZXNzYWdlcy5DT05TT0xFX0dFVF9QUk9QRVJUSUVTLFxuICAgIH0pKSBhcyBDb25zb2xlR2V0UHJvcGVydGllc1Jlc3BvbnNlO1xuICAgIHJldHVybiByZXNwO1xuICB9XG59XG4iLCJpbXBvcnQgQ29tbWFuZFBhcnNlciBmcm9tIFwiLi9Db21tYW5kUGFyc2VyXCI7XG5pbXBvcnQgeyBDb21tYW5kIH0gZnJvbSBcIi4uLy4uL3NoYXJlZC9Db21tYW5kXCI7XG5cbmV4cG9ydCB0eXBlIENvbW1hbmRMaW5lID0ge1xuICByZWFkb25seSBjb21tYW5kOiBDb21tYW5kO1xuICByZWFkb25seSBhcmdzOiBzdHJpbmc7XG59O1xuXG5leHBvcnQgZW51bSBJbnB1dFBoYXNlIHtcbiAgT25Db21tYW5kLFxuICBPbkFyZ3MsXG59XG5cbmV4cG9ydCBkZWZhdWx0IGNsYXNzIENvbW1hbmRMaW5lUGFyc2VyIHtcbiAgcHJpdmF0ZSBjb21tYW5kUGFyc2VyOiBDb21tYW5kUGFyc2VyID0gbmV3IENvbW1hbmRQYXJzZXIoKTtcblxuICBpbnB1dFBoYXNlKGxpbmU6IHN0cmluZyk6IElucHV0UGhhc2Uge1xuICAgIGxpbmUgPSBsaW5lLnRyaW1MZWZ0KCk7XG4gICAgaWYgKGxpbmUubGVuZ3RoID09IDApIHtcbiAgICAgIHJldHVybiBJbnB1dFBoYXNlLk9uQ29tbWFuZDtcbiAgICB9XG4gICAgY29uc3QgY29tbWFuZCA9IGxpbmUuc3BsaXQoL1xccysvLCAxKVswXTtcbiAgICBpZiAobGluZS5sZW5ndGggPT0gY29tbWFuZC5sZW5ndGgpIHtcbiAgICAgIHJldHVybiBJbnB1dFBoYXNlLk9uQ29tbWFuZDtcbiAgICB9XG4gICAgcmV0dXJuIElucHV0UGhhc2UuT25BcmdzO1xuICB9XG5cbiAgcGFyc2UobGluZTogc3RyaW5nKTogQ29tbWFuZExpbmUge1xuICAgIGNvbnN0IHRyaW1MZWZ0ID0gbGluZS50cmltTGVmdCgpO1xuICAgIGNvbnN0IGNvbW1hbmQgPSB0cmltTGVmdC5zcGxpdCgvXFxzKy8sIDEpWzBdO1xuICAgIGNvbnN0IGFyZ3MgPSB0cmltTGVmdC5zbGljZShjb21tYW5kLmxlbmd0aCkudHJpbUxlZnQoKTtcbiAgICByZXR1cm4ge1xuICAgICAgY29tbWFuZDogdGhpcy5jb21tYW5kUGFyc2VyLnBhcnNlKGNvbW1hbmQpLFxuICAgICAgYXJnczogYXJncyxcbiAgICB9O1xuICB9XG59XG4iLCJpbXBvcnQgcmVkdWNlciwgeyBkZWZhdWx0U3RhdGUgfSBmcm9tIFwiLi9yZWR1Y2VyXCI7XG5pbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgeyBDb21wbGV0aW9uRGlzcGF0Y2hDb250ZXh0LCBDb21wbGV0aW9uU3RhdGVDb250ZXh0IH0gZnJvbSBcIi4vY29udGV4dFwiO1xuXG5pbnRlcmZhY2UgUHJvcHMge1xuICBpbml0aWFsSW5wdXRWYWx1ZTogc3RyaW5nO1xufVxuXG5leHBvcnQgY29uc3QgQ29tcGxldGlvblByb3ZpZGVyOiBSZWFjdC5GQzxQcm9wcz4gPSAoe1xuICBpbml0aWFsSW5wdXRWYWx1ZSxcbiAgY2hpbGRyZW4sXG59KSA9PiB7XG4gIGNvbnN0IGluaXRpYWxTdGF0ZSA9IHtcbiAgICAuLi5kZWZhdWx0U3RhdGUsXG4gICAgY29tcGxldGlvblNvdXJjZTogaW5pdGlhbElucHV0VmFsdWUsXG4gIH07XG4gIGNvbnN0IFtzdGF0ZSwgZGlzcGF0Y2hdID0gUmVhY3QudXNlUmVkdWNlcihyZWR1Y2VyLCBpbml0aWFsU3RhdGUpO1xuICByZXR1cm4gKFxuICAgIDxDb21wbGV0aW9uU3RhdGVDb250ZXh0LlByb3ZpZGVyIHZhbHVlPXtzdGF0ZX0+XG4gICAgICA8Q29tcGxldGlvbkRpc3BhdGNoQ29udGV4dC5Qcm92aWRlciB2YWx1ZT17ZGlzcGF0Y2h9PlxuICAgICAgICB7Y2hpbGRyZW59XG4gICAgICA8L0NvbXBsZXRpb25EaXNwYXRjaENvbnRleHQuUHJvdmlkZXI+XG4gICAgPC9Db21wbGV0aW9uU3RhdGVDb250ZXh0LlByb3ZpZGVyPlxuICApO1xufTtcbiIsImltcG9ydCBSZWFjdCBmcm9tIFwicmVhY3RcIjtcbmltcG9ydCBzdHlsZWQgZnJvbSBcIi4uL2NvbG9yc2NoZW1lL3N0eWxlZFwiO1xuXG5jb25zdCBXcmFwcGVyID0gc3R5bGVkLnBgXG4gIGJvcmRlci10b3A6IDFweCBzb2xpZCBncmF5O1xuICBiYWNrZ3JvdW5kLWNvbG9yOiAkeyh7IHRoZW1lIH0pID0+IHRoZW1lLmNvbnNvbGVJbmZvQmFja2dyb3VuZH07XG4gIGNvbG9yOiAkeyh7IHRoZW1lIH0pID0+IHRoZW1lLmNvbnNvbGVJbmZvRm9yZWdyb3VuZH07XG4gIGZvbnQtd2VpZ2h0OiBub3JtYWw7XG5gO1xuXG5jb25zdCBJbmZvTWVzc2FnZTogUmVhY3QuRkMgPSAoeyBjaGlsZHJlbiB9KSA9PiB7XG4gIHJldHVybiA8V3JhcHBlciByb2xlPVwic3RhdHVzXCI+e2NoaWxkcmVufTwvV3JhcHBlcj47XG59O1xuXG5leHBvcnQgZGVmYXVsdCBJbmZvTWVzc2FnZTtcbiIsImltcG9ydCBSZWFjdCBmcm9tIFwicmVhY3RcIjtcbmltcG9ydCBzdHlsZWQgZnJvbSBcIi4uL2NvbG9yc2NoZW1lL3N0eWxlZFwiO1xuXG5jb25zdCBXcmFwcGVyID0gc3R5bGVkLnBgXG4gIGJvcmRlci10b3A6IDFweCBzb2xpZCBncmF5O1xuICBiYWNrZ3JvdW5kLWNvbG9yOiAkeyh7IHRoZW1lIH0pID0+IHRoZW1lLmNvbnNvbGVFcnJvckJhY2tncm91bmR9O1xuICBjb2xvcjogJHsoeyB0aGVtZSB9KSA9PiB0aGVtZS5jb25zb2xlRXJyb3JGb3JlZ3JvdW5kfTtcbiAgZm9udC13ZWlnaHQ6IGJvbGQ7XG5gO1xuXG5jb25zdCBFcnJvck1lc3NhZ2U6IFJlYWN0LkZDID0gKHsgY2hpbGRyZW4gfSkgPT4ge1xuICByZXR1cm4gPFdyYXBwZXIgcm9sZT1cImFsZXJ0XCI+e2NoaWxkcmVufTwvV3JhcHBlcj47XG59O1xuXG5leHBvcnQgZGVmYXVsdCBFcnJvck1lc3NhZ2U7XG4iLCJpbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgeyBDb2xvclNjaGVtZVVwZGF0ZUNvbnRleHQgfSBmcm9tIFwiLi9jb250ZXh0c1wiO1xuaW1wb3J0IFNldHRpbmdDbGllbnQgZnJvbSBcIi4uL2NsaWVudHMvU2V0dGluZ0NsaWVudFwiO1xuXG5leHBvcnQgY29uc3QgdXNlQ29sb3JTY2hlbWVSZWZyZXNoID0gKCkgPT4ge1xuICBjb25zdCB1cGRhdGUgPSBSZWFjdC51c2VDb250ZXh0KENvbG9yU2NoZW1lVXBkYXRlQ29udGV4dCk7XG4gIGNvbnN0IHNldHRpbmdDbGllbnQgPSBuZXcgU2V0dGluZ0NsaWVudCgpO1xuICBjb25zdCByZWZyZXNoID0gUmVhY3QudXNlQ2FsbGJhY2soKCkgPT4ge1xuICAgIHNldHRpbmdDbGllbnQuZ2V0Q29sb3JTY2hlbWUoKS50aGVuKChuZXdTY2hlbWUpID0+IHtcbiAgICAgIHVwZGF0ZShuZXdTY2hlbWUpO1xuICAgIH0pO1xuICB9LCBbXSk7XG5cbiAgcmV0dXJuIHJlZnJlc2g7XG59O1xuIiwiaW1wb3J0IFNldHRpbmdzIGZyb20gXCIuLi8uLi9zaGFyZWQvc2V0dGluZ3MvU2V0dGluZ3NcIjtcbmltcG9ydCAqIGFzIG1lc3NhZ2VzIGZyb20gXCIuLi8uLi9zaGFyZWQvbWVzc2FnZXNcIjtcbmltcG9ydCBDb2xvclNjaGVtZSBmcm9tIFwiLi4vLi4vc2hhcmVkL0NvbG9yU2NoZW1lXCI7XG5cbmV4cG9ydCBkZWZhdWx0IGNsYXNzIFNldHRpbmdDbGllbnQge1xuICBhc3luYyBnZXRDb2xvclNjaGVtZSgpOiBQcm9taXNlPENvbG9yU2NoZW1lPiB7XG4gICAgY29uc3QganNvbiA9IGF3YWl0IGJyb3dzZXIucnVudGltZS5zZW5kTWVzc2FnZSh7XG4gICAgICB0eXBlOiBtZXNzYWdlcy5TRVRUSU5HU19RVUVSWSxcbiAgICB9KTtcbiAgICBjb25zdCBzZXR0aW5ncyA9IFNldHRpbmdzLmZyb21KU09OKGpzb24pO1xuICAgIHJldHVybiBzZXR0aW5ncy5wcm9wZXJ0aWVzLmNvbG9yc2NoZW1lO1xuICB9XG59XG4iLCJpbXBvcnQgYXBpIGZyb20gXCIhLi4vLi4vbm9kZV9tb2R1bGVzL3N0eWxlLWxvYWRlci9kaXN0L3J1bnRpbWUvaW5qZWN0U3R5bGVzSW50b1N0eWxlVGFnLmpzXCI7XG4gICAgICAgICAgICBpbXBvcnQgY29udGVudCBmcm9tIFwiISEuLi8uLi9ub2RlX21vZHVsZXMvY3NzLWxvYWRlci9kaXN0L2Nqcy5qcyEuL2luZGV4LmNzc1wiO1xuXG52YXIgb3B0aW9ucyA9IHt9O1xuXG5vcHRpb25zLmluc2VydCA9IFwiaGVhZFwiO1xub3B0aW9ucy5zaW5nbGV0b24gPSBmYWxzZTtcblxudmFyIHVwZGF0ZSA9IGFwaShjb250ZW50LCBvcHRpb25zKTtcblxuXG5cbmV4cG9ydCBkZWZhdWx0IGNvbnRlbnQubG9jYWxzIHx8IHt9OyIsImltcG9ydCBSZWFjdCBmcm9tIFwicmVhY3RcIjtcbmltcG9ydCBDb2xvclNjaGVtZSBmcm9tIFwiLi4vLi4vc2hhcmVkL0NvbG9yU2NoZW1lXCI7XG5pbXBvcnQgeyBEYXJrVGhlbWUsIExpZ2h0VGhlbWUgfSBmcm9tIFwiLi90aGVtZVwiO1xuaW1wb3J0IHsgQ29sb3JTY2hlbWVDb250ZXh0LCBDb2xvclNjaGVtZVVwZGF0ZUNvbnRleHQgfSBmcm9tIFwiLi9jb250ZXh0c1wiO1xuaW1wb3J0IHsgVGhlbWVQcm92aWRlciB9IGZyb20gXCJzdHlsZWQtY29tcG9uZW50c1wiO1xuXG5leHBvcnQgY29uc3QgQ29sb3JTY2hlbWVQcm92aWRlcjogUmVhY3QuRkMgPSAoeyBjaGlsZHJlbiB9KSA9PiB7XG4gIGNvbnN0IFtjb2xvcnNjaGVtZSwgc2V0Q29sb3JTY2hlbWVdID0gUmVhY3QudXNlU3RhdGUoQ29sb3JTY2hlbWUuU3lzdGVtKTtcbiAgY29uc3QgdGhlbWUgPSBSZWFjdC51c2VNZW1vKCgpID0+IHtcbiAgICBpZiAoY29sb3JzY2hlbWUgPT09IENvbG9yU2NoZW1lLlN5c3RlbSkge1xuICAgICAgaWYgKFxuICAgICAgICB3aW5kb3cubWF0Y2hNZWRpYSAmJlxuICAgICAgICB3aW5kb3cubWF0Y2hNZWRpYShcIihwcmVmZXJzLWNvbG9yLXNjaGVtZTogZGFyaylcIikubWF0Y2hlc1xuICAgICAgKSB7XG4gICAgICAgIHJldHVybiBEYXJrVGhlbWU7XG4gICAgICB9XG4gICAgfSBlbHNlIGlmIChjb2xvcnNjaGVtZSA9PT0gQ29sb3JTY2hlbWUuRGFyaykge1xuICAgICAgcmV0dXJuIERhcmtUaGVtZTtcbiAgICB9XG4gICAgcmV0dXJuIExpZ2h0VGhlbWU7XG4gIH0sIFtjb2xvcnNjaGVtZV0pO1xuXG4gIHJldHVybiAoXG4gICAgPENvbG9yU2NoZW1lQ29udGV4dC5Qcm92aWRlciB2YWx1ZT17Y29sb3JzY2hlbWV9PlxuICAgICAgPENvbG9yU2NoZW1lVXBkYXRlQ29udGV4dC5Qcm92aWRlciB2YWx1ZT17c2V0Q29sb3JTY2hlbWV9PlxuICAgICAgICA8VGhlbWVQcm92aWRlciB0aGVtZT17dGhlbWV9PntjaGlsZHJlbn08L1RoZW1lUHJvdmlkZXI+XG4gICAgICA8L0NvbG9yU2NoZW1lVXBkYXRlQ29udGV4dC5Qcm92aWRlcj5cbiAgICA8L0NvbG9yU2NoZW1lQ29udGV4dC5Qcm92aWRlcj5cbiAgKTtcbn07XG5leHBvcnQgZGVmYXVsdCBDb2xvclNjaGVtZVByb3ZpZGVyO1xuIiwiZXhwb3J0IHR5cGUgVGhlbWVQcm9wZXJ0aWVzID0ge1xuICBjb21wbGV0aW9uVGl0bGVCYWNrZ3JvdW5kOiBzdHJpbmc7XG4gIGNvbXBsZXRpb25UaXRsZUZvcmVncm91bmQ6IHN0cmluZztcbiAgY29tcGxldGlvbkl0ZW1CYWNrZ3JvdW5kOiBzdHJpbmc7XG4gIGNvbXBsZXRpb25JdGVtRm9yZWdyb3VuZDogc3RyaW5nO1xuICBjb21wbGV0aW9uSXRlbURlc2NyaXB0aW9uRm9yZWdyb3VuZDogc3RyaW5nO1xuICBjb21wbGV0aW9uU2VsZWN0ZWRCYWNrZ3JvdW5kOiBzdHJpbmc7XG4gIGNvbXBsZXRpb25TZWxlY3RlZEZvcmVncm91bmQ6IHN0cmluZztcbiAgY29tbWFuZEJhY2tncm91bmQ6IHN0cmluZztcbiAgY29tbWFuZEZvcmVncm91bmQ6IHN0cmluZztcbiAgY29uc29sZUVycm9yQmFja2dyb3VuZDogc3RyaW5nO1xuICBjb25zb2xlRXJyb3JGb3JlZ3JvdW5kOiBzdHJpbmc7XG4gIGNvbnNvbGVJbmZvQmFja2dyb3VuZDogc3RyaW5nO1xuICBjb25zb2xlSW5mb0ZvcmVncm91bmQ6IHN0cmluZztcbn07XG5cbmV4cG9ydCBjb25zdCBMaWdodFRoZW1lOiBUaGVtZVByb3BlcnRpZXMgPSB7XG4gIGNvbXBsZXRpb25UaXRsZUJhY2tncm91bmQ6IFwibGlnaHRncmF5XCIsXG4gIGNvbXBsZXRpb25UaXRsZUZvcmVncm91bmQ6IFwiIzAwMDAwMFwiLFxuICBjb21wbGV0aW9uSXRlbUJhY2tncm91bmQ6IFwiI2ZmZmZmZlwiLFxuICBjb21wbGV0aW9uSXRlbUZvcmVncm91bmQ6IFwiIzAwMDAwMFwiLFxuICBjb21wbGV0aW9uSXRlbURlc2NyaXB0aW9uRm9yZWdyb3VuZDogXCIjMDA4MDAwXCIsXG4gIGNvbXBsZXRpb25TZWxlY3RlZEJhY2tncm91bmQ6IFwiI2ZmZmYwMFwiLFxuICBjb21wbGV0aW9uU2VsZWN0ZWRGb3JlZ3JvdW5kOiBcIiMwMDAwMDBcIixcbiAgY29tbWFuZEJhY2tncm91bmQ6IFwiI2ZmZmZmZlwiLFxuICBjb21tYW5kRm9yZWdyb3VuZDogXCIjMDAwMDAwXCIsXG4gIGNvbnNvbGVFcnJvckJhY2tncm91bmQ6IFwiI2ZmMDAwMFwiLFxuICBjb25zb2xlRXJyb3JGb3JlZ3JvdW5kOiBcIiNmZmZmZmZcIixcbiAgY29uc29sZUluZm9CYWNrZ3JvdW5kOiBcIiNmZmZmZmZcIixcbiAgY29uc29sZUluZm9Gb3JlZ3JvdW5kOiBcIiMwMTg3ODZcIixcbn07XG5cbmV4cG9ydCBjb25zdCBEYXJrVGhlbWU6IFRoZW1lUHJvcGVydGllcyA9IHtcbiAgY29tcGxldGlvblRpdGxlQmFja2dyb3VuZDogXCIjMDUyMDI3XCIsXG4gIGNvbXBsZXRpb25UaXRsZUZvcmVncm91bmQ6IFwid2hpdGVcIixcbiAgY29tcGxldGlvbkl0ZW1CYWNrZ3JvdW5kOiBcIiMyZjQ3NGZcIixcbiAgY29tcGxldGlvbkl0ZW1Gb3JlZ3JvdW5kOiBcIndoaXRlXCIsXG4gIGNvbXBsZXRpb25JdGVtRGVzY3JpcHRpb25Gb3JlZ3JvdW5kOiBcIiM4NmZhYjBcIixcbiAgY29tcGxldGlvblNlbGVjdGVkQmFja2dyb3VuZDogXCIjZWVmZjQxXCIsXG4gIGNvbXBsZXRpb25TZWxlY3RlZEZvcmVncm91bmQ6IFwiIzAwMDAwMFwiLFxuICBjb21tYW5kQmFja2dyb3VuZDogXCIjMDUyMDI3XCIsXG4gIGNvbW1hbmRGb3JlZ3JvdW5kOiBcIndoaXRlXCIsXG4gIGNvbnNvbGVFcnJvckJhY2tncm91bmQ6IFwicmVkXCIsXG4gIGNvbnNvbGVFcnJvckZvcmVncm91bmQ6IFwid2hpdGVcIixcbiAgY29uc29sZUluZm9CYWNrZ3JvdW5kOiBcIiMwNTIwMjdcIixcbiAgY29uc29sZUluZm9Gb3JlZ3JvdW5kOiBcIiNmZmZmZmZcIixcbn07XG4iLCJpbXBvcnQgUmVhY3QgZnJvbSBcInJlYWN0XCI7XG5pbXBvcnQgcmVkdWNlciwgeyBkZWZhdWx0U3RhdGUgfSBmcm9tIFwiLi9yZWN1ZXJcIjtcbmltcG9ydCB7IEFwcERpc3BhdGNoQ29udGV4dCwgQXBwU3RhdGVDb250ZXh0IH0gZnJvbSBcIi4vY29udGV4dHNcIjtcblxuZXhwb3J0IGNvbnN0IEFwcFByb3ZpZGVyOiBSZWFjdC5GQyA9ICh7IGNoaWxkcmVuIH0pID0+IHtcbiAgY29uc3QgW3N0YXRlLCBkaXNwYXRjaF0gPSBSZWFjdC51c2VSZWR1Y2VyKHJlZHVjZXIsIGRlZmF1bHRTdGF0ZSk7XG4gIHJldHVybiAoXG4gICAgPEFwcFN0YXRlQ29udGV4dC5Qcm92aWRlciB2YWx1ZT17c3RhdGV9PlxuICAgICAgPEFwcERpc3BhdGNoQ29udGV4dC5Qcm92aWRlciB2YWx1ZT17ZGlzcGF0Y2h9PlxuICAgICAgICB7Y2hpbGRyZW59XG4gICAgICA8L0FwcERpc3BhdGNoQ29udGV4dC5Qcm92aWRlcj5cbiAgICA8L0FwcFN0YXRlQ29udGV4dC5Qcm92aWRlcj5cbiAgKTtcbn07XG4iXSwic291cmNlUm9vdCI6IiJ9