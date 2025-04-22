**40187433 - Ana Rostam - Team: AVM Query**

**Team #20 (Cardinality 3),  project title: About football**

**Overall Presentation: A+**

The team had a well-structured presentation, showcasing their project through their comprehensive and detailed slides. Their slides clearly pointed out their key queries that were used in their system and provided a detailed explanation of their ERD model.

**Complexity/Applicability of the database application: B+**

The team’s database design shows their understanding of the complexity in managing the data. However, the team’s decision on handling the ISA relationship with a weak entity is not practical. 

In the ERD that was presented in the slides, the team combined an ISA relationship with a weak entity relationship, which is not a good practice. In an ISA relationship, the subclass inherits the identifier from the superclass, this means that they are not weak entities but just a specialization. Instead of treating the ISA subclasses as weak entities, the team could have implemented a different entity with no unique identifier of its own and made that the weak entity. For example, they could have added additional information for one of their entities and modeled it as a weak entity. This could have improved the structure of their ERD. 

**Use of technology: A+**

The team used MS-SQL for their relational database and MongoDB for their NoSQL database, which are both good choices for the scope of this project. They both support cloud hosting for the database, which is one of the project’s requirements to enable remote access and collaborative data management for the group

**The presentation addresses all challenges: A+**

Their presentation provided a good understanding of the challenge they faced with the API’s data limit and how they had to change the API they used multiple times in order to find one that can help them populate the database for the size that was required by the project.

**Teamwork and participation: A+**

The team did not mention how the work was divided between them during the implementation phase. However, based on their participation and distribution of the presentation among all three members, it appears that the workload was separated fairly among them.

**Additional comment/suggestion:**

The team’s project demonstrates a strong understanding of the requirements of the project and resolves its challenges. However, refining their conceptual design of the database could enhance the clarity of the data.
