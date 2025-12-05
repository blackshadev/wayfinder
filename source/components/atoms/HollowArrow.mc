import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class HollowArrow extends AbstractArrow {
    private var _strokeWidth as Number;

    function initialize(options as ArrowOptions) {
        AbstractArrow.initialize(options);

        self._strokeWidth = Utils.Math.max(Math.round(self._size / 20.0), 1.0);
    }

    function draw(dc as Dc) as Void {
        if (self._angle == null) {
            return;
        }

        dc.setColor(self._color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(self._strokeWidth);

        var points = self.getPoints();
        for (var i = 0; i < points.size(); i++) {
            var j = (i + 1) % points.size();
            dc.drawLine(points[i][0], points[i][1], points[j][0], points[j][1]);
        }
    }
}