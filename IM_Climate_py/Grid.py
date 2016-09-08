import numpy as np
import os

class Grid(np.ndarray):
    def __new__(cls, grid, *args, **kwargs):
        obj = np.asarray(grid).view(cls)
        return obj

    def __init__(self, grid, XLLCenter, YLLCenter, cellSize, missingValue, projection):
        self.nrows = len(self)
        self.ncols = len(self[0])
        self.XLLCenter = XLLCenter # X dimension lower left center
        self.YLLCenter = YLLCenter # Y dimension lower left center
        self.cellSize = cellSize
        self.missingValue = missingValue
        self.projection = projection

    def export(self, filePathAndName):
        '''
        Export grid to ASCII grid format along with PRJ file
        '''
        outfile = open(filePathAndName,'w')
        outfile.write ('NCOLS ' + str(self.ncols) + '\n')
        outfile.write ('NROWS ' + str(self.nrows) + '\n')
        outfile.write ('XLLCENTER ' + str(self.XLLCenter) + '\n')
        outfile.write ('YLLCENTER ' + str(self.YLLCenter) + '\n')
        outfile.write ('CELLSIZE ' + str(self.cellSize) + '\n')
        outfile.write ('NODATA_VALUE ' + str(self.missingValue) + '\n')

        for row in reversed(self):
            outfile.write('\n')
            for ob in row:
                outfile.write(str(ob) + '\t')

        outfile.close()

        #Create PRJ
        prjFile = os.path.splitext(filePathAndName)[0] + '.prj'
        outfile = open(prjFile,'w')
        outfile.write(str(self.projection))
        outfile.close()

if __name__ == '__main__':
    grid = [[15, 16, 16,17], [15, 14, 15,20], [13, 15, 15, 19]]
    XLLCenter = -130
    YLLCenter = 40
    cellSize = 4
    missingValue = -999
    g = Grid(grid = grid, XLLCenter = XLLCenter, YLLCenter = YLLCenter
        , cellSize = cellSize, missingValue = missingValue)
    g.export('aaa.asc')
    print g.ncols
    print g.nrows
    print g