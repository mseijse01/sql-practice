# SQL Practice Repository

My personal collection of SQL exercises for continuous learning and interview prep. Built this to practice everything from basic queries to advanced analytics through realistic business scenarios.

## What's Inside

**7 comprehensive modules** covering beginner through advanced SQL:

### Core Modules (Beginner → Intermediate)
1. **Basic SELECT** - Employee management system  
   WHERE, ORDER BY, LIKE patterns, filtering
2. **JOINs** - Company database with departments/employees  
   INNER/LEFT/RIGHT JOINs, self-joins, multiple tables
3. **GROUP BY & Aggregates** - E-commerce sales analysis  
   COUNT/SUM/AVG, HAVING, business metrics, percentages
4. **Subqueries** - University enrollment system  
   WHERE/SELECT subqueries, EXISTS, correlated queries
5. **NULL Handling** - Customer support system  
   IS NULL, COALESCE, NULLIF, edge cases

### Advanced Modules  
6. **Window Functions** - Sales analytics & BI  
   Rankings, LAG/LEAD, moving averages, PARTITION BY
7. **CTEs** - Multi-level business reporting  
   Basic & recursive CTEs, hierarchical data, query organization

## Learning Paths

### **`learning/` folder** - Learn by example
- Complete worked examples with explanations
- Schema + data + solutions all in one place
- Perfect for understanding patterns and building fundamentals

### **`interview-prep/` folder** - Test yourself  
- Challenge files with problems only (no solutions visible)
- Separate solution files to check your work
- Realistic interview simulation

## Quick Start

**Option 1: Simple SQLite setup (recommended)**
```bash
# Set up database with all practice data
sqlite3 practice.db < setup_database.sql

# Start practicing immediately
sqlite3 practice.db
sqlite> SELECT * FROM employees LIMIT 3;
```

**Option 2: Online tools**
- DB Fiddle, SQLite Online, or W3Schools SQL Tryit
- Copy/paste the CREATE and INSERT statements from any file

## My Learning Approach

**For building fundamentals:**
1. Start with `learning/01_basic_select.sql` - get comfortable with syntax
2. Progress through modules 2-5 at your own pace
3. Each file has realistic scenarios, not boring textbook examples

**For interview prep:**
1. Jump to `interview-prep/` challenges when ready
2. Time yourself - aim for 15-30 minutes per complex query  
3. Only check solutions after attempting problems yourself

**For advanced skills:**
1. Master modules 6-7 (Window Functions & CTEs)
2. These are crucial for modern data roles
3. Practice building business dashboards and analytics

## Learning Enhancements

Built some extra tools to level up the learning experience:

### [`enhancements/`](enhancements/) - Learning Support Tools

#### **Self-Assessment Quiz** ([`self_assessment_quiz.md`](enhancements/self_assessment_quiz.md))
- Multiple-choice questions for all 7 modules
- Progressive difficulty with detailed explanations
- Track your scores and identify weak spots

#### **Query Explanations Guide** ([`query_explanations.md`](enhancements/query_explanations.md))
- Step-by-step breakdowns of complex queries
- Deep dives into window functions and CTEs
- Understand the "why" behind advanced SQL patterns

#### **Common Mistakes Guide** ([`common_mistakes.md`](enhancements/common_mistakes.md))
- Learn from typical SQL errors and pitfalls
- Wrong vs. right approaches with explanations
- Quick reference for debugging and interview prep

#### **Progress Tracker** ([`progress_tracker.md`](enhancements/progress_tracker.md))
- Gamified learning with achievements and milestones
- Track completion and set personal goals
- Interview readiness assessment

### How I Use the Enhancements
1. **Progress Tracker** first to set learning goals
2. **Self-Assessment Quizzes** after each module 
3. **Common Mistakes Guide** when debugging or before interviews
4. **Query Explanations** for deep dives into complex concepts

## Interview Tips

**What I've learned works:**
- Start simple, build complexity gradually
- Always explain your approach before writing code
- Handle edge cases (NULLs, empty results, etc.)
- Practice timing yourself on realistic problems

**Common patterns that come up:**
- Basic filtering and joins (modules 1-2)
- Business metrics and aggregations (module 3)
- Complex filtering with subqueries (module 4)
- Data quality and NULL handling (module 5)
- Analytics and rankings (modules 6-7)

## Personal Notes

This repo reflects my own SQL learning journey. Started with basic queries and gradually built up to complex analytics. The scenarios are realistic because I pulled them from actual business problems I've encountered.

*“Mediocrity is invisible until passion shows up to expose it.”*