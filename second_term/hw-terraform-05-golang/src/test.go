package devby3

import "testing"

func TestEevn(t *testing.T) {
    var v float64
    v = main([]float64{1,2})
    if v != 1.5 {
        t.Error("Expected 1.5, got ", v)
    }
}

