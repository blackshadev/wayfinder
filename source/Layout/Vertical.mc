import Toybox.Lang;
import Toybox.Graphics;

module Layout {
    enum Direction {
        Upwards,
        Downwards,
    }

    class Vertical {
        protected var direction as Direction;
        protected var spacing as Number;

        function initialize(options as { :direction as Direction, :spacing as Number }) {
            self.direction = options[:direction];
            self.spacing = options[:spacing];
        }

        public function apply(components as Array<RelativeComponent>) as Void {

            var previousComponent = self.direction == Downwards ? components[0] : components[components.size() - 1];

            if (self.direction == Upwards) {
                previousComponent.setOffset([
                    previousComponent.offset()[0],
                    previousComponent.offset()[1] - previousComponent.height()
                ]);
            }

            for (var i = 1; i < components.size(); i++) {
                var idx = self.direction == Downwards ? i : components.size() - i - 1;
                var current = components[idx];
                var offset = self.getRelativePosition(current, previousComponent);

                current.setOffset(offset);

                previousComponent = current;
            }
        }

        private function getRelativePosition(current  as RelativeComponent, previous as RelativeComponent) as Graphics.Point2D {
            var size = self.direction == Downwards ? previous.height() : current.height();
            var dir = self.direction == Downwards ? 1 : -1;

            return [
                current.offset()[0],
                previous.offset()[1] + (dir * (size + self.spacing))
            ];
        }
    }
}