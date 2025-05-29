import Toybox.Lang;

class FloatRingBuffer {
    private var lastIndex as Number = -1;
    private var data as Array<Float> = [];
    private var size as Number;

    public function initialize(size as Number) {
        self.size = size;
    }

    public function reset() as Void {
        self.lastIndex = -1;
        self.data = [];
    }

    public function add(value as Float) as Void {
        self.lastIndex = (self.lastIndex + 1) % self.size;

        if (self.lastIndex < self.data.size()) {
            self.data[self.lastIndex] = value;
            return;
        }

        self.data.add(value);
    }

    public function values(indices as Array<Number>) as Array<Float>
    {
        var values = [] as Array<Float>;

        for (var iX = 0; iX < indices.size(); iX++) {
            values.add(self.value(indices[iX]));
        }

        return values;
    }

    public function value(index as Number) as Float {
        var normalizedIndex = (self.lastIndex - index + self.size) % self.size;
        if (normalizedIndex >= self.data.size()) {
            return 0.0;
        }

        return self.data[normalizedIndex];
    }
}