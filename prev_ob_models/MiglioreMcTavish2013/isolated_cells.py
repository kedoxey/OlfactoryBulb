from prev_ob_models.utils import RunInClassDirectory, IsolatedCell

class MC(IsolatedCell):
    def __init__(self):
        with RunInClassDirectory(MC):
            from neuron import h,gui

            h.load_file("mitral-lss.hoc")

            self.cell = h.Mitral()
            h.celsius=35

            self.h = h
            self.soma = self.cell.soma

            h.cvode_active(1)

class GC(IsolatedCell):
    def __init__(self):
        with RunInClassDirectory(GC):
            from neuron import h,gui

            h.load_file("gc-ka.hoc")

            self.cell = h.GC()

            h.celsius=35

            self.h = h
            self.soma = self.cell.somagc

            h.cvode_active(1)
