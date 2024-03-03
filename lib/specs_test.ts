import { assertEquals, AssertionError, assertObjectMatch } from "@std/assert";
import { ClosedGroup, Group, PluginSpec } from "./specs.ts";

const assert = (actual: PluginSpec[], expected: PluginSpec[]) => {
  assertEquals(actual.length, 2);
  assertMatch(actual[0], expected[0]);
  assertMatch(actual[1], expected[1]);
};

const assertMatch = (
  actual: Record<PropertyKey, unknown> | string,
  expected: Record<PropertyKey, unknown> | string,
) => {
  if (typeof expected === "string") {
    assertEquals(actual, expected);
  } else {
    if (typeof actual === "string") {
      throw new AssertionError("actual is string");
    }
    assertObjectMatch(actual, expected);
  }
};

const expectedGroup = [
  {
    repo: "Shougo/dpp.vim",
    lazy: false,
    rtp: "",
  },
  {
    repo: "Shougo/dpp-ext-lazy",
    depends: ["dpp.vim"],
    lazy: false,
    rtp: "",
  },
] satisfies PluginSpec[];

Deno.test("Group", () => {
  assert(
    Group({ lazy: false, rtp: "" }, [
      {
        repo: "Shougo/dpp.vim",
      },
      {
        repo: "Shougo/dpp-ext-lazy",
        depends: ["dpp.vim"],
      },
    ]),
    expectedGroup,
  );
});

Deno.test("Group - nested", () => {
  assert(
    Group({ lazy: false, rtp: "" }, [
      {
        repo: "Shougo/dpp.vim",
      },
      ...Group({ depends: ["dpp.vim"] }, [
        {
          repo: "Shougo/dpp-ext-lazy",
        },
      ]),
    ]),
    expectedGroup,
  );
});

const expectedClosedGroup = [
  {
    repo: "Shougo/dpp.vim",
  },
  {
    repo: "Shougo/dpp-ext-lazy",
    depends: ["dpp.vim"],
  },
] satisfies ClosedGroup<"Shougo/dpp.vim" | "Shougo/dpp-ext-lazy">;

Deno.test("ClosedGroup", () => {
  assert(
    ClosedGroup(
      {
        repo: "Shougo/dpp.vim",
      },
      {
        repo: "Shougo/dpp-ext-lazy",
        depends: ["dpp.vim"],
      },
    ),
    expectedClosedGroup,
  );
});

Deno.test("ClosedGroup - nested Groups", () => {
  assert(
    ClosedGroup(
      {
        repo: "Shougo/dpp.vim",
      },
      ...Group({ depends: ["dpp.vim"] }, [
        { repo: "Shougo/dpp-ext-lazy" },
      ]),
    ),
    expectedClosedGroup,
  );
});

Deno.test("ClosedGroup - top-level Group", () => {
  assert(
    ClosedGroup(...Group({ lazy: false, rtp: "" }, [
      {
        repo: "Shougo/dpp.vim",
      },
      {
        repo: "Shougo/dpp-ext-lazy",
        depends: ["dpp.vim"],
      },
    ])),
    expectedClosedGroup,
  );
});
