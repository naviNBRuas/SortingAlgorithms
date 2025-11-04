import argparse
import json
import subprocess
import sys

sys.path.append('.')
from visualizer.visualize import visualize
from src.python.sorting.bubble_sort import bubble_sort
from src.python.sorting.insertion_sort import insertion_sort
from src.python.sorting.selection_sort import selection_sort
from src.python.sorting.merge_sort import merge_sort
from src.python.sorting.quick_sort import quick_sort
from src.python.sorting.bogo_sort import bogo_sort
from src.python.sorting.cocktail_shaker_sort import cocktail_shaker_sort
from src.python.sorting.bucket_sort import bucket_sort
from src.python.sorting.counting_sort import counting_sort
from src.python.sorting.heap_sort import heap_sort
from src.python.sorting.radix_sort import radix_sort
from src.python.sorting.shell_sort import shell_sort
from src.python.sorting.comb_sort import comb_sort
from src.python.sorting.gnome_sort import gnome_sort

PYTHON_ALGORITHMS = {
    "bubble_sort": bubble_sort,
    "insertion_sort": insertion_sort,
    "selection_sort": selection_sort,
    "merge_sort": merge_sort,
    "quick_sort": quick_sort,
    "bogo_sort": bogo_sort,
    "cocktail_shaker_sort": cocktail_shaker_sort,
    "bucket_sort": bucket_sort,
    "counting_sort": counting_sort,
    "heap_sort": heap_sort,
    "radix_sort": radix_sort,
    "shell_sort": shell_sort,
    "comb_sort": comb_sort,
    "gnome_sort": gnome_sort,
}

C_ALGORITHMS = [
    "bubble_sort",
    "insertion_sort",
    "selection_sort",
    "merge_sort",
    "quick_sort",
    "bogo_sort",
    "cocktail_shaker_sort",
    "shell_sort",
    "bucket_sort",
    "radix_sort",
    "counting_sort",
    "heap_sort",
    "comb_sort",
    "gnome_sort",
]

def run_c_algorithm(algorithm, data, trace_path, benchmark=False):
    if algorithm in C_ALGORITHMS:
        import tempfile
        with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_input_file:
            temp_input_file.write(' '.join(map(str, data)))
            temp_input_file_path = temp_input_file.name

        try:
            executable = f"./{algorithm}.out"
            command = [executable, temp_input_file_path]
            if trace_path:
                command.append(trace_path)
            elif benchmark:
                command.append("dummy_trace.json")
            
            result = subprocess.run(command, capture_output=True, text=True)
            if result.returncode != 0:
                print(f"C executable failed with error: {result.stderr}")
        finally:
            import os
            os.remove(temp_input_file_path)
    else:
        print(f"Algorithm {algorithm} not implemented in C")

def run_python_algorithm(algorithm, data, trace_path):
    trace = {}
    sort_function = PYTHON_ALGORITHMS.get(algorithm)
    if sort_function:
        sort_function(data, trace)
        if trace_path:
            with open(trace_path, 'w') as f:
                json.dump(trace, f)
    else:
        print(f"Algorithm {algorithm} not implemented in Python")

def main():
    parser = argparse.ArgumentParser(description="Sorting Algorithms Research Suite")
    subparsers = parser.add_subparsers(dest="command")

    # --- Run command ---
    run_parser = subparsers.add_parser("run", help="Run a sorting algorithm")
    all_algorithms = sorted(list(set(list(PYTHON_ALGORITHMS.keys()) + C_ALGORITHMS)))
    run_parser.add_argument("algorithm", help="The algorithm to run", choices=all_algorithms)
    run_parser.add_argument("--language", choices=["python", "c"], default="python", help="The implementation language")
    run_parser.add_argument("--data", required=True, help="Path to the input data file (JSON list)")
    run_parser.add_argument("--trace", help="Path to save the execution trace (for visualization)")

    # --- Visualize command ---
    visualize_parser = subparsers.add_parser("visualize", help="Generate a visualization from a trace file")
    visualize_parser.add_argument("trace_file", help="Path to the execution trace file")
    visualize_parser.add_argument("--output", default="animation.gif", help="Path to save the output visualization")
    visualize_parser.add_argument("--algorithm", help="The name of the algorithm for the plot title")

    # --- Benchmark command ---
    benchmark_parser = subparsers.add_parser("benchmark", help="Run benchmarks")
    benchmark_parser.add_argument("algorithm", help="The algorithm to benchmark")
    benchmark_parser.add_argument("--language", choices=["python", "c"], default="c", help="The implementation language")
    benchmark_parser.add_argument("--size", type=int, default=1000, help="Size of the random dataset to generate")
    benchmark_parser.add_argument("--iterations", type=int, default=10, help="Number of iterations to run")

    args = parser.parse_args()

    if args.command == "run":
        with open(args.data, 'r') as f:
            data = json.load(f)
            if isinstance(data, dict) and 'initial_array' in data:
                data = data['initial_array']

        if args.language == "python":
            run_python_algorithm(args.algorithm, data, args.trace)
        elif args.language == "c":
            run_c_algorithm(args.algorithm, data, args.trace)

    elif args.command == "visualize":
        visualize(args.trace_file, args.output, args.algorithm)

    elif args.command == "benchmark":
        import time
        import random

        total_time = 0
        for _ in range(args.iterations):
            data = [random.randint(0, 10000) for _ in range(args.size)]
            
            if args.language == "python":
                sort_function = PYTHON_ALGORITHMS.get(args.algorithm)
                if sort_function:
                    start_time = time.time()
                    sort_function(data, None)  # No trace needed for benchmark
                    end_time = time.time()
                    total_time += (end_time - start_time)
                else:
                    print(f"Algorithm {args.algorithm} not implemented in Python")
                    break
            elif args.language == "c":
                start_time = time.time()
                run_c_algorithm(args.algorithm, data, None, benchmark=True)
                end_time = time.time()
                total_time += (end_time - start_time)
        
        if total_time > 0:
            average_time = total_time / args.iterations
            print(f"Average execution time for {args.algorithm} ({args.language}) over {args.iterations} iterations: {average_time:.6f} seconds")

    else:
        parser.print_help()

if __name__ == "__main__":
    main()
