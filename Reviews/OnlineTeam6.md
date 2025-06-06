**40284245 - Manel Hellou - Team: AVM Query**  

**Team #6 (Lost Keys), project title: Star Wars**

**Overall Presentation: A+**

The team delivered a clear and detailed presentation, addressing all the requirements for the project. They showcased their key queries, explained their ERD model, and the challenges they faced during the implementation of both phases.

**Complexity/Applicability of the database application: A-**

One of the challenges that was mentioned during the presentation was preserving the ISA relationship after the migration of data to a NoSQL database. While this was the team’s choice to retain this structure, it is a better practice if they eliminated the ISA relationship (Crafts as superclass, Vehicle and Starship as subclasses) in the NoSQL context and represented the Vehicle and Starship entities separately. This would have allowed them more flexible and efficient data access.

**Use of technology: A+**

The team had a good choice of technologies they used, which were PostgreSQL for relational database and MongoDB for NoSQL. Both of these technologies are appropriate for the scope and requirements of this project.

**The presentation addresses all challenges: A+**

They addressed all the challenges they faced in detail, such as how they had to reconstruct the design of their database to be able to convert the foreign keys and many-to-many joins for the migration process and store them in MongoDB.

**Teamwork and participation: A**

It was not mentioned how they distributed the work among themselves during the implementation phase. However, they showed a good distribution of work during the presentation among the 3 members (a total of 4) who were present in the video. 

**Additional comment/suggestion:**

The team shows a good overall understanding of the project and fulfilled all the requirements that were given by the project, such as the design structure of the relational database and managing the queries. The only thing that can be improved is their use of ISA after the migration of data.
