import json
import yaml
import pandas as pd


slices_dir = '/home/kedoxey/OB_Model/OlfactoryBulb/olfactorybulb/slices'

file_names = ['GCs__MCs', 'GCs__TCs']
slice = file_names[1]

with open(f'{slices_dir}/DorsalColumnSlice/{slice}.json','r') as f:
    cells = json.load(f)

df_contents = {'Cell': ['MC1', 'MC2', 'MC3', 'MC4', 'MC5', 
                        'TC1', 'TC2', 'TC3', 'TC4', 'TC5', 
                        'GC1', 'GC2', 'GC3', 'GC4', 'GC5'],
                'Source': [0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0,
                            0, 0, 0, 0, 0],
                'Destination': [0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0]}

syn_df = pd.DataFrame(df_contents)

syn_df = syn_df.set_index('Cell')

for entry in cells['entries']:
    source_cell = entry['source_section'][:3]
    dest_cell = entry['dest_section'][:3]

    source_row = syn_df.loc[source_cell]  # syn_df[syn_df['Cell'] == source_cell]
    dest_row = syn_df.loc[dest_cell]  # syn_df[syn_df['Cell'] == dest_cell]

    syn_df.at[source_cell,'Source'] = source_row.Source + 1
    syn_df.at[dest_cell,'Destination'] = dest_row.Source + 1


syn_df.to_pickle(f'{slices_dir}/{slice}_synapse_counts.pkl', protocol=3)
with open(f'{slices_dir}/{slice}_synapse_counts.yaml', 'w') as outfile:
    yaml.dump(syn_df.to_dict(),outfile)

