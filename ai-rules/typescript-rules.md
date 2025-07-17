# Rule: typescript-rules

## Description
TypeScript-specific guidelines and workflows for Claude Code, emphasizing type safety, code quality, and modern development practices.

## Prerequisites
- Node.js and npm installed
- TypeScript installed (locally or globally)
- Code editor with TypeScript support
- Target environment accessible (browser/Node.js)

## Extends
- Base: /CLAUDE.md

## Steps

### 1. Project Setup
- Use npm, yarn, or pnpm consistently within project
- Configure TypeScript with strict settings
- Set up package.json with proper scripts
- Distinguish between dependencies and devDependencies

### 2. TypeScript Configuration
- Always use `tsconfig.json` with strict settings
- Configure proper compilation options
- Set up appropriate include/exclude patterns
- Enable strict type checking

### 3. Code Quality Setup
- Install and configure ESLint with TypeScript support
- Set up Prettier for code formatting
- Configure Jest for testing with ts-jest
- Set up proper linting rules

### 4. Development Workflow
- Use strict typing, avoid `any` type
- Create proper interfaces and types
- Implement type guards for runtime checking
- Follow consistent naming conventions

### 5. Testing and Validation
- Set up Jest with TypeScript support
- Create tests alongside source files
- Implement runtime validation for external inputs
- Use structured error handling

## Configuration

### Files Created
- `tsconfig.json` - TypeScript configuration
- `jest.config.js` - Jest test configuration
- `.eslintrc.json` - ESLint configuration
- `.prettierrc` - Prettier configuration
- `src/` - Source code directory
- `dist/` - Compiled output directory

### Files Modified
- `package.json` - Add scripts and dependencies
- `.claude-commands.memory` - Add typescript-rules.md to initialization list

## Post-Setup
1. Install dependencies: `npm install -D typescript @types/node ts-node nodemon`
2. Initialize TypeScript: `npx tsc --init`
3. Run type check: `npm run typecheck`
4. Run tests: `npm test`
5. Run linter: `npm run lint`

## Environment Management

### Project Setup Rules
- **Package manager**: use npm, yarn, or pnpm consistently within project
- **TypeScript config**: always use `tsconfig.json` with strict settings
- **Package.json**: maintain proper scripts for build, test, lint, and dev
- **Dependencies**: distinguish between dependencies and devDependencies
- **Lock files**: commit package-lock.json, yarn.lock, or pnpm-lock.yaml

### TypeScript Configuration
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020"],
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "declaration": true,
    "sourceMap": true,
    "noImplicitReturns": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
}
```

## Code Quality and Structure

### Type Safety Rules
- **Strict typing**: always use strict TypeScript settings, avoid `any` type
- **Type definitions**: create proper interfaces and types for all data structures
- **Type exports**: export types and interfaces from dedicated files when reused
- **Generic types**: use generics for reusable components and functions
- **Type guards**: implement type guards for runtime type checking

### No Hardcoding Rules
- **No hardcoding**: **must not** hardcode URLs, API endpoints, or configuration values
- **Environment variables**: use environment variables for configuration
- **Constants**: create dedicated constants files for application-wide values
- **Configuration objects**: use typed configuration objects, never inline values

### Code Organization Rules
- **File structure**: organize files by feature/domain, not by file type
- **Barrel exports**: use index.ts files for clean imports
- **Module boundaries**: clearly separate concerns between modules
- **Naming conventions**: use PascalCase for types/interfaces, camelCase for variables/functions

## Development Workflow

### Project Initialization
```bash
# Initialize new TypeScript project
npm init -y
npm install -D typescript @types/node ts-node nodemon
npm install -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install -D prettier
npm install -D jest @types/jest ts-jest

# Initialize TypeScript config
npx tsc --init

# Initialize ESLint config
npx eslint --init
```

### Essential Scripts
```json
{
  "scripts": {
    "build": "tsc",
    "dev": "ts-node src/index.ts",
    "watch": "nodemon --exec ts-node src/index.ts",
    "test": "jest",
    "test:watch": "jest --watch",
    "lint": "eslint src/**/*.ts",
    "lint:fix": "eslint src/**/*.ts --fix",
    "format": "prettier --write src/**/*.ts",
    "typecheck": "tsc --noEmit"
  }
}
```

## Testing Strategy

Refer to CLAUDE.md "Testing Framework and Strategy" section for general testing principles.

### TypeScript-Specific Testing
- **Framework**: Jest with ts-jest for TypeScript support
- **File naming**: Use `.test.ts` or `.spec.ts` extensions
- **Type testing**: Test both runtime behavior and type correctness

### Test Configuration
```javascript
// jest.config.js
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src'],
  testMatch: ['**/__tests__/**/*.ts', '**/?(*.)+(spec|test).ts'],
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.d.ts',
    '!src/**/*.test.ts'
  ]
};
```

## Error Handling and Validation

### Error Handling Rules
- **Custom errors**: create typed error classes for different error types
- **Result types**: use Result<T, E> pattern for functions that can fail
- **Error boundaries**: implement proper error boundaries in applications
- **Logging**: use structured logging with proper type safety

### Input Validation
- **Runtime validation**: use libraries like Zod or Joi for runtime type checking
- **API validation**: validate all external inputs at runtime
- **Type assertions**: avoid type assertions, prefer type guards
- **JSON parsing**: never trust JSON.parse, always validate parsed data

## Build and Deployment

### Build Process
- **Compilation**: always build with `tsc` for production
- **Output verification**: verify compiled JavaScript matches expected output
- **Source maps**: include source maps for debugging
- **Bundle analysis**: analyze bundle size for web applications

### Production Considerations
- **Environment detection**: properly detect and handle different environments
- **Performance**: optimize for production (minification, tree shaking)
- **Monitoring**: implement proper error reporting and monitoring
- **Security**: sanitize inputs and validate all external data

## Integration Requirements

### Package.json Requirements
```json
{
  "main": "dist/index.js",
  "types": "dist/index.d.ts",
  "files": ["dist"],
  "engines": {
    "node": ">=16.0.0"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/node": "^20.0.0",
    "ts-node": "^10.0.0",
    "eslint": "^8.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "prettier": "^3.0.0",
    "jest": "^29.0.0",
    "@types/jest": "^29.0.0",
    "ts-jest": "^29.0.0"
  }
}
```

### ESLint Configuration
```json
{
  "extends": [
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json"
  },
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-explicit-any": "error"
  }
}
```

## Memory Integration

After using this rule, Claude must:

- **1.** Check if `.claude-commands.memory` file exists - if not, create it with initial content:
```
## read these files upon initialization

```

- **2.** Check if `- /ai-rules/typescript-rules.md` is listed under section `## read these files upon initialization` in `.claude-commands.memory`
- **3.** If not listed: add `- /ai-rules/typescript-rules.md` to list under section `## read these files upon initialization` in `.claude-commands.memory`