PyBBN
-----

PyBBN is Python library for Bayesian Belief Networks (BBNs) exact inference using the
`junction tree algorithm <https://en.wikipedia.org/wiki/Junction_tree_algorithm>`_ or Probability
Propagation in Trees of Clusters. The implementation is taken directly from `C. Huang and A. Darwiche, "Inference in
Belief Networks: A Procedural Guide," in International Journal of Approximate Reasoning, vol. 15,
pp. 225--263, 1999 <http://pages.cs.wisc.edu/~dpage/ijar95.pdf>`_. Additionally, there is
the ability to generate singly- and multi-connected graphs, which is taken from `JS Ide and FG Cozman,
"Random Generation of Bayesian Network," in Advances in Artificial Intelligence, Lecture Notes in Computer Science, vol 2507 <https://pdfs.semanticscholar.org/5273/2fb57129443592024b0e7e46c2a1ec36639c.pdf>`_.
There is also the option to generate sample data from your BBN. This synthetic data may be summarized to generate your
posterior marginal probabilities and work as a form of approximate inference. Lastly, we have
added Pearl's `do-operator` for causal inference.

Power Up, Next Level
--------------------

If you like py-bbn, please inquire about our next-generation products below! info@oneoffcoder.com

* `turing_bbn <https://turing-bbn.oneoffcoder.com/>`_ is a C++17 implementation of py-bbn; take your causal and probabilistic inferences to the next computing level!
* `pyspark-bbn <https://pyspark-bbn.oneoffcoder.com/>`_ is a is a scalable, massively parallel processing MPP framework for learning structures and parameters of Bayesian Belief Networks BBNs using `Apache Spark <https://spark.apache.org/>`_.


Exact Inference Usage
---------------------

Below is an example code to create a Bayesian Belief Network, transform it into a join tree,
and then set observation evidence. The last line prints the marginal probabilities for each node.

.. code:: python

    from pybbn.graph.dag import Bbn
    from pybbn.graph.edge import Edge, EdgeType
    from pybbn.graph.jointree import EvidenceBuilder
    from pybbn.graph.node import BbnNode
    from pybbn.graph.variable import Variable
    from pybbn.pptc.inferencecontroller import InferenceController

    # create the nodes
    a = BbnNode(Variable(0, 'a', ['on', 'off']), [0.5, 0.5])
    b = BbnNode(Variable(1, 'b', ['on', 'off']), [0.5, 0.5, 0.4, 0.6])
    c = BbnNode(Variable(2, 'c', ['on', 'off']), [0.7, 0.3, 0.2, 0.8])
    d = BbnNode(Variable(3, 'd', ['on', 'off']), [0.9, 0.1, 0.5, 0.5])
    e = BbnNode(Variable(4, 'e', ['on', 'off']), [0.3, 0.7, 0.6, 0.4])
    f = BbnNode(Variable(5, 'f', ['on', 'off']), [0.01, 0.99, 0.01, 0.99, 0.01, 0.99, 0.99, 0.01])
    g = BbnNode(Variable(6, 'g', ['on', 'off']), [0.8, 0.2, 0.1, 0.9])
    h = BbnNode(Variable(7, 'h', ['on', 'off']), [0.05, 0.95, 0.95, 0.05, 0.95, 0.05, 0.95, 0.05])

    # create the network structure
    bbn = Bbn() \
        .add_node(a) \
        .add_node(b) \
        .add_node(c) \
        .add_node(d) \
        .add_node(e) \
        .add_node(f) \
        .add_node(g) \
        .add_node(h) \
        .add_edge(Edge(a, b, EdgeType.DIRECTED)) \
        .add_edge(Edge(a, c, EdgeType.DIRECTED)) \
        .add_edge(Edge(b, d, EdgeType.DIRECTED)) \
        .add_edge(Edge(c, e, EdgeType.DIRECTED)) \
        .add_edge(Edge(d, f, EdgeType.DIRECTED)) \
        .add_edge(Edge(e, f, EdgeType.DIRECTED)) \
        .add_edge(Edge(c, g, EdgeType.DIRECTED)) \
        .add_edge(Edge(e, h, EdgeType.DIRECTED)) \
        .add_edge(Edge(g, h, EdgeType.DIRECTED))

    # convert the BBN to a join tree
    join_tree = InferenceController.apply(bbn)

    # insert an observation evidence
    ev = EvidenceBuilder() \
        .with_node(join_tree.get_bbn_node_by_name('a')) \
        .with_evidence('on', 1.0) \
        .build()
    join_tree.set_observation(ev)

    # print the marginal probabilities
    for node in join_tree.get_bbn_nodes():
        potential = join_tree.get_bbn_potential(node)
        print(node)
        print(potential)

Building
--------

To build, you will need Python 3.7. Managing environments through `Anaconda <https://www.anaconda.com/download/#linux>`_
is highly recommended to be able to build this project (though not absolutely required if you know
what you are doing). Assuming you have installed Anaconda, you may create an environment as
follows (make sure you `cd` into the root of this project's location).

.. code:: bash

    conda env create -f environment.yml
    conda activate pybbn37
    python -m ipykernel install --user --name pybbn37 --display-name "pybbn37"


Then you may build the project as follows. (Note that in Python 3.6 you will get some warnings).


.. code:: bash

    make build


To build the documents, go into the docs sub-directory and type in the following.

.. code:: bash

    make html


Installing
----------

Use pip to install the package as it has been published to `PyPi <https://pypi.python.org/pypi/pybbn>`_.

.. code:: bash

    pip install pybbn


Other Python Bayesian Belief Network Inference Libraries
--------------------------------------------------------

Here is a list of other Python libraries for inference in Bayesian Belief Networks.

* `BayesPy <https://github.com/bayespy/bayespy>`_
* `pomegranate <https://github.com/jmschrei/pomegranate>`_
* `pgmpy <https://github.com/pgmpy/pgmpy>`_
* `libpgm <https://github.com/CyberPoint/libpgm>`_
* `bayesnetinference <https://github.com/sonph/bayesnetinference>`_

I found other `packages <https://pypi.python.org/pypi?%3Aaction=search&term=bayesian+network&submit=search>`_ in PyPI too.

Citation
--------

.. code::

    @misc{vang_2017,
    title={PyBBN},
    url={https://github.com/vangj/py-bbn/},
    journal={GitHub},
    author={Vang, Jee},
    year={2017},
    month={Jan}}


Copyright Stuff
---------------

.. code::

    Copyright 2017 Jee Vang

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
