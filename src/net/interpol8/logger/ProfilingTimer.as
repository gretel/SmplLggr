package net.interpol8.logger
{
    import flash.utils.getTimer;

    public final class ProfilingTimer {
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
