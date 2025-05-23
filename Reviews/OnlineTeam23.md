**40284702 - Victor Bruson - Team: AVM Query**

**Team #23 (Name), project title: Book Stuff**

**Overall Presentation: A+**

The team managed to show a clear and detailed explanation of their work during both phases. They demonstrated how they populated their relational database in phase one, the queries they wrote to retrieve data, and their ERD.

**Complexity/Applicability of the database application: A-**

There was a minor issue in the design of the database structure for the ISA relationship. The team modeled Book Availability as a subclass of the Book entity. In their model, this entity(Book Availability) added some extra attributes such as price, currency, etc, for the Book. However, these attributes are more of a weak entity rather than ISA. Also, Book Availability cannot exist independently of a Book, so it would be more appropriate to model it as a weak entity. This adjustment would improve the clarity of the ERD and provide more accurate data representation.

**Use of technology: A+**

This team used PostgreSQL for a relational database and Neo4j for their NoSQL. This choice was appropriate regarding the requirements of the project. Both of these technologies provide a flexible and manageable interface for the team to make working on this project easier.

**The presentation addresses all challenges: A+**

The team provided very detailed information regarding their project challenges. One of the challenges they faced was that the two APIs they chose didn’t have any shared identifier. They explained that they solved this issue by using a different attribute and matching the data based on that(Author’s name).

**Teamwork and participation: A+**

It was not mentioned how they distributed the work among themselves during the implementation phase. However, they showed very good participation from all the team members during the presentation.

**Additional comment/suggestion:**

Everything was planned perfectly in the team’s presentation. However, it can help them to review their ERD and the modeling of their structure more carefully.
