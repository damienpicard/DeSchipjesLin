from loadData import LoadData
import matplotlib.pylab as plt

path = "C:/Users/u0085306/Documents/work/modelica/DeSchipjesLin/Python/Data/"
nameSim = 'validation.mat'

flagSave = True
nameSavedFile = 'linValidation'
format = 'eps'

# Retrieve data for the 3 buildings and save them in different dataframe
nameBui = ['old', 'reno', 'renoLight']
leg = ['Original', 'Renovated', 'Light weight']
listDic = [{},{},{}]
listDf = []
nZones = 6
for j, s in enumerate(nameBui):
    for i in range(nZones):
        listDic[j]['Zone%d'%(i+1)] = '%s.error[%d]'%(s,(i+1))
    listDf.append(LoadData(path+nameSim, listDic[j]).df)

# Make boxplot from dataframes
f, axarr = plt.subplots(1, len(nameBui))
for j , s in enumerate(leg):
    listDf[j].boxplot(ax=axarr[j])
    axarr[j].set_title(s)
    axarr[j].set_ylim(-1,1)
    # rotate xticklables
    for tick in axarr[j].get_xticklabels():
        tick.set_rotation(45)
    if j==0:
        axarr[j].set_ylabel('[K]')

if flagSave:
    f.savefig(nameSavedFile + "." + format,format=format, bbox_inches='tight')

plt.show()