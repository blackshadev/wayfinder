import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;


typedef ArrowOptions as {
    :size as Number,
    :color as ColorType
};

class Arrow extends Component {
    private var _size as Number;
    private var _color as ColorType;

    private var _radius as Number = 0;
    private var _angle as Number? = null;
    private var _center as Graphics.Point2D = [0, 0];
    private var _basePoints as Array<Graphics.Point2D> = [[0.0, 0.0], [0.0, 0.0], [0.0, 0.0]];

    private var _halfHeight as Float;
    private var _halfSize as Float;

    private var _points as Array<Graphics.Point2D> = [[0.0, 0.0], [0.0, 0.0], [0.0, 0.0]];

    function initialize(options as ArrowOptions) {
        Component.initialize();

        self._size = options[:size];
        self._color = options[:color];

        self._halfSize = self._size / 2.0;
        self._halfHeight = self._size * Math.sqrt(3) / 4.0;
    }

    function layout(dc as Dc) as Void {
        var w = dc.getWidth();
        var h = dc.getHeight();

        self._center = [w / 2, h / 2];
        self._radius = w / 2 - self._size;

        self._basePoints = [
            [0.0, -self._halfHeight],              // Top vertex (points perfectly north)
            [-self._halfSize, self._halfHeight],  // Bottom-left vertex
            [self._halfSize, self._halfHeight]    // Bottom-right vertex
        ];
    }

    function draw(dc as Dc) as Void {
        if (self._angle == null) {
            return;
        }

        dc.setColor(self._color, Graphics.COLOR_TRANSPARENT);
        dc.fillPolygon(self._points);
    }

    private function getPoints() as Array<Graphics.Point2D> {
        // Triangle's center point on the circular path
        var correctedAngleInRads = Math.toRadians(_angle - 90);
        var triangleCenter = [
            self._center[0] + self._radius * Math.cos(correctedAngleInRads),
            self._center[1] + self._radius * Math.sin(correctedAngleInRads)
        ];

        var points = [
            self._basePoints[0],
            self._basePoints[1],
            self._basePoints[2],
        ];

        var angleInRads = Math.toRadians(_angle);
        // Rotate and translate the triangle vertices
        for (var i = 0; i < points.size(); i++) {
            var x = points[i][0];
            var y = points[i][1];

            // Apply the rotation matrix
            var rotatedX = x * Math.cos(angleInRads) - y * Math.sin(angleInRads);
            var rotatedY = x * Math.sin(angleInRads) + y * Math.cos(angleInRads);

            // Translate the rotated point to the triangle center
            points[i] = [
                rotatedX + triangleCenter[0],
                rotatedY + triangleCenter[1]
            ];
        }

        return points;
    }

    function setAngle(angle as Number?) as Void {
        self._angle = angle;

        if (angle == null) {
            return;
        }

        self._points = getPoints();
    }
}