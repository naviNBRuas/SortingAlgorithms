| Category | Name | Efficiency | Type | Description | Status |
| ---------------------- | -------------------------------------------- | --------------------------: | ---------------------- | ---------------------------------------------------- | -------- |
| Sorting                | TimSort                                      |                  O(n log n) | Hybrid                 | Adaptive merge sort used in Python/Java.             | Implemented |
| Sorting                | IntroSort                                    |                  O(n log n) | Hybrid                 | QuickSort with fallback to HeapSort.                 | Implemented     |
| Sorting                | Pancake Sort                                 |                       O(n²) | Comparison             | Flipping prefix reversals; puzzle-like.              | Implemented     |
| Sorting                | Strand Sort                                  |                  O(n log n) | Comparison             | Extracts sorted runs iteratively.                    | Implemented     |
| Sorting                | Bitonic Sort                                 |                   O(log² n) | Parallel               | GPU/FPGA-friendly sorting network.                   | Implemented     |
| Sorting                | Batcher Odd-Even Merge                       |                   O(log² n) | Parallel               | Sorting network used in hardware.                    | Missing     |
| Sorting                | FlashSort                                    |                O(n) average | Distribution           | Fast for specific distributions; niche.              | Missing     |
| Sorting                | SmoothSort                                   |                  O(n log n) | Adaptive               | Dijkstra’s adaptive heap-based sort.                 | Missing     |
| Sorting                | American Flag Sort                           |                        O(n) | Distribution           | Radix-like string sorting for bytes.                 | Missing     |
| Sorting                | SpreadSort                                   |                    O(n) avg | Hybrid                 | Radix + comparison hybrid; practical fast.           | Missing     |
| Sorting                | Patience Sorting                             |                  O(n log n) | Greedy/Stacks          | Builds piles; used for LIS.                          | Missing     |
| Sorting                | Cycle Sort                                   |                       O(n²) | Comparison             | Minimizes writes; for write-costly media.            | Missing     |
| Sorting                | Stooge Sort                                  |                 O(n^2.7095) | Recursive              | Comically bad recursive sort.                        | Missing     |
| Searching              | Interpolation Search                         |            O(log log n) avg | Interpolation          | Assumes uniform key distribution.                    |
| Searching              | Hash Lookup                                  |                    O(1) avg | Hashing                | Constant-time expected lookup.                       |
| Searching              | Linear Probing                               |                    O(1) avg | Hashing                | Collision strategy; primary clustering issues.       |
| Searching              | Quadratic Probing                            |                    O(1) avg | Hashing                | Collision resolution with quadratic steps.           |
| Searching              | Double Hashing                               |                    O(1) avg | Hashing                | Two-hash collision resolution.                       |
| Searching              | Trie Search                                  |                        O(m) | Trie                   | Prefix search; strings, dictionaries.                |
| Searching              | Suffix Tree Search                           |                        O(m) | Suffix Structure       | Fast substring queries after O(n) build.             |
| Searching              | Suffix Array + LCP                           |                O(m + log n) | Array/Indexes          | Space-efficient substring searches.                  |
| Searching              | k-d Tree Search                              |                O(log n) avg | Spatial                | Multi-dimensional nearest-neighbor search.           |
| Searching              | R-Tree Search                                |                O(log n) avg | Spatial                | Spatial indexing for rectangles/geo.                 |
| Graphs                 | Bellman-Ford                                 |                       O(VE) | Shortest Path          | Negative edges allowed; detects negative cycles.     |
| Graphs                 | Floyd–Warshall                               |                       O(V³) | All-pairs              | DP for all-pairs shortest paths.                     |
| Graphs                 | Johnson’s Algorithm                          |            O(V² log V + VE) | All-pairs              | Sparse-graph all-pairs shortest path.                |
| Graphs                 | A*                                           |         Heuristic-dependent | Heuristic Search       | Best-first with admissible heuristic.                |
| Graphs                 | Bidirectional Search                         |                  O(b^{d/2}) | Search                 | Search from both ends, reduces branching.            |
| Graphs                 | Kruskal                                      |                  O(E log E) | MST                    | MST via sorted edges + union-find.                   |
| Graphs                 | Prim                                         |              O(E + V log V) | MST                    | Grow MST from a start node.                          |
| Graphs                 | Borůvka                                      |                  O(E log V) | MST                    | Parallelizable MST algorithm.                        |
| Graphs                 | Topological Sort                             |                      O(V+E) | DAG Ordering           | Linear order of DAG (if acyclic).                    |
| Graphs                 | Tarjan SCC                                   |                      O(V+E) | SCC                    | Single-pass strongly connected components.           |
| Graphs                 | Kosaraju                                     |                      O(V+E) | SCC                    | Two-pass SCC detection using reverse graph.          |
| Graphs                 | Ford–Fulkerson                               |                O(E·maxFlow) | Max-Flow               | Augmenting path approach; arbitrary runtime.         |
| Graphs                 | Edmonds–Karp                                 |                      O(VE²) | Max-Flow               | Ford–Fulkerson with BFS (bounded time).              |
| Graphs                 | Dinic                                        |                     O(E·√V) | Max-Flow               | Blocking flow layers; very practical.                |
| Graphs                 | Push–Relabel                                 |                 O(V³) worst | Max-Flow               | Local push operations; fast in practice.             |
| Graphs                 | Minimum Cost Flow (Successive Shortest Path) |                     Depends | Flow/Cost              | Min-cost circulation and assignment problems.        |
| Graphs                 | Chinese Postman                              |                  Polynomial | Graph Traversal        | Shortest closed path visiting every edge.            |
| Graphs                 | Travelling Salesman (Exact)                  |                     O(n·n!) | Combinatorial          | NP-hard; exact via DP or brute force.                |
| Graphs                 | Held–Karp (TSP DP)                           |                   O(n²·2^n) | DP                     | Exact TSP via bitmask DP.                            |
| Graphs                 | Christofides                                 |                  1.5-approx | Approximation          | Metric TSP 3/2-approximation.                        |
| Graphs                 | Kahn’s Algorithm                             |                      O(V+E) | DAG                    | Topological sorting via in-degree.                   |
| Graphs                 | PageRank (power iteration)                   |                   O(E·iter) | Linear Algebra         | Web-rank via stationary distribution.                |
| Graphs                 | Label Propagation                            |                      O(V+E) | Community              | Fast, heuristic community detection.                 |
| Dynamic Programming    | Edit Distance (Levenshtein)                  |                       O(mn) | DP                     | Minimum edits between strings.                       |
| Dynamic Programming    | Longest Increasing Subsequence               |                  O(n log n) | DP+BinarySearch        | Efficient LIS using patience.                        |
| Dynamic Programming    | Unbounded Knapsack                           |                       O(nW) | DP                     | Items unlimited; coin-change variant.                |
| Dynamic Programming    | Matrix Chain Multiplication                  |                       O(n³) | DP                     | Optimal parenthesization order.                      |
| Dynamic Programming    | Viterbi                                      |                   O(n·T·k²) | DP/HMM                 | Most likely state sequence in HMM.                   |
| Dynamic Programming    | CYK Algorithm                                |                       O(n³· | G                      | )                                                    |
| Dynamic Programming    | Baum–Welch                                   |                   Iterative | EM/HMM                 | HMM parameter estimation via EM.                     |
| Optimization           | Gradient Descent (GD)                        |               O(n) per iter | Optimization           | First-order iterative optimization.                  |
| Optimization           | Stochastic Gradient Descent (SGD)            |             O(1) per sample | Optimization           | Scales GD to big data; noisy.                        |
| Optimization           | Newton’s Method                              |              O(n³) per iter | Optimization           | Second-order, fast near optimum.                     |
| Optimization           | Conjugate Gradient                           |              O(n²) per iter | Linear System          | Efficient large linear solves.                       |
| Optimization           | L-BFGS                                       |               O(n) per iter | Quasi-Newton           | Memory-efficient quasi-Newton.                       |
| Optimization           | Simulated Annealing                          |                    Variable | Heuristic              | Probabilistic hill-climb escaping local minima.      |
| Optimization           | Genetic Algorithm                            |                    Variable | Evolutionary           | Population-based evolutionary search.                |
| Optimization           | Particle Swarm Optimization                  |                    Variable | Swarm                  | Population-based velocity-position heuristic.        |
| Optimization           | Ant Colony Optimization                      |                    Variable | Swarm                  | Pheromone-based path optimization.                   |
| Optimization           | Hill Climbing                                |                    Variable | Local Search           | Greedy local improvement.                            |
| Optimization           | Tabu Search                                  |                    Variable | Local Search           | Keeps forbidden moves to avoid cycles.               |
| Optimization           | Branch and Bound                             |           Exponential worst | Exact                  | Prune search tree using bounds.                      |
| Optimization           | Simulated Binary Crossover (GA variant)      |                    Variable | Evolutionary           | GA crossover for continuous variables.               |
| Randomized             | Monte Carlo Integration                      |               Probabilistic | Simulation             | Random sampling for estimates.                       |
| Randomized             | Las Vegas Algorithms                         |             Expected finite | Randomized             | Randomness affects time, not correctness.            |
| Randomized             | Monte Carlo Algorithms                       |               Probabilistic | Randomized             | Randomness affects correctness confidence.           |
| Randomized             | Karger’s Min Cut                             |        O(n² log n) repeated | Randomized             | Global min-cut via random contractions.              |
| Randomized             | Reservoir Sampling                           |                        O(n) | Streaming              | Uniform sampling from stream of unknown size.        |
| Randomized             | Bloom Filter                                 |             O(k) operations | Probabilistic          | Probabilistic set membership with false positives.   |
| Randomized             | Count–Min Sketch                             |             O(1) per update | Streaming              | Approximate frequency counts with limited memory.    |
| Cryptography           | RSA                                          |           O(log^3 n) approx | Public-key             | Integer factorization-based public-key crypto.       |
| Cryptography           | Diffie–Hellman                               |                    O(log n) | Key exchange           | Shared secret via discrete log math.                 |
| Cryptography           | ElGamal                                      |                    O(log n) | Public-key             | Probabilistic encryption over multiplicative groups. |
| Cryptography           | ECC (Elliptic Curve)                         |                    O(log n) | Public-key             | Smaller keys via elliptic curve groups.              |
| Cryptography           | AES                                          |              O(1) per block | Symmetric              | Industry-standard block cipher.                      |
| Cryptography           | ChaCha20                                     |              O(1) per block | Symmetric              | Stream cipher alternative to AES in some contexts.   |
| Cryptography           | RSA-OAEP                                     |                    O(log n) | Hybrid                 | RSA with OAEP padding for security.                  |
| Cryptography           | SHA-2 / SHA-3                                |                        O(n) | Hashing                | Cryptographic hash families.                         |
| Cryptography           | HMAC                                         |                        O(n) | MAC                    | Hash-based message authentication.                   |
| Cryptography           | PBKDF2                                       |                   O(iter·n) | KDF                    | Password-based key derivation.                       |
| Cryptography           | Argon2                                       |              O(memory·time) | KDF                    | Modern memory-hard password hashing.                 |
| Compression            | Huffman Coding                               |                  O(n log n) | Entropy Coding         | Variable-length prefix codes from frequencies.       |
| Compression            | Arithmetic Coding                            |                        O(n) | Entropy Coding         | Near-optimal fractional bit coding.                  |
| Compression            | LZW                                          |                        O(n) | Dictionary             | Lempel–Ziv–Welch dictionary compression.             |
| Compression            | LZ77                                         |                        O(n) | Sliding-window         | Foundational streaming compression.                  |
| Compression            | LZ78                                         |                        O(n) | Dictionary             | Lempel–Ziv dictionary-based compression.             |
| Compression            | DEFLATE                                      |                        O(n) | Hybrid                 | LZ77 + Huffman (gzip, zip).                          |
| Compression            | BWT (Burrows–Wheeler)                        |                        O(n) | Transform              | Permutation enabling run-length/Huffman compress.    |
| Compression            | Run-Length Encoding (RLE)                    |                        O(n) | Simple                 | Collapse repeated symbol runs.                       |
| Compression            | Brotli                                       |                        O(n) | Hybrid                 | Modern web compression (dictionary + Huffman).       |
| Compression            | Zstandard (zstd)                             |                        O(n) | Hybrid                 | Fast, scalable compression algorithm.                |
| Math / Number Theory   | Euclidean GCD                                |             O(log min(a,b)) | Number Theory          | Fast gcd via remainder reductions.                   |
| Math / Number Theory   | Extended Euclidean                           |                    O(log n) | Number Theory          | Computes gcd and Bézout coefficients.                |
| Math / Number Theory   | Fast Fourier Transform                       |                  O(n log n) | Signal/Poly            | Convolution/polynomial transforms.                   |
| Math / Number Theory   | Number Theoretic Transform                   |                  O(n log n) | Modular FFT            | FFT variant mod prime for integers.                  |
| Math / Number Theory   | Karatsuba Multiplication                     |                  O(n^1.585) | Divide & Conquer       | Faster large-integer multiply.                       |
| Math / Number Theory   | Toom–Cook                                    |                  ~O(n^1.46) | Divide & Conquer       | Multi-way split multiplication.                      |
| Math / Number Theory   | Schönhage–Strassen                           |        O(n log n log log n) | FFT Multiply           | Asymptotically fast multiplication.                  |
| Math / Number Theory   | Miller–Rabin                                 |          Probabilistic poly | Primality Test         | Fast probabilistic primality test.                   |
| Math / Number Theory   | AKS Primality                                |                   poly-time | Deterministic          | Deterministic polynomial-time primality test.        |
| Math / Number Theory   | Pollard’s Rho                                |             O(n^{1/2}) heur | Factoring              | Randomized factor detection in practice.             |
| Math / Number Theory   | Tonelli–Shanks                               |                        poly | Modular sqrt           | Compute modular square roots.                        |
| Machine Learning       | k-NN                                         |                O(n·d) query | Instance-based         | Lazy classifier/regressor.                           |
| Machine Learning       | k-Means                                      |                  O(n·k·i·d) | Clustering             | Lloyd’s iterative centroid clustering.               |
| Machine Learning       | DBSCAN                                       |                  O(n·log n) | Density Clustering     | Density-based cluster discovery.                     |
| Machine Learning       | Hierarchical Clustering                      |                       O(n²) | Clustering             | Agglomerative/divisive clustering approaches.        |
| Machine Learning       | PCA                                          |                     O(n·d²) | Dimensionality         | Eigen-decomposition for variance axes.               |
| Machine Learning       | SVM (SMO)                                    |                     Between | Classification         | Max-margin classifier, kernelizable.                 |
| Machine Learning       | Random Forest                                |                O(t·n log n) | Ensemble               | Bagged decision trees for robustness.                |
| Machine Learning       | XGBoost                                      |         O(n·log n) per iter | Gradient Boosting      | Highly optimized gradient-boosted trees.             |
| Machine Learning       | LightGBM                                     |               O(n) per iter | Gradient Boosting      | Optimized for large-scale training.                  |
| Machine Learning       | Neural Networks (SGD)                        |                    variable | Deep Learning          | Universal function approximators.                    |
| Machine Learning       | Convolutional Nets                           |                    variable | Deep Learning          | Spatially-local feature extractors.                  |
| Machine Learning       | Recurrent Nets / LSTM                        |                    variable | Deep Learning          | Sequence modeling with memory.                       |
| Machine Learning       | Transformer                                  |                     O(n²·d) | Attention              | State-of-the-art sequence modeling.                  |
| Machine Learning       | Beam Search                                  |                      O(b·d) | Search                 | Heuristic sequence decoding.                         |
| Machine Learning       | EM Algorithm                                 |                   Iterative | Probabilistic          | Expectation–Maximization for latent variables.       |
| Parallel / Distributed | MapReduce                                    |          O(·) cluster-based | Distributed            | Massive data processing pattern.                     |
| Parallel / Distributed | BSP (Bulk Sync)                              |                        O(·) | Parallel Model         | Synchronous parallel computation model.              |
| Parallel / Distributed | Paxos                                        |               O(·) messages | Consensus              | Fault-tolerant distributed consensus.                |
| Parallel / Distributed | Raft                                         |               O(·) messages | Consensus              | More understandable consensus protocol.              |
| Parallel / Distributed | Two-Phase Commit                             |               O(·) messages | Commit Protocol        | Atomic distributed transaction commit.               |
| Parallel / Distributed | MapReduce Shuffle/Sort                       |                        O(·) | Distributed            | Sorting across cluster phase.                        |
| Data Structures        | Array                                        |                 O(1) access | Primitive              | Contiguous memory, indexed access.                   |
| Data Structures        | Linked List                                  |                 O(1) insert | Linear                 | Dynamic chained nodes.                               |
| Data Structures        | Stack                                        |                        O(1) | ADT                    | LIFO structure.                                      |
| Data Structures        | Queue                                        |                        O(1) | ADT                    | FIFO structure.                                      |
| Data Structures        | Deque                                        |                        O(1) | ADT                    | Double-ended queue.                                  |
| Data Structures        | Hash Table                                   |                    O(1) avg | Hashing                | Key-value expected constant access.                  |
| Data Structures        | Balanced BST (AVL)                           |                    O(log n) | Tree                   | Height-balanced BST.                                 |
| Data Structures        | Red–Black Tree                               |                    O(log n) | Tree                   | Balanced BST with color invariants.                  |
| Data Structures        | B-Tree / B+Tree                              |                    O(log n) | Tree                   | Disk-optimized indexing.                             |
| Data Structures        | Skip List                                    |                O(log n) avg | Probabilistic          | Probabilistic balanced structure.                    |
| Data Structures        | Segment Tree                                 |                    O(log n) | Range Query            | Range query and update structure.                    |
| Data Structures        | Fenwick Tree (BIT)                           |                    O(log n) | Range Query            | Prefix sums and updates.                             |
| Data Structures        | Splay Tree                                   |          O(log n) amortized | Self-adjusting         | Good for locality of reference.                      |
| Data Structures        | Treap                                        |           O(log n) expected | Randomized Tree        | BST with heap priorities.                            |
| Data Structures        | Disjoint Set (Union-Find)                    |              α(n) amortized | DSU                    | Union/find with path compression.                    |
| Data Structures        | Skip Graph                                   |                    O(log n) | P2P                    | Distributed skip-list like structure.                |
| Formal / Language      | Regular Expression Engine (NFA/DFA)          |                      O(n·m) | Automata               | Pattern matching via automata.                       |
| Formal / Language      | LR Parser                                    |                        O(n) | Parsing                | Deterministic bottom-up parsing.                     |
| Formal / Language      | LL Parser                                    |                        O(n) | Parsing                | Predictive top-down parsing.                         |
| Formal / Language      | Earley Parser                                |                 O(n³) worst | Parsing                | General CFG parsing algorithm.                       |
| Quantum                | Shor’s Algorithm                             |                 poly(log n) | Quantum                | Quantum integer factoring.                           |
| Quantum                | Grover’s Algorithm                           |                       O(√n) | Quantum                | Quadratic speedup for unstructured search.           |
| Quantum                | Quantum Fourier Transform                    |                  O(n log n) | Quantum                | Quantum analog of FFT.                               |
| Quantum                | Variational Quantum Eigensolver              |                      Hybrid | Quantum-classical      | NISQ-era variational method.                         |
| Esoteric / Joke        | SleepSort                                    |           O(n) conceptually | Experimental           | Use timers; impractical joke.                        |
| Esoteric / Joke        | Quantum Bogosort                             |        Theoretical infinite | Joke                   | Hypothetical quantum variant.                        |
| Esoteric / Joke        | Brainfuck Sorting                            |              Extremely slow | Esoteric               | Implemented in esoteric language for fun.            |
| Theoretical / Limits   | Halting Problem                              |                 Undecidable | Theory                 | No general algorithm decides halting.                |
| Theoretical / Limits   | Rice’s Theorem                               |                 Undecidable | Theory                 | Non-trivial semantic properties undecidable.         |
| Theoretical / Limits   | PCP Theorem                                  |                  Complexity | Theory                 | Hardness of approximation foundation.                |
| Approximation          | PTAS                                         |         poly(n) for fixed ε | Approximation          | Polynomial-time approx scheme.                       |
| Approximation          | FPTAS                                        |                poly(n, 1/ε) | Approximation          | Fully polynomial-time approx scheme.                 |
| Approximation          | Greedy Approximation (Set Cover)             |                      O(n·m) | Approximation          | Log-factor approx by greedy set cover.               |
| Streaming              | Flajolet–Martin                              |                        O(1) | Cardinality            | Probabilistic distinct count estimator.              |
| Bioinformatics         | Smith–Waterman                               |                       O(mn) | DP                     | Local sequence alignment exact.                      |
| Bioinformatics         | Needleman–Wunsch                             |                       O(mn) | DP                     | Global sequence alignment.                           |
| Bioinformatics         | BLAST (heuristic)                            |              Sublinear heur | Heuristic              | Fast approximate sequence alignment.                 |
| Geometry               | Graham Scan                                  |                  O(n log n) | Computational Geometry | Convex hull in 2D.                                   |
| Geometry               | Andrew Monotone Chain                        |                  O(n log n) | Computational Geometry | Another convex hull algorithm.                       |
| Geometry               | Delaunay Triangulation                       |                  O(n log n) | Triangulation          | Maximizes minimum angle triangles.                   |
| Geometry               | Voronoi Diagram                              |                  O(n log n) | Diagram                | Partition plane by nearest site.                     |
| Misc Algorithms        | Karp–Rabin                                   |           O(n + m) expected | String Search          | Rolling-hash substring search.                       |
| Misc Algorithms        | Suffix Automaton                             |                        O(n) | String/Automata        | Compact automaton for all substrings.                |
| Misc Algorithms        | MinHash                                      |                        O(n) | Sketching              | Locality for Jaccard similarity.                     |
| Misc Algorithms        | SimHash                                      |                        O(n) | Hashing                | Near-duplicate detection via locality.               |
| Misc Algorithms        | Locality Sensitive Hashing (LSH)             |                   Sublinear | Approx NN              | Sublinear approximate nearest neighbors.             |
| Misc Algorithms        | FFT-based convolution                        |                  O(n log n) | Number Theory          | Fast polynomial multiplication using FFT.            |
| Misc Algorithms        | Winograd Minimum Multiplication              |                Less than n³ | Matrix Multiply        | Theoretical matrix multiply speed-ups.               |
| Misc Algorithms        | Strassen’s Algorithm                         |                O(n^{2.807}) | Divide & Conquer       | Sub-cubic matrix multiplication.                     |
| Misc Algorithms        | Coppersmith–Winograd (and variants)          |                ~O(n^{2.37}) | Matrix Multiply        | Asymptotic matrix multiply bounds.                   |
| Misc Algorithms        | Brent’s Algorithm                            |                        O(·) | Root finding           | Root/period detection optimizations.                 |
| Misc Algorithms        | Solovay–Strassen                             |               Probabilistic | Primality              | Probabilistic primality test.                        |
| Misc Algorithms        | Pollard’s p−1                                |                   Heuristic | Factoring              | Factor using smoothness properties.                  |
| Misc Algorithms        | MPQS (Multiple Polynomial Quadratic Sieve)   |             sub-exponential | Factoring              | Practical large-integer factoring.                   |
| Misc Algorithms        | GNFS (General Number Field Sieve)            |                    L_n[1/3] | Factoring              | Asymptotically fastest classical factoring.          |
| Misc Algorithms        | RANSAC                                       |               Probabilistic | Robust Estimation      | Fit model tolerant to outliers.                      |
| Misc Algorithms        | ICP (Iterative Closest Point)                |                   Iterative | Geometry               | Align 3D point clouds.                               |
| Misc Algorithms        | Fast Marching Method                         |                  O(n log n) | PDE/Numeric            | Front propagation on grids.                          |
| Misc Algorithms        | Fast Sweeping Method                         |                        O(n) | PDE/Numeric            | Alternative Eikonal solver.                          |
| Misc Algorithms        | Gilbert–Johnson–Keerthi (GJK)                |                        O(n) | Collision              | Convex shape collision detection.                    |
| Misc Algorithms        | Ukkonen’s Suffix Tree                        |                        O(n) | String                 | Linear-time suffix tree construction.                |
| Misc Algorithms        | Manacher’s Algorithm                         |                        O(n) | String                 | Longest palindromic substring linear-time.           |
| Misc Algorithms        | KMP Automaton                                |                    O(n + m) | String                 | Deterministic automaton for pattern matching.        |
| Misc Algorithms        | FFT Pruning / Bluestein                      |                  O(n log n) | FFT variants           | FFT for arbitrary lengths.                           |
| Misc Algorithms        | Fast Walsh–Hadamard Transform                |                  O(n log n) | Transform              | Convolution for XOR-type transforms.                 |
| Misc Algorithms        | Median of Medians                            |                  O(n) worst | Selection              | Deterministic linear-time selection.                 |
| Misc Algorithms        | Quickselect                                  |                    O(n) avg | Selection              | Partition-based selection for k-th order.            |
| Misc Algorithms        | Reservoir Sampling (Vitter’s)                |                        O(n) | Streaming              | More efficient reservoir variants.                   |
| Misc Algorithms        | Boyer–Moore–Horspool                         |                    O(n) avg | String                 | Practical simplified BM variant.                     |
| Misc Algorithms        | Z-Algorithm                                  |                        O(n) | String                 | Z-array for pattern matching & borders.              |
| Misc Algorithms        | Ullman Subgraph Isomorphism                  |                 Exponential | Graph                  | Subgraph matching brute force.                       |
| Misc Algorithms        | VF2 Algorithm                                |                 Exponential | Graph                  | Practical subgraph isomorphism heuristics.           |
| Misc Algorithms        | Weisfeiler–Lehman                            |                  Polynomial | Graph                  | Graph isomorphism heuristic feature hashing.         |
| Misc Algorithms        | Graph Neural Network (GNN) message passing   |                    Variable | Deep Learning          | Learn graph-structured data representations.         |
| Misc Algorithms        | Reservoir Sampling (Algorithm R)             |                        O(n) | Streaming              | Standard uniform sampling algorithm.                 |
| Misc Algorithms        | Elias Gamma/Delta Coding                     |                        O(n) | Integer Coding         | Variable-length integer encoding.                    |
| Misc Algorithms        | Golomb Coding                                |                        O(n) | Entropy                | Optimal for geometric distributions.                 |
| Misc Algorithms        | Arithmetic Progression Sieve                 |              O(n log log n) | Sieve                  | Specialized counting/sieving variants.               |
| Misc Algorithms        | Sieve of Eratosthenes                        |              O(n log log n) | Sieve                  | Simple fast prime sieve.                             |
| Misc Algorithms        | Sieve of Atkin                               |                        O(n) | Sieve                  | Modern sieve with low constant factors.              |
| Misc Algorithms        | Brent–Kung Parallel Prefix                   |                        O(n) | Parallel               | Fast prefix sums in parallel.                        |
| Misc Algorithms        | Gray Code generation                         |               O(1) per code | Combinatorics          | Single-bit-change sequence generation.               |
| Misc Algorithms        | De Bruijn Sequence generation                |                        O(n) | Combinatorics          | Cyclic sequences covering all substrings.            |
| Misc Algorithms        | Huffman Adaptive                             |                  O(n log n) | Compression            | Online Huffman adaptation.                           |
| Misc Algorithms        | Arithmetic Coding with Range/ANS             |                        O(n) | Compression            | High-performance entropy coding variants.            |
| Misc Algorithms        | Range Minimum Query (RMQ)                    |                  O(1) query | Data Structure         | Sparse table for static RMQ.                         |
| Misc Algorithms        | Lowest Common Ancestor (LCA - Tarjan/ RMQ)   |                  O(1) query | Tree                   | Fast LCA via Euler+RMQ or binary lifting.            |
| Misc Algorithms        | Heavy-Light Decomposition                    |                   O(log² n) | Tree DS                | Decompose tree for path queries.                     |
| Misc Algorithms        | Euler Tour Technique                         |                        O(n) | Tree                   | Convert tree queries into array queries.             |
| Misc Algorithms        | Persistent Data Structures                   |                    O(log n) | DS                     | Immutable versions for past states.                  |
| Misc Algorithms        | Functional Persistent Segment Tree           |                    O(log n) | Persistent DS          | Versioned segment tree via persistence.              |
| Misc Algorithms        | Rope Data Structure                          |                    O(log n) | String DS              | Efficient mutable string for many edits.             |
| Misc Algorithms        | Suffix Automaton (repeated)                  |                        O(n) | String                 | Compact automaton for substring queries.             |