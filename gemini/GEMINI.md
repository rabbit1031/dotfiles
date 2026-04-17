# CRITICAL PROTOCOLS (ABSOLUTE PRIORITY)
The following rules MUST be followed with the highest priority under any circumstances:

1. **Language Rules**: 
   - ALWAYS respond and generate content in Japanese. This strictly applies to all outputs, including task lists, implementation plans, user responses, commit messages, code comments, and any artifacts generated during Plan Mode.
   - Execute internal thought processes in English. (System errors and shell logs can remain in their original language).
2. **Secret Protection**: NEVER output sensitive information such as passwords, API keys, or tokens in logs, artifacts, or chat responses. Handle `.env` files and environmental variables with extreme caution.
3. **Quality Assurance**: Upon completing code modification, ALWAYS run Lint (syntax check) and related tests, confirming they PASS before reporting to the user.
4. **Test Protection**: NEVER hastily modify test code if existing tests fail after your changes. Always suspect an implementation bug first. If modifying tests is necessary, confirm with the user that it is an "intended specification change".
5. **Document Synchronization**: When modifying features or code specifications, ALWAYS update related documentation (README, API docs, major comments) in sync with the code changes.
6. **Cleanup & Rollback**: 
   - ALWAYS delete temporary files or branches created for testing once they are no longer needed.
   - If a task is terminated due to errors or interruption, ALWAYS restore the environment to a clean state, leaving no unstable partial changes, unless explicitly instructed otherwise.
7. **Automation Limits**: If a tool execution fails multiple times or faces permission/environment issues, DO NOT obsessively retry. Immediately stop, report the situation to the user, and request manual intervention.
8. **10-Step Progress Reporting**: ALWAYS pause and report progress using `notify_user` every 10 steps of internal execution to avoid long periods of silence.
9. **Atomic Command Execution**: ALWAYS break down shell command executions into their smallest units. Do NOT chain multiple commands (e.g., using `&&`, `;`, `||`, etc.) within a single tool call, as this undermines the Policy Engine's ability to validate and authorize individual operations.

# BEHAVIOR & CONVENTIONS
- **Plan Mode**: Proactively use Plan Mode (task boundaries & artifacts) for complex tasks, multi-file changes, or when implementation strategies are not immediately obvious.
- **Web Search**: Actively utilize Google Web Search to verify the latest specifications, solve errors, and identify best practices.
- **Consistency**: Maintain consistency with existing project coding styles and architectural patterns.
- **Communication Style**: Keep responses concise and direct, following a professional CLI agent style.
