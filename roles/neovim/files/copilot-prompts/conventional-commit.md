Given the following staged git diff, generate a conventional commit message that:

1. Summarizes the changes in a concise, meaningful way.
2. Uses conventional commit types (feat, fix, docs, style, refactor, test, chore).
   - `feat`: A new feature.
   - `fix`: A bug fix.
   - `docs`: Documentation changes.
   - `style`: Changes that do not affect the meaning of the code (white-space, formatting, etc.).
   - `refactor`: Changes that rewrite or restructure code without altering behavior
   - `test`: Adding or updating tests.
   - `chore`: Miscellaneous changes to the build process, dependencies, tools, libraries or repository structure.
3. Follows the format: `<type>(<scope>): <summary>`.
4. Includes a short summary line and an optional detailed description.
5. Does not exceed 72 characters in the summary line.
6. Is clear and actionable for the project history.

--- BEGIN DIFF ---
