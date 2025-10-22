import argparse
import json
import subprocess
import sys

sys.path.append('.')
from visualizer.visualize import visualize
from src.python.bubble_sort import bubble_sort
from src.python.insertion_sort import insertion_sort
from src.python.selection_sort import selection_sort
from src.python.merge_sort import merge_sort
from src.python.quick_sort import quick_sort
from src.python.bogo_sort import bogo_sort

def main():
    parser = argparse.ArgumentParser(description="Sorting Algorithms Research Suite")
    subparsers = parser.add_subparsers(dest="command")

    # --- Run command ---
    run_parser = subparsers.add_parser("run", help="Run a sorting algorithm")
    run_parser.add_argument("algorithm", help="The algorithm to run", choices=["bubble_sort", "insertion_sort", "selection_sort", "merge_sort", "quick_sort", "bogo_sort", "cocktail_shaker_sort"])
    run_parser.add_argument("--language", choices=["python", "c"], default="python", help="The implementation language")
    run_parser.add_argument("--data", required=True, help="Path to the input data file (JSON list)")
    run_parser.add_argument("--trace", help="Path to save the execution trace (for visualization)")

    # --- Visualize command ---
    visualize_parser = subparsers.add_parser("visualize", help="Generate a visualization from a trace file")
    visualize_parser.add_argument("trace_file", help="Path to the execution trace file")
    visualize_parser.add_argument("--output", default="animation.gif", help="Path to save the output visualization")

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

        if args.language == "python":
            if args.algorithm == "bubble_sort":
                trace = {}
                bubble_sort(data, trace)
                if args.trace:
                    with open(args.trace, 'w') as f:
                        json.dump(trace, f)
            elif args.algorithm == "insertion_sort":
                trace = {}
                insertion_sort(data, trace)
                if args.trace:
                    with open(args.trace, 'w') as f:
                        json.dump(trace, f)
            elif args.algorithm == "selection_sort":
                trace = {}
                selection_sort(data, trace)
                if args.trace:
                    with open(args.trace, 'w') as f:
                        json.dump(trace, f)
            elif args.algorithm == "merge_sort":
                trace = {}
                merge_sort(data, trace)
                if args.trace:
                    with open(args.trace, 'w') as f:
                        json.dump(trace, f)
            elif args.algorithm == "quick_sort":
                trace = {}
                quick_sort(data, trace)
                if args.trace:
                    with open(args.trace, 'w') as f:
                        json.dump(trace, f)
            elif args.algorithm == "bogo_sort":
                trace = {}
                bogo_sort(data, trace)
                if args.trace:
                    with open(args.trace, 'w') as f:
                        json.dump(trace, f)
            else:
                print(f"Algorithm {args.algorithm} not implemented in Python")
        elif args.language == "c":
            if args.algorithm == "bubble_sort":
                import tempfile
                with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_input_file:
                    temp_input_file.write(' '.join(map(str, data)))
                    temp_input_file_path = temp_input_file.name

                try:
                    # Run the C executable
                    result = subprocess.run(["./bubble_sort.out", temp_input_file_path, args.trace], capture_output=True, text=True)
                    if result.returncode != 0:
                        print(f"C executable failed with error: {result.stderr}")
                finally:
                    import os
                    os.remove(temp_input_file_path)
            elif args.algorithm == "insertion_sort":
                import tempfile
                with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_input_file:
                    temp_input_file.write(' '.join(map(str, data)))
                    temp_input_file_path = temp_input_file.name

                try:
                    # Run the C executable
                    result = subprocess.run(["./insertion_sort.out", temp_input_file_path, args.trace], capture_output=True, text=True)
                    if result.returncode != 0:
                        print(f"C executable failed with error: {result.stderr}")
                finally:
                    import os
                    os.remove(temp_input_file_path)
            elif args.algorithm == "selection_sort":
                import tempfile
                with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_input_file:
                    temp_input_file.write(' '.join(map(str, data)))
                    temp_input_file_path = temp_input_file.name

                try:
                    # Run the C executable
                    result = subprocess.run(["./selection_sort.out", temp_input_file_path, args.trace], capture_output=True, text=True)
                    if result.returncode != 0:
                        print(f"C executable failed with error: {result.stderr}")
                finally:
                    import os
                    os.remove(temp_input_file_path)
            elif args.algorithm == "merge_sort":
                import tempfile
                with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_input_file:
                    temp_input_file.write(' '.join(map(str, data)))
                    temp_input_file_path = temp_input_file.name

                try:
                    # Run the C executable
                    result = subprocess.run(["./merge_sort.out", temp_input_file_path, args.trace], capture_output=True, text=True)
                    if result.returncode != 0:
                        print(f"C executable failed with error: {result.stderr}")
                finally:
                    import os
                    os.remove(temp_input_file_path)
            elif args.algorithm == "quick_sort":
                import tempfile
                with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_input_file:
                    temp_input_file.write(' '.join(map(str, data)))
                    temp_input_file_path = temp_input_file.name

                try:
                    # Run the C executable
                    result = subprocess.run(["./quick_sort.out", temp_input_file_path, args.trace], capture_output=True, text=True)
                    if result.returncode != 0:
                        print(f"C executable failed with error: {result.stderr}")
                finally:
                    import os
                    os.remove(temp_input_file_path)
            elif args.algorithm == "bogo_sort":
                import tempfile
                with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_input_file:
                    temp_input_file.write(' '.join(map(str, data)))
                    temp_input_file_path = temp_input_file.name

                try:
                    # Run the C executable
                    result = subprocess.run(["./bogo_sort.out", temp_input_file_path, args.trace], capture_output=True, text=True)
                    if result.returncode != 0:
                        print(f"C executable failed with error: {result.stderr}")
                finally:
                    import os
                    os.remove(temp_input_file_path)
            elif args.algorithm == "cocktail_shaker_sort":
                import tempfile
                with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp_input_file:
                    temp_input_file.write(' '.join(map(str, data)))
                    temp_input_file_path = temp_input_file.name

                try:
                    # Run the C executable
                    result = subprocess.run(["./cocktail_shaker_sort.out", temp_input_file_path, args.trace], capture_output=True, text=True)
                    if result.returncode != 0:
                        print(f"C executable failed with error: {result.stderr}")
                finally:
                    import os
                    os.remove(temp_input_file_path)
            else:
                print(f"Algorithm {args.algorithm} not implemented in C")

    elif args.command == "visualize":
        visualize(args.trace_file, args.output)

    elif args.command == "benchmark":
        print(f"Benchmarking {args.language} implementation of {args.algorithm} with a dataset of size {args.size}")
        # (Implementation to be added)
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
