# Digital assistance for victims of crimes

## Domain model

![alt text](assets/images/class_diagram.png)
A TreeNode represents a node in the tree. It might have a FiniteDecisionOutcome and multiple DecisionOptions that can be taken from that TreeNode. A DecisionOption is an option that "connects" two TreeNodes and represents a possible option that leads from startNode to endNode. In addition, a DecisionOption has a DecisionOptionDescription. Currently, this only contains a textual representation, but might be extended with Markdown/Images.

[Apollon Edit-Link](https://apollon.ase.in.tum.de/6XIr1wSP3LB8t1jTxDIH?view=COLLABORATE)

## Data model

The data is split into two different JSON-files to avoid redundancy.

The first file holds information about the nodes, but not about the relationship (decision options in context) to other notes. Some important notes:

- "id" (mandatory): Unique identifier of the node, used for matching.
- "isRoot" (optional): Exactly one node must have "isRoot" set to true. This is the root node of the tree.
- "description" (optional): A description.
- "question" (optional): A question on the current node. Might be null, if no options are available.
- "outcome" (optional): The (finite) outcome of a note.

```json
[
  {
    "id": "n0",
    "isRoot": true,
    "description": "Beschreibung",
    "question": "Wurde dir körperlicher/geistiger Schaden zugefügt?"
  },
  {
    "id": "n1.1",
    "description": "Beschreibung",
    "question": "Mit einem Gegenstand?"
  },
  {
    "id": "n1.2",
    "description": "Beschreibung",
    "outcome": { "successful": false }
  },
  {
    "id": "n2.1",
    "description": "Beschreibung",
    "outcome": {
      "successful": true,
      "outcomeResult": "Schwere Körperverletzung"
    }
  }
]
```

The second file holds information about the relationship between nodes, i.e. the decision options:

- "id" (required): Unique identifier of the option, required for matching.
- "startNodeId" (required): ID of the node from which the option can be taken from.
- "endNodeId" (required): ID of the node that chosing this option leads to.
- "description" (required): (Textual) description of the option.

```json
[
  {
    "id": "op1.1",
    "startNodeId": "n0",
    "endNodeId": "n1.1",
    "description": {
      "text": "Ja"
    }
  },
  {
    "id": "op1.2",
    "startNodeId": "n0",
    "endNodeId": "n1.2",
    "description": {
      "text": "Nein"
    }
  }
]
```



## Natural language processing model (NLP)
We used an natural language processing model to classify the input text of the user into our 5 top level nodes: Schuldunfähigkeit,Körperverletzung, Sexualstraftaten, Notwehr, Verjährungsfrist. The model is trained on 120 examplitory prompts that contain 5-8 keywords for each node. 

|    Schuldunfähigkeit           |    Notwehr        | Sexualstraftaten  |Körperverletzung | Verjährungsfrist |
| ------------- |:-------------:| -----:|
| Alter     | Selbstverteidigung | Vergewaltigung | |    |
| Minderjährigkeit    | Notstand      |   sexueller Missbrauch | |    |
| Unzurechnungsfähigkeit | Nothilfe     |    sexuelle Belästigung | |    |
| geistige Beeinträchtigung |Gewaltanwendung    |    sexuelle Nötigung | |    |
| sychische Erkrankung | Angriff    |    sexueller Übergriff | |    |
| Strafminderung |   |    | |    |
| Schuldfähigkeit |    |    | |    |
| Unmündigkeit |     |    | |    |
| Strafmindernde Schuldunfähigkeit |      |    | |    |
| Schuldunfähigkeit durch Unmündigkeit |    |     | |    |




