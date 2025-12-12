import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

typedef RadialLineOptions as {
    :stroke as Number,
    :color as ColorType,
    :offset as Number?
};

class RadialLine extends Component {
    protected var _strokeWidth as Number;
    protected var _color as ColorType;
    protected var _offset as Number;
    protected var _angle as Number? = null;
    protected var _points as Array<Graphics.Point2D> = [[0.0, 0.0], [0.0, 0.0], [0.0, 0.0]];

    private var _radius as Number = 0;
    private var _center as Graphics.Point2D = [0, 0];

    function initialize(options as RadialLineOptions) {
        Component.initialize();

        self._strokeWidth = options[:stroke];
        self._color = options[:color];
        self._offset = options[:offset] != null ? options[:offset] : 0;
    }

    function layout(dc as Dc) as Void {
        var w = dc.getWidth();
        var h = dc.getHeight();

        self._center = [w / 2, h / 2];
        self._radius = Utils.Math.max(w / 2, h / 2) - self._offset;
    }

    function draw(dc as Dc) as Void {
        dc.setPenWidth(self._strokeWidth);
        dc.setColor(self._color, Graphics.COLOR_TRANSPARENT);
    
        dc.drawLine(
            self._points[0][0],
            self._points[0][1],
            self._points[1][0],
            self._points[1][1]
        );
    }

    protected function getPoints() as Array<Graphics.Point2D> {
        var correctedAngleInRads = Math.toRadians(_angle - 90);
        var target = [
            self._radius * Math.cos(correctedAngleInRads),
            self._radius * Math.sin(correctedAngleInRads)
        ];
        
        return [
            [self._center[0], self._center[1]],
            [self._center[0] + target[0], self._center[1] + target[1]],
        ];
    }

    function setAngle(angle as Number?) as Void {
        self._angle = angle;

        if (angle == null) {
            return;
        }

        self._points = getPoints();
    }
}