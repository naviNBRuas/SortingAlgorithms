# Sorting Algorithms Research Suite

This repository contains a comprehensive collection of sorting algorithms, implemented in various languages, along with tools for visualization, benchmarking, and analysis.

## Project Structure

- `algorithms/`: Detailed documentation, proofs, and pseudocode for each algorithm.
- `benchmarking/`: Performance measurement tools and results.
- `data/`: Sample datasets and data generation scripts.
- `docs/`: Academic paper, reports, and other documentation.
- `notebooks/`: Jupyter notebooks for teaching and interactive demos.
- `scripts/`: Build scripts, and other utility scripts.
- `src/`: Source code for the sorting algorithms.
  - `c/`: C implementations.
  - `cpp/`: C++ implementations.
  - `python/`: Python implementations.
  - `rust/`: Rust implementations.
- `tests/`: Test suites for all implementations.
  - `c/`: C tests.
  - `python/`: Python tests.
- `visualizer/`: Tools for creating animations and visualizations of the algorithms.

## Getting Started

## Getting Started

To get started with this project, you'll need to have Python 3, GCC, and Make installed.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/SortingAlgorithms.git
    cd SortingAlgorithms
    ```

2.  **Install Python dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Build the C executables:**
    ```bash
    make
    ```

4.  **Run an algorithm:**
    ```bash
    python main.py run <algorithm_name> --data <path_to_data_file> --trace <path_to_trace_file>
    ```

5.  **Generate a visualization:**
    ```bash
    python main.py visualize <path_to_trace_file> --output <output_gif_path> --algorithm <algorithm_name>
    ```

6.  **Run benchmarks:**
    ```bash
    python main.py benchmark <algorithm_name> --language <python_or_c> --size <dataset_size> --iterations <num_iterations>
    ```

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Make your changes and commit them with a clear and descriptive message.
4.  Push your changes to your fork.
5.  Create a pull request to the main repository.

When contributing, please ensure that you adhere to the existing coding style and that you add or update tests as necessary.

## License

This project is licensed under the MIT License.
