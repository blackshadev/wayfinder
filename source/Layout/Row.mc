import Toybox.Lang;
import Toybox.Graphics;

module Layout {
    class Row extends RelativeComponent {
        private var components as Array<RelativeComponent>;
        private var _height as Number? = null;

        function initialize(components as Array<RelativeComponent>) {
            RelativeComponent.initialize();

            self.components = components;
        }

        function layout(dc as Dc) as Void {
            for (var i = 0; i < self.components.size(); i++) {
                self.components[i].layout(dc);
            }
        }

        function draw(dc as Dc) as Void {
            for (var i = 0; i < self.components.size(); i++) {
                self.components[i].draw(dc);
            }
        }

        public function setOffset(offset as Graphics.Point2D) as Void {
            RelativeComponent.setOffset(offset);

            var height = self.height();

            for (var i = 0; i < self.components.size(); i++) {
                var alignment = 0;
                var curHeight = self.components[i].height();

                // center components which are not the same height as the largest in the row
                if (height != curHeight) {
                    alignment = (height - curHeight) / 2  + curHeight / 4;
                }

                self.components[i].setOffset([
                    self.components[i].offset()[0],
                    offset[1] + alignment
                ] as Graphics.Point2D);
            }
        }

        public function height() as Number {
            if (self._height != null) {
                return self._height;
            }

            var h = 0;
            for (var i = 0; i < self.components.size(); i++) {
                h = Utils.max(h, self.components[i].height());
            }

            self._height = h;
            return self._height;
        }
    }
}