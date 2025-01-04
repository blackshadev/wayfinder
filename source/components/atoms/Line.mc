import Toybox.Graphics;
import Toybox.Lang;

class Line extends Component {
    private var factors as Array<Float> = [1.0, 1.0, 1.0, 1.0];
    private var margins as Array<Number> = [0, 0, 0, 0];
    private var points as Array<Float> = [0.0, 0.0, 0.0, 0.0];

    function initialize(factors as Array<Float>, margins as Array<Number>) {
        Component.initialize();
        
        self.factors = factors;
        self.margins = margins;
    }

    function layout(dc as Dc) as Void {
        var w = dc.getWidth();
        var h = dc.getHeight();
        
        self.points = [
            self.factors[0] * w + self.margins[3], 
            self.factors[1] * h + self.margins[0], 
            self.factors[2] * w - self.margins[1], 
            self.factors[3] * h - self.margins[2]
        ];
    }

    function draw(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_DK_GRAY);
        dc.drawLine(self.points[0], self.points[1], self.points[2], self.points[3]);
    }
}