// Script to parse Deno test output
// Usage: deno run parse-deno-test-output.ts <argument>

// Get command line arguments (excluding runtime and script name)
const args = Deno.args;

if (args.length === 0) {
    console.log('No arguments provided. Please provide an argument.');
    Deno.exit(1);
}
const text = await Deno.readTextFile(args[0]);
const TestMap = {}; // TODO
try {
    const lines = text.split('\n');
    const output = { success: true, lines: lines.length };
    console.log(JSON.stringify(output, null, 2));
} catch (error) {
    console.log(JSON.stringify({ success: false, error: 'failed_to_parse' }, null, 2));
}

function parseTestOutput(text: string): { success: boolean; lines: number } {
    const lines = text.split('\n');
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        const testNameLine = isTestNameLine(line);
        if (testNameLine) {
            console.log(testNameLine);
        }
    }
    return { success: true, lines: lines.length };
}

function isTestNameLine(
    line: string,
): { type: 'begin' | 'ignored' | 'failed' | 'ok'; durationMs: number; testName: string } | null {
    // example begin ignored: secondYTest ... ignored (0ms)
    // example begin failure/ok: secondTest ...
    // example end failure: secondTest ... FAILED (1ms)
    // example end ok: secondXTest ... ok (0ms)

    // Check for beginning of test (ends with "...")
    const beginMatch = line.match(/^(.+?)\s\.\.\.$/);
    if (beginMatch) {
        return {
            type: 'begin',
            durationMs: 0,
            testName: beginMatch[1].trim(),
        };
    }

    // Check for end of test with result
    const endMatch = line.match(/^(.+?)\s\.\.\.\s(FAILED|ok|ignored)\s\((\d+)ms\)$/);
    if (endMatch) {
        const testName = endMatch[1].trim();
        const resultType = endMatch[2].toLowerCase();
        const duration = parseInt(endMatch[3], 10);

        return {
            type: resultType === 'failed' ? 'failed' : (resultType as 'ignored' | 'ok'),
            durationMs: duration,
            testName: testName,
        };
    }

    return null;
}
