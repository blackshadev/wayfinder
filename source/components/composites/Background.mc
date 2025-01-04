import Toybox.Graphics;
import Toybox.Lang;

class QuarterBackground extends Component {
    
    private var lines as Array<Line> = [];

    function initialize() {
        Component.initialize();
        
        self.lines = [
            new Line([0.0, 0.5, 1.0, 0.5], [0, 20, 0, 20]),
            new Line([0.5, 0.0, 0.5, 1.0], [20, 0, 20, 0])
        ];
    }

    function layout(dc as Dc) as Void {
        self.lines[0].layout(dc);
        self.lines[1].layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.lines[0].draw(dc);
        self.lines[1].draw(dc);
    }
}