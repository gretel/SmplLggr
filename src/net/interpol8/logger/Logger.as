/*
 *
 * The MIT License
 *
 * Copyright (c) 2010, Tom Hensel <tom@interpol8.net>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

package net.interpol8.logger
{
    import flash.utils.describeType;

    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.logging.targets.TraceTarget;
    import mx.utils.StringUtil;

    public final class Logger
    {
        internal static var _prefix : String = '';
        internal var _logger : ILogger;
        internal var _mxTarget : TraceTarget;
        internal var _appTarget : TraceTarget;

        public function Logger(prefix : String, logLevelMx : int, logLevelApp : int) : void {
            _prefix = prefix;

            _mxTarget = new TraceTarget();
            _mxTarget.filters = [ 'mx.*' ];
            _mxTarget.level = logLevelMx;
            _mxTarget.includeTime = true;
            _mxTarget.includeCategory = true;
            _mxTarget.includeLevel = true;
            Log.addTarget(_mxTarget);

            _appTarget = new TraceTarget();
            _appTarget.filters = [ prefix + '.*' ];
            _appTarget.level = logLevelApp;
            _appTarget.includeTime = true;
            _appTarget.includeCategory = true;
            _appTarget.includeLevel = true;
            Log.addTarget(_appTarget);
        }

        public static function logSeperator() : void {
            Log.getLogger(_prefix).debug('/------------------------------------------------------------------------------/');
        }

        public static function logExclamation() : void {
            Log.getLogger(_prefix).debug('/******************************************************************************/');
        }

        public static function log(obj : Object, str : String = '*', level : int = 2) : void {
            Log.getLogger(_prefix + '.' + getNamespace(obj)).log(level, str);
        }

        public static function logCompact(obj : Object, str : String, level : int = 2) : void {
            Log.getLogger(_prefix + '.' + getClassName(obj)).log(level, str);
        }

        public static function logSimple(str : String, level : int = 2) : void {
            Log.getLogger(_prefix).log(level, str);
        }

        public static function logger(className : String) : ILogger {
            return Log.getLogger(_prefix + '.' + className);
        }

        internal static function getClassName(obj : Object) : String {
            var xml : XML = describeType(obj);

            return xml.@name.split('::')[1];
        }

        internal static function getNamespace(obj : Object) : String {
            var xml : XML = describeType(obj);

            var category : RegExp = /::/;

            return String(xml.@name).replace(category, '_');
        }

        public static function logf(obj : Object, str : String, ... rest) : void {
            log(obj, StringUtil.substitute(str, rest));
        }
    }
}


