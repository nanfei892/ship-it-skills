#!/usr/bin/env python3
"""Generate a consistent MVP blueprint from a compact JSON product brief."""

import argparse
import json
from pathlib import Path
from typing import Any


REQUIRED = ("product_name", "primary_user", "job", "success_signal")


def text_list(value: Any, field: str) -> list[str]:
    if value is None:
        return []
    if not isinstance(value, list) or not all(isinstance(item, str) and item.strip() for item in value):
        raise ValueError(f"'{field}' must be an array of non-empty strings")
    return [item.strip() for item in value]


def markdown_cell(value: str) -> str:
    return value.replace("|", "\\|").replace("\n", " ")


def column(items: list[str]) -> str:
    return "<br>".join(markdown_cell(item) for item in items) or "-"


def render(brief: dict[str, Any]) -> str:
    missing = [field for field in REQUIRED if not isinstance(brief.get(field), str) or not brief[field].strip()]
    if missing:
        raise ValueError("Missing required non-empty string fields: " + ", ".join(missing))

    assumptions = text_list(brief.get("assumptions"), "assumptions")
    now = text_list(brief.get("now"), "now")
    next_items = text_list(brief.get("next"), "next")
    not_now = text_list(brief.get("not_now"), "not_now")
    flow = text_list(brief.get("flow"), "flow")
    risks = brief.get("risks", [])
    if not isinstance(risks, list) or not all(isinstance(item, dict) for item in risks):
        raise ValueError("'risks' must be an array of objects")

    assumption_lines = [f"- {item}" for item in assumptions] or ["- None supplied."]
    flow_lines = [f"{index}. {step}" for index, step in enumerate(flow, start=1)]
    if not flow_lines:
        flow_lines = ["1. Define the first end-to-end user journey."]

    lines = [
        f"# {brief['product_name'].strip()} MVP Blueprint",
        "",
        "## Outcome",
        f"- **Primary user:** {brief['primary_user'].strip()}",
        f"- **Job:** {brief['job'].strip()}",
        f"- **Success signal:** {brief['success_signal'].strip()}",
        "",
        "## Assumptions",
        *assumption_lines,
        "",
        "## MVP Scope",
        "| Now | Next | Not now |",
        "| --- | --- | --- |",
        f"| {column(now)} | {column(next_items)} | {column(not_now)} |",
        "",
        "## Core User Flow",
        *flow_lines,
        "",
        "## Requirements and Acceptance Criteria",
    ]
    if now:
        for capability in now:
            lines.extend([
                f"### {capability}",
                f"- Requirement: Enable the primary user to {capability.lower()}.",
                f"- Given the user can access this capability, when they complete the required action, then they receive a clear successful result.",
                "- Empty, loading, error, and permission states: Define the relevant states before implementation.",
                "",
            ])
    else:
        lines.extend(["- Define at least one `Now` capability before implementation.", ""])

    lines.extend([
        "## Technical Shape",
        "- **Recommended stack:** Choose after inspecting product constraints and any existing repository.",
        "- **Data entities:** Define only entities required by `Now` scope.",
        "- **Interfaces/integrations:** Prefer local or mocked boundaries until an external dependency is approved.",
        "- **Security and privacy:** List constraints supported by the brief and open questions.",
        "",
        "## Build Plan",
        "1. Validate the core user flow with the smallest usable interface.",
        "2. Implement each `Now` capability in dependency order with its acceptance checks.",
        "3. Test the happy path and the highest-risk failure state before launch.",
        "",
        "## Risks and Validation",
        "| Risk | Cheapest validation | Decision after result |",
        "| --- | --- | --- |",
    ])
    if risks:
        for risk in risks:
            lines.append(
                "| "
                + " | ".join(markdown_cell(str(risk.get(key, "Define"))) for key in ("risk", "validation", "decision"))
                + " |"
            )
    else:
        lines.append("| Define the largest unknown | Run the smallest credible test | State the next scope decision |")
    return "\n".join(lines) + "\n"


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate an MVP blueprint from a JSON brief.")
    parser.add_argument("--input", required=True, type=Path, help="Path to a JSON product brief")
    parser.add_argument("--output", required=True, type=Path, help="Markdown file to create")
    args = parser.parse_args()

    try:
        brief = json.loads(args.input.read_text(encoding="utf-8"))
        if not isinstance(brief, dict):
            raise ValueError("The JSON root must be an object")
        output = render(brief)
    except (OSError, json.JSONDecodeError, ValueError) as error:
        raise SystemExit(f"Error: {error}") from error

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(output, encoding="utf-8")
    print(f"Created {args.output}")


if __name__ == "__main__":
    main()
