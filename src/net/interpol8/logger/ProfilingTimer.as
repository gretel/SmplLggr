/*
 *
 * The MIT License
 *
 * Copyright (c) 2011, Tom Hensel <tom@interpol8.net>
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
    import flash.utils.getTimer;

    public final class ProfilingTimer
    {
        internal static var _startTime : uint;

        public static function start() : void {
            _startTime = getTimer();
        }

        public static function stop() : uint {
            return elapsed;
        }

        public static function get elapsed() : uint {
            return getTimer() - _startTime;
        }

        public static function measure(operation : Function) : uint {
            start();
            operation();
            stop();
            return elapsed;
        }
    }
}
