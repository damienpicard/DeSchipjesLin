import numpy as np
import re
import pandas as pd; pd.set_option('display.max_rows', 5)
from modelicares import SimRes
from os import remove
import math
from scipy.interpolate import interp1d
import matplotlib.pylab as plt

#sys.path.append('C:\\Users\\u0085306\\Documents\\work\\python\\ModelicaRes')
#from modelicares import SimRes

class LoadData(object):
    """

    """
    def __init__(self,path,varDic):
        self.path = path
        self.varDic = varDic
        self.sim = SimRes(path)
        self.df = self.sim_to_pandas(self.sim, self.varDic)
        self.filterData()

    def printToFile(self, path=None):
        if not path:
            path = self.path.replace('.mat','.txt')

        nrows = len(self.df.index)
        ncol = len(self.df.columns.get_values())

        # colNam = self.df.columns.to_list()
        # colNamSort = [x for x in colNam if not x=='Time']
        # colNamSort.insert('Time',0)
        #
        # self.df = self.df[colNamSort]

        with open(path, "w") as text_file:
            text_file.write("#1: \n")
            text_file.write("double data(%d,%d) # columns names:  %s \n"%(nrows, ncol+1, 'Time ' + str(self.df.columns.get_values())) )
            self.df.to_csv(text_file, header=None, sep='\t', mode='a')





    def sim_to_pandas(self, sim, dic,sort=False):
        '''
        Return a data frame for variable in dic from simulation results.
        ## Arguments
        sim: SimRes object
        dic: dictionary with keys=legend name, values = modelica names.
        sort: true if the dictionary keys should be sorted
        '''

        #Keys
        keys=dic.keys()
        if sort:
            keys.sort(key=self.natural_keys)

        val = [dic[i] for i in keys]

        #Make inverse dictionary for aliases of panda
        dic_inv = dict(zip(val,keys))

        #make pandas data frame
        df = sim.to_pandas(val, aliases=dic_inv)

        #Convert data from data frame to float to make possible to plot with Charts
        df[df.keys()] = df[df.keys()].astype(float)

        #Change name of columns to avoid the units
        keys_strip = [str(k).split(' ')[0] for k in df.keys()]
        df = df.rename(columns=dict(zip(df.keys(),keys_strip)))

        #change index to DatatimeIndex, starting from 1/1/2014
        #df.index = pd.DatetimeIndex([dt.datetime(2014,1,1)+x*pd.offsets.Second() for x in df.index])
        return df

    def filterData(self,removeOutliners=False):
         # Check if equidistant
        t = list(self.df.index[1::]-self.df.index[0:-1])
        samplings = list(set(t))
        if len(samplings)>1:
            # If not equidistant, remove non-equidistant points

            # Return sampling which occurs the most
            listCounts = [ t.count(x) for x in samplings]
            self.sampling = samplings[ listCounts.index( max(listCounts) ) ]
            print '***Warning: Grid is not equidistant. The different samplings time are %s.'%(str(listCounts))
            print 'The sampling %.0f is chosen as it occurs %d times on %d.'%(self.sampling, max(listCounts), sum(listCounts))
            # filter all rows for which sampling is not correct and remove last line
            keep = [x==self.sampling for x in t] + [False]
            self.df = self.df[ keep ]
            self.df.index = np.arange(len(self.df.index))*self.sampling
        else:
            self.sampling=t[1]-t[0]

    def natural_keys(self,text):
        '''
        alist.sort(key=natural_keys) sorts in human order
        http://nedbatchelder.com/blog/200712/human_sorting.html
        (See Toothy's implementation in the comments)
        '''
        return [ self.atoi(c) for c in re.split('(\d+)', text) ]

    def atoi(self,text):
        return int(text) if text.isdigit() else text

if __name__ == "__main__":
    path = "C:/Users/u0085306/Documents/work/modelica/SimulationResults/deSchipjesLin/"
    nameSim = ['PiDControlledOld.mat','PidControlledReno.mat','PiDControlledRenoLight.mat']

    varDic = {}
    nZones = 6
    for i in range(nZones):
        varDic['QFlow[%d]'%(i+1)] = 'prescribedHeat_pid.QFlow[%d]'%(i+1)

    for s in nameSim:
        data = LoadData(path+s, varDic)
        data.printToFile()

