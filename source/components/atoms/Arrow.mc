import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class Arrow extends Component {
    private var size as Number;

    private var radius as Number = 0;
    private var angle as Number? = null;
    private var center as Graphics.Point2D = [0, 0];
    private var basePoints as Array<Graphics.Point2D> = [[0.0, 0.0], [0.0, 0.0], [0.0, 0.0]];

    private var halfHeight as Float;
    private var halfSize as Float;

    private var points as Array<Graphics.Point2D> = [[0.0, 0.0], [0.0, 0.0], [0.0, 0.0]];

    function initialize(size as Number) {
        Component.initialize();

        self.size = size;
        self.radius = radius;

        self.halfSize = size / 2.0;
        self.halfHeight = self.size * Math.sqrt(3) / 4.0;
    }

    function layout(dc as Dc) as Void {
        var w = dc.getWidth();
        var h = dc.getHeight();

        self.center = [w / 2, h / 2];
        self.radius = w / 2 - self.size;

        self.basePoints = [
            [0.0, -self.halfHeight],              // Top vertex (points perfectly north)
            [-self.halfSize, self.halfHeight],  // Bottom-left vertex
            [self.halfSize, self.halfHeight]    // Bottom-right vertex
        ];
    }

    function draw(dc as Dc) as Void {
        if (self.angle == null) {
            return;
        }

        dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.fillPolygon(self.points);
    }

    private function getPoints() as Array<Graphics.Point2D> {
        // Triangle's center point on the circular path
        var correctedAngleInRads = Math.toRadians(angle - 90);
        var triangleCenter = [
            self.center[0] + self.radius * Math.cos(correctedAngleInRads),
            self.center[1] + self.radius * Math.sin(correctedAngleInRads)
        ];

        var points = [
            self.basePoints[0],
            self.basePoints[1],
            self.basePoints[2],
        ];

        var angleInRads = Math.toRadians(angle);
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
        self.angle = angle;

        if (angle == null) {
            return;
        }

        self.points = getPoints();
    }
}