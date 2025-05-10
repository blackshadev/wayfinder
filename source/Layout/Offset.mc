import Toybox.Lang;
import Toybox.Graphics;

typedef OffsetOptions as {
    :offset as Graphics.Point2D,
    :size as Graphics.Point2D,
};

module Layout {
    class Offset extends RelativeComponent {
        private var _size as Graphics.Point2D;

        function initialize(opt as OffsetOptions) {
            RelativeComponent.initialize();

            self._offset = opt[:offset];
            self._size = opt[:size];
        }

        function layout(dc as Dc) as Void {}

        function draw(dc as Dc) as Void {}

        public function height() as Number {
            return self._size[1];
        }
    }
}