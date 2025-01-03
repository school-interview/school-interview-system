"""InterviewQuestionのcondition_value_typeを削除

Revision ID: cfa10eb82f36
Revises: 9164bc7d20d8
Create Date: 2024-12-01 15:22:17.705773

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'cfa10eb82f36'
down_revision: Union[str, None] = '9164bc7d20d8'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('InterviewQuestions', 'condition_target_operand_data_type')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('InterviewQuestions', sa.Column('condition_target_operand_data_type', sa.VARCHAR(length=5), autoincrement=False, nullable=True))
    # ### end Alembic commands ###
