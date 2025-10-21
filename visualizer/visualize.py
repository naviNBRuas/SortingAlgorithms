import json
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np

def visualize(trace_file, output_gif):
    """Generates a GIF visualization of a sorting algorithm from a trace file."""
    with open(trace_file, 'r') as f:
        trace_data = json.load(f)

    arr = trace_data['initial_array']
    trace = trace_data['steps']

    fig, ax = plt.subplots()
    ax.set_title('Bubble Sort')
    bar_rects = ax.bar(range(len(arr)), arr, align='edge')

    def update_fig(step):
        ax.set_title(f"Bubble Sort - {step['type']}")
        for rect in bar_rects:
            rect.set_color('blue')

        if step['type'] == 'compare':
            for i in step['indices']:
                bar_rects[i].set_color('yellow')
        elif step['type'] == 'swap':
            for i in step['indices']:
                bar_rects[i].set_color('red')
            i, j = step['indices']
            arr[i], arr[j] = arr[j], arr[i]
        elif step['type'] == 'shift': # For Insertion Sort
            for i in step['indices']:
                bar_rects[i].set_color('purple')
            arr[step['indices'][0]] = arr[step['indices'][1]]
        elif step['type'] == 'insert': # For Insertion Sort
            for i in step['indices']:
                bar_rects[i].set_color('green')
            # The actual insertion value is not in the trace, so we just highlight
        elif step['type'] == 'merge_write': # For Merge Sort
            idx = step['indices'][0]
            val = step['value']
            arr[idx] = val
            bar_rects[idx].set_color('orange')
        elif step['type'] == 'shuffle': # For Bogo Sort
            arr[:] = step['array_state']
            for i in range(len(arr)):
                bar_rects[i].set_color('blue')

        for rect, h in zip(bar_rects, arr):
            rect.set_height(h)

    anim = animation.FuncAnimation(fig, func=update_fig, frames=trace, repeat=False, interval=50)
    anim.save(output_gif, writer='imagemagick')
    plt.close()

if __name__ == '__main__':
    visualize('trace.json', 'bubble_sort.gif')
